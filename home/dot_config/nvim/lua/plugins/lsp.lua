return {
  -- LSP Configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Additional Lua LSP for the Neovim config, runtime and plugins
      { 'folke/neodev.nvim', opts = {} },

      -- Schema information
      'b0o/SchemaStore.nvim',
    },
    config = function()
      -- Capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Servers
      local servers = {
        clangd = true,
        html = true,
        htmx = true,
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                -- LÖVE: handle the "Undefined global `love`" warn
                globals = { 'love' },
              },
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
        markdown_oxide = true,
        nushell = { manual_install = true },
        rust_analyzer = {
          manual_install = true,
          settings = {
            ['rust-analyzer'] = {
              cargo = { allFeatures = true, loadOutDirsFromCheck = true },
              checkOnSave = { command = 'clippy' },
              procMacro = { enable = true },
              diagnostics = { enable = false },
            },
          },
        },
        tailwindcss = {
          filetypes = { 'rust' },
          init_options = {
            userLanguages = {
              rust = 'html',
            },
          },
        },
        taplo = true,
        typos_lsp = {
          init_options = {
            -- Equivalent to the typos `--config` cli argument
            config = '~/.config/typos/typos.toml',
          },
        },
      }

      local servers_to_install = vim.tbl_filter(function(key)
        local t = servers[key]
        if type(t) == 'table' then
          return not t.manual_install
        else
          return t
        end
      end, vim.tbl_keys(servers))

      -- Mason
      require('mason').setup()

      local ensure_installed = {
        'codelldb',
        'markdownlint',
      }
      vim.list_extend(ensure_installed, servers_to_install)
      require('mason-tool-installer').setup {
        ensure_installed = ensure_installed,
        auto_update = true,
      }

      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
        config = vim.tbl_deep_extend('force', {}, {
          capabilities = capabilities,
        }, config)

        require('lspconfig')[name].setup(config)
      end

      -- Add file extensions
      vim.filetype.add {
        extension = {
          nuon = 'nu',
        },
      }

      -- Attach
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local builtin = require 'telescope.builtin'

          -- Jump to the <target> of the word under the cursor
          --  To jump back, press <C-t>
          map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('gr', builtin.lsp_references, '[G]oto [R]eferences')
          map('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
          map('gt', builtin.lsp_type_definitions, '[G]oto [T]ype Definition')

          -- Fuzzy find all the symbols in the current document or workspace
          --  Symbols are things like variables, functions, types, etc
          map('<leader>ssd', builtin.lsp_document_symbols, '[S]earch [S]ymbols in [D]ocument')
          map('<leader>ssw', builtin.lsp_dynamic_workspace_symbols, '[S]earch [S]ymbols in [W]orkspace')

          -- Rename the variable under the cursor
          map('<leader>cr', vim.lsp.buf.rename, '[C]ode [R]ename')

          -- Execute a code action, usually the cursor needs to be on top of an error
          -- or a suggestion from the LSP for this to activate
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- Opens a popup that displays documentation about the word under the cursor
          --  See `:help K` for why this keymap
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- Opens a popup that displays signature information about the word under the cursor
          map('<C-s>', vim.lsp.buf.signature_help, 'Signature Documentation')

          -- Highlight references of the word under the cursor
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- Enable inlay hints if the language server supports them
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>h', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, 'Toggle Inlay [H]ints')
          end
        end,
      })

      -- Border
      require('lspconfig.ui.windows').default_options.border = 'single'
    end,
  },

  -- Autoformat
  {
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
      },
    },
  },

  -- Linting
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
      }

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          require('lint').try_lint()
        end,
      })

      -- Toggle MD031 and MD032 rules
      local mdl_rules_enabled = true
      local mdl = require('lint').linters.markdownlint

      local function toggle_mdl_rules()
        if mdl_rules_enabled then
          mdl.args = { '--disable', 'MD031', 'MD032' }
          print 'markdownlint: MD031 and MD032 disabled'
        else
          mdl.args = {}
          print 'markdownlint: MD031 and MD032 enabled'
        end
        mdl_rules_enabled = not mdl_rules_enabled
        -- Optionally trigger a linting after toggling
        require('lint').try_lint()
      end

      vim.api.nvim_create_user_command('ToggleMdlRules', toggle_mdl_rules, {})

      vim.keymap.set('n', '<leader>mr', toggle_mdl_rules, { desc = 'Toggle [M]arkdownlint [R]ules' })
    end,
  },

  -- LÖVE
  {
    'S1M0N38/love2d.nvim',
    cmd = 'LoveRun',
    opts = {},
    keys = {
      { '<leader>vv', '<cmd>LoveRun<cr>', ft = 'lua', desc = 'Run LÖVE' },
      { '<leader>vs', '<cmd>LoveStop<cr>', ft = 'lua', desc = 'Stop LÖVE' },
    },
  },
}
