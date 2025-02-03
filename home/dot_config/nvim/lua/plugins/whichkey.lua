return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    delay = 0,
    spec = {
      { '<leader>g', icon = '󰊢', group = 'Git' },
      { '<leader>k', icon = '󰌆' },
      { '<leader>l', icon = '', group = 'LÖVE' },
      { '<leader>t', icon = '', group = 'Toggle' },
    },
    win = {
      border = 'single',
    },
  },
  keys = { { '<leader>k', '<cmd>WhichKey<CR>', desc = 'WhichKey' } },
}
