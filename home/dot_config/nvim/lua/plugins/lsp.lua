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
            { path = '${3rd}/love2d/library', words = { 'love' } },
            { path = 'snacks.nvim', words = { 'Snacks' } },
          },
        },
      },
      -- Mason x.x
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Schema information
      'b0o/SchemaStore.nvim',
    },
    config = function()
      local servers = {
        bashls = { manual_install = true },
        clangd = true,
        -- gopls = { manual_install = true },
        html = {
          filetypes = { 'htmldjango' },
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
          manual_install = true,
          settings = {
            Lua = {
              -- handle the "Undefined global" warnings
              diagnostics = { globals = { 'ya' } },
              completion = { callSnippet = 'Replace' },
            },
          },
        },
        rust_analyzer = {
          manual_install = true,
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
          manual_install = true,
          filetypes = { 'html', 'htmldjango', 'rust' },
          init_options = {
            userLanguages = { rust = 'html' },
          },
        },
        taplo = { manual_install = true },
        typos_lsp = {
          init_options = { config = '~/.config/typos/typos.toml' },
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
      require('mason-tool-installer').setup {
        ensure_installed = servers_to_install,
        auto_update = true,
      }

      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
        require('lspconfig')[name].setup(config)
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
        lua = { 'stylua' },
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

  -- LÖVE
  {
    'S1M0N38/love2d.nvim',
    cmd = 'LoveRun',
    opts = {},
    keys = {
      { '<leader>lr', '<cmd>LoveRun<cr>', ft = 'lua', desc = 'Run LÖVE' },
      { '<leader>ls', '<cmd>LoveStop<cr>', ft = 'lua', desc = 'Stop LÖVE' },
    },
  },
}
