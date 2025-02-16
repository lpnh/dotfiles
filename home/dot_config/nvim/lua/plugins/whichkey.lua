return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    delay = 0,
    spec = {
      { '<leader>b', icon = '', group = 'Scratch Buffer' },
      { '<leader>k', icon = '󰌆' },
      { '<leader>l', icon = '', group = 'LÖVE' },
      { '<leader>s', icon = '', group = 'Search' },
      { '<leader>t', icon = '', group = 'Toggle' },
      { '<leader>T', icon = '󱏿', group = 'Tailwind' },
    },
    win = {
      border = 'single',
    },
  },
  keys = { { '<leader>k', '<cmd>WhichKey<CR>', desc = 'WhichKey' } },
}
