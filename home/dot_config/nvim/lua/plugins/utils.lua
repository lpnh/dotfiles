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
      extension = {
        patterns = { -- a map of filetypes to Lua pattern lists
          rust = { 'class=["\']([^"\']+)["\']' },
        },
      },
    },
    keys = {
      {
        '<leader>Tc',
        '<cmd>TailwindConcealToggle<CR>',
        ft = { 'html', 'rust' },
        desc = 'Toggle tailwind conceal',
      },
      {
        '<leader>Ts',
        '<cmd>TailwindSort<CR>',
        ft = { 'html', 'rust' },
        desc = 'Sort tailwind classes',
      },
      {
        '<leader>Tp',
        '<cmd>TailwindPrevClass<CR>',
        ft = { 'html', 'rust' },
        desc = 'Move to the next class',
      },
      {
        '<leader>Tn',
        '<cmd>TailwindNextClass<CR>',
        ft = { 'html', 'rust' },
        desc = 'Move to the previous class',
      },
    },
  },
}
