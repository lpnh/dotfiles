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

  -- Bacon
  {
    'Canop/nvim-bacon',
    ft = 'rust',
    opts = {
      quickfix = {
        enabled = true,
        event_trigger = true,
      },
    },
    keys = {
      {
        '<leader>bn',
        '<cmd>BaconLoad<CR><cmd>w<CR><cmd>BaconNext<CR>',
        desc = 'Navigate to next location',
        ft = 'rust',
      },
      {
        '<leader>bp',
        '<cmd>BaconLoad<CR><cmd>w<CR><cmd>BaconPrevious<CR>',
        desc = 'Navigate to next location',
        ft = 'rust',
      },
      {
        '<leader>bd',
        '<cmd>silent !bacon --send "dismiss-top-item"<CR>',
        desc = 'Dismiss current item',
        ft = 'rust',
      },
      {
        '<leader>bD',
        '<cmd>silent !bacon --send "dismiss-top"<CR>',
        desc = 'Dismiss all items',
        ft = 'rust',
      },
    },
  },

  -- Crates dependencies
  {
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    opts = {},
  },

  -- T.T
  {
    'm4xshen/hardtime.nvim',
    lazy = false,
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {},
  },
}
