return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- MD Tables
  'dhruvasagar/vim-table-mode',

  -- Wakatime
  { 'wakatime/vim-wakatime', lazy = false },

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

  -- Autopairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  -- Display pending keybinds
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup {
        window = {
          border = 'single',
        },
      }

      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ust Lsp', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      }
    end,
  },

  -- Mini modules
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      -- Better Around/Inside textobjects
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      require('mini.surround').setup()
    end,
  },

  -- Oil
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },

  -- Rust stuff ♥
  {
    'mrcjkb/rustaceanvim',
    dependencies = 'neovim/nvim-lspconfig',
    ft = { 'rust' },
    version = '^4', -- Recommended
    opts = {
      server = {
        on_attach = function(_, bufnr)
          local nmap = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
          end

          nmap('<leader>rc', '<cmd>RustLsp openCargo<CR>', 'Go to cargo.toml')
          nmap('<leader>re', '<cmd>RustLsp explainError<CR>', 'Explain error')
          nmap('<leader>rj', '<cmd>RustLsp moveItem down<CR>', 'Move item down')
          nmap('<leader>rk', '<cmd>RustLsp moveItem up<CR>', 'Move item up')
          nmap('<leader>rd', '<cmd>RustLsp debuggables last<CR>', 'Debug')
          nmap('<leader>rr', '<cmd>RustLsp renderDiagnostic<CR>', 'Render diagnostics')
        end,
        settings = {
          ['rust-analyzer'] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
            checkOnSave = { -- Add clippy lints for Rust.
              allFeatures = true,
              command = 'clippy',
              extraArgs = { '--no-deps' },
            },
            procMacro = {
              enable = true,
              ignored = {
                ['async-trait'] = { 'async_trait' },
                ['napi-derive'] = { 'napi' },
                ['async-recursion'] = { 'async_recursion' },
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend('force', {}, opts or {})
    end,
  },

  {
    'saecki/crates.nvim',
    ft = { 'toml' },
    config = function()
      require('crates').setup()
    end,
  },

  {
    'luckasRanarison/tailwind-tools.nvim',
    opts = {},
  },
}
