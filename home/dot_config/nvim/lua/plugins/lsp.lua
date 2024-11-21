return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    --    used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },

  { 'Bilal2453/luvit-meta', lazy = true },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',

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
          filetypes = { 'html', 'rust' },
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

      -- Improve filetypes
      vim.filetype.add {
        pattern = {
          ['.*/templates/.*%.html'] = 'html',
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
          map('gd', builtin.lsp_definitions, 'Go to definition')
          map('gD', vim.lsp.buf.declaration, 'Go to declaration')
          map('gR', builtin.lsp_references, 'Go to references')
          map('gt', builtin.lsp_type_definitions, 'Go to type definition')

          -- Fuzzy find all the symbols in the current document or workspace
          map('<leader>ssd', builtin.lsp_document_symbols, 'Search symbols in document')
          map('<leader>ssw', builtin.lsp_dynamic_workspace_symbols, 'Search symbols in workspace')

          -- Highlight references of the word under the cursor
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
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
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
      formatters_by_ft = {
        lua = { 'stylua' },
      },
    },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = 'Format buffer',
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
        require('lint').try_lint()
      end

      vim.api.nvim_create_user_command('ToggleMdlRules', toggle_mdl_rules, {})

      vim.keymap.set('n', '<leader>mr', toggle_mdl_rules, { desc = 'Toggle markdownlint rules' })
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
