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
        [[:<C-u>lua require('grug-far').with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })<cr>]],
        mode = 'v',
        desc = 'Replace current visual selection',
      },
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
      require('mini.ai').setup()
      require('mini.surround').setup()
      require('mini.pairs').setup()
      require('mini.icons').setup {
        directory = { nvim = { hl = 'MiniIconsAzure' } },
        file = { ['init.lua'] = { glyph = '󰢱', hl = 'MiniIconsAzure' } },
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
      view_options = { show_hidden = true },
      confirmation = { min_width = { 20, 0.2 } },
    },
    keys = { { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' } },
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
      { '<A-h>', function() require('arrow.persist').previous() end },
      { '<A-l>', function() require('arrow.persist').next() end },
    },
  },

  -- Crates dependencies
  {
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    opts = {},
  },

  -- Tailwind
  {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    opts = {
      server = { override = false },
      -- conceal = { enabled = true }, broken ?
      extension = {
        patterns = { -- a map of filetypes to Lua pattern lists
          rust = { 'class=["\']([^"\']+)["\']' },
        },
      },
    },
    keys = {
      {
        '<leader>Tc',
        '<cmd>TailwindConcealToggle<cr>',
        ft = { 'html', 'htmldjango', 'rust' },
        desc = 'Toggle tailwind conceal',
      },
      {
        '<leader>Ts',
        '<cmd>TailwindSort<cr>',
        ft = { 'html', 'htmldjango', 'rust' },
        desc = 'Sort tailwind classes',
      },
      {
        '<leader>Tp',
        '<cmd>TailwindPrevClass<cr>',
        ft = { 'html', 'htmldjango', 'rust' },
        desc = 'Move to the previous class',
      },
      {
        '<leader>Tn',
        '<cmd>TailwindNextClass<cr>',
        ft = { 'html', 'htmldjango', 'rust' },
        desc = 'Move to the next class',
      },
    },
  },

  -- T.T
  {
    'm4xshen/hardtime.nvim',
    lazy = false,
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {},
  },
}
