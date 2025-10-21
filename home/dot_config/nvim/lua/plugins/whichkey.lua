return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    delay = 0,
    spec = {
      { '<leader>b', icon = '󰐁', group = 'Bacon' },
      { '<leader>k', icon = '󰌆' },
      { '<leader>p', icon = '', group = 'Playground' },
      { '<leader>s', icon = '', group = 'Search' },
    },
    win = { border = 'rounded' },
  },
  keys = { { '<leader>k', '<cmd>WhichKey<cr>', desc = 'WhichKey' } },
}
