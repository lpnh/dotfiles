return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    spec = {
      { '<leader>b', icon = '󰐁', group = 'Bacon' },
      { '<leader>k', icon = '󰌆' },
      { '<leader>s', icon = '', group = 'Search' },
    },
    win = { border = 'rounded' },
  },
  keys = { { '<leader>k', '<cmd>WhichKey<cr>', desc = 'WhichKey' } },
}
