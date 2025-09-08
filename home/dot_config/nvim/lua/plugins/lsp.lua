return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            { path = 'snacks.nvim', words = { 'Snacks' } },
          },
        },
      },

      -- Schema information
      'b0o/SchemaStore.nvim',
    },
    config = function()
      local servers = {
        bashls = true,
        clangd = true,
        cssls = true,
        eslint = true,
        fish_lsp = true,
        html = {
          filetypes = { 'askama', 'html' },
        },
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
              -- handle the "Undefined global" warnings
              diagnostics = { globals = { 'ya' } },
              completion = { callSnippet = 'Replace' },
            },
          },
        },
        rue = {
          cmd = (#vim.fs.find('BUCK', { upward = true }) > 0)
              and { 'buck2', 'run', '//crates/rue-lsp' }
            or { 'rue-lsp' },
          filetypes = { 'rue' },
        },
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
              checkOnSave = { command = 'clippy' },
              diagnostics = { enable = false },
              procMacro = { enable = true },
              rustfmt = { extraArgs = { '+nightly' } },
            },
          },
        },
        tailwindcss = {
          filetypes = { 'askama', 'html', 'rust' },
          settings = {
            tailwindCSS = {
              includeLanguages = {
                askama = 'html',
              },
              userLanguages = { askama = 'html', rust = 'html' },
            },
          },
          root_markers = { 'input.css', '.git' },
        },
        taplo = true,
        ts_ls = true,
        typos_lsp = {
          init_options = { config = '~/.config/typos/typos.toml' },
        },
      }

      for name, config in pairs(servers) do
        if type(config) == 'table' then
          vim.lsp.config[name] = config
        end
        vim.lsp.enable(name)
      end
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
        askama = { 'kirei' },
        css = { 'prettier' },
        html = { 'prettier' },
        javascript = { 'prettier', 'eslint_d' },
        lua = { 'stylua' },
        typescript = { 'prettier', 'eslint_d' },
      },
      formatters = {
        kirei = {
          command = 'kirei',
          args = {
            '--stdin-filepath',
            '$FILENAME',
            '-',
          },
        },
      },
    },
    keys = {
      {
        '<leader>f',
        function() require('conform').format { async = true, lsp_format = 'fallback' } end,
        desc = 'Format',
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

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
        group = vim.api.nvim_create_augroup('lint', { clear = true }),
        pattern = '*.md',
        callback = function() lint.try_lint() end,
      })
    end,
  },
}
