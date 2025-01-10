return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
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
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Diagnostics virtual lines
      'https://git.sr.ht/~whynothugo/lsp_lines.nvim',

      -- Schema information
      'b0o/SchemaStore.nvim',

      { 'saghen/blink.cmp' },
    },
    config = function()
      -- Diagnostic options
      local signs = {
        ERROR = '',
        WARN = '',
        HINT = '󰌵',
        INFO = '',
      }
      vim.diagnostic.config {
        severity_sort = true,
        signs = false,
        underline = false,
        virtual_lines = { only_current_line = true },
        virtual_text = {
          format = function(diagnostic)
            local colon_index = string.find(diagnostic.message, ':')
            if colon_index then
              return string.sub(diagnostic.message, 1, colon_index - 1)
            end
            return diagnostic.message
          end,
          prefix = function(diagnostic)
            return signs[vim.diagnostic.severity[diagnostic.severity]]
          end,
        },
      }

      local servers = {
        -- bashls = true,
        clangd = true,
        html = true,
        jsonls = {
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                -- handle the "Undefined global" warnings
                globals = { 'love', 'Snacks' },
              },
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
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

        require('lspconfig')[name].setup(config)
      end

      vim.filetype.add {
        pattern = {
          ['.*/templates/.*%.html'] = 'html',
        },
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-setup', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the <target> of the word under the cursor
          --  To jump back, press <C-t>
          map('gD', vim.lsp.buf.declaration, 'Go to declaration')

          local fzf_lua = require 'fzf-lua'
          map('gd', fzf_lua.lsp_definitions, 'Go to definition')
          map('gR', fzf_lua.lsp_references, 'Go to references')
          map('gI', fzf_lua.lsp_implementations, 'Go to implementation')
          map('gy', fzf_lua.lsp_typedefs, 'Go to type definition')

          -- Highlight references of the word under the cursor
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
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
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
              end,
            })
          end
        end,
      })
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

      local is_enabled = false

      local function toggle_md_lint()
        if is_enabled then
          vim.diagnostic.reset(lint.get_namespace 'markdownlint')
        else
          lint.try_lint()
        end
        is_enabled = not is_enabled
      end

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
        group = vim.api.nvim_create_augroup('lint', { clear = true }),
        callback = function()
          if is_enabled then
            lint.try_lint()
          end
        end,
      })

      vim.keymap.set('n', '<leader>ml', toggle_md_lint, { desc = 'Toggle MD linting' })
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
