return {
  -- Wakatime
  { 'wakatime/vim-wakatime', lazy = false },

  -- Find and replace
  {
    'MagicDuck/grug-far.nvim',
    opts = {},
    keys = {
      {
        '<leader>r',
        function()
          require('grug-far').open { prefills = { search = vim.fn.expand '<cword>' } }
        end,
        desc = 'Replace word under the cursor',
      },
    },
  },

  -- WhichKey
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      win = {
        border = 'single',
      },
    },
    keys = {
      { '<leader>k', '<cmd>WhichKey<CR>', desc = 'WhichKey' },
    },
  },

  -- Implement sessions
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
  },

  -- Mini modules
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
      require('mini.pairs').setup()
      require('mini.icons').setup {
        file = {
          ['init.lua'] = { glyph = '󰢱', hl = 'MiniIconsAzure' },
        },
        extension = {
          db = { glyph = '' },
          lock = { glyph = '' },
        },
      }
      MiniIcons.mock_nvim_web_devicons()
    end,
  },

  -- Oil
  {
    'stevearc/oil.nvim',
    lazy = false,
    opts = {
      view_options = {
        show_hidden = true,
      },
      skip_confirm_for_simple_edits = true,
    },
    keys = {
      { '-', '<cmd>Oil<CR>', desc = 'Open parent directory' },
    },
  },

  -- Arrow
  {
    'otavioschwanck/arrow.nvim',
    opts = {
      show_icons = true,
      leader_key = '<A-a>',
      buffer_leader_key = 'm',
    },
    keys = {
      {
        '<A-h>',
        function()
          require('arrow.persist').previous()
        end,
      },
      {
        '<A-l>',
        function()
          require('arrow.persist').next()
        end,
      },
    },
  },

  -- Crates dependencies
  {
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    opts = {},
  },

  -- Markdown
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = 'markdown',
    opts = {
      enabled = false,
    },
    keys = {
      { '<leader>mr', '<cmd>RenderMarkdown toggle<CR>', desc = 'Toggle MD rendering' },
    },
  },

  -- Tailwind
  {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      extension = {
        patterns = { -- a map of filetypes to Lua pattern lists
          rust = { 'class=["\']([^"\']+)["\']' },
        },
      },
    },
    keys = {
      { '<leader>Tc', '<cmd>TailwindConcealToggle<CR>', desc = 'Toggle tailwind conceal' },
      { '<leader>Ts', '<cmd>TailwindSort<CR>', desc = 'Sort tailwind classes' },
      { '<leader>Tp', '<cmd>TailwindPrevClass<CR>', desc = 'Move to the next class' },
      { '<leader>Tn', '<cmd>TailwindNextClass<CR>', desc = 'Move to the previous class' },
    },
  },
}
