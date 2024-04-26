-- For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
require('lazy').setup({
  require 'plugins.treesitter',

  require 'plugins.lsp',

  require 'plugins.telescope',

  require 'plugins.utils',

  require 'plugins.cmp',

  require 'plugins.catppuccin',

  require 'plugins.ui',

  require 'plugins.dashboard',
}, {})
