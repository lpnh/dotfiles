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
          enabled = function(root_dir)
            local config_path = vim.fn.stdpath 'config'
            return vim.startswith(vim.fs.normalize(root_dir), vim.fs.normalize(config_path))
          end,
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
          on_init = function(client)
            if not client.workspace_folders then
              return
            end
            local root_dir = client.workspace_folders[1].name
            local yazi_config = vim.fn.expand '~/.config/yazi'
            if vim.startswith(root_dir, yazi_config) or root_dir:match '%.yazi/?$' then
              client.config.settings.Lua =
                vim.tbl_deep_extend('force', client.config.settings.Lua, {
                  workspace = {
                    checkThirdParty = false,
                    library = {
                      vim.fs.joinpath(yazi_config, 'plugins', 'types.yazi'),
                    },
                  },
                })
            end
          end,
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
              check = { command = 'clippy' },
              diagnostics = { enable = false },
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
        javascript = { 'prettier' },
        lua = { 'stylua' },
        typescript = { 'prettier' },
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
        '<leader>F',
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
