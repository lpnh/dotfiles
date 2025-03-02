--[[

      █▄ █ █ █ █ █▄ ▄█
      █ ▀█ ▀▄▀ █ █ ▀ █

   ▄▀▀ ▄▀▀▄ █▄ █ █▀ █ ▄▀
   ▀▄▄ ▀▄▄▀ █ ▀█ █▀ █ ▀▄█
 
--]]

require 'options'

require 'keymaps'

require 'diagnostics'

require 'autocmds'

require 'lazy-bootstrap'

require('lazy').setup('plugins', {
  change_detection = {
    notify = false,
  },
  install = {
    colorscheme = { 'catppuccin' },
  },
})
