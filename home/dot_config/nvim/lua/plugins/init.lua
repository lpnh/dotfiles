-- You can configure plugins using the `config` key.
-- For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
require('lazy').setup({

  require('plugins.utils'),

  require('plugins.lsp'),

  require('plugins.cmp'),

  require('plugins.theme'),

  require('plugins.ui'),

}, {})
