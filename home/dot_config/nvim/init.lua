--[[

      █▄ █ █ █ █ █▄ ▄█
      █ ▀█ ▀▄▀ █ █ ▀ █

   ▄▀▀ ▄▀▀▄ █▄ █ █▀ █ ▄▀
   ▀▄▄ ▀▄▄▀ █ ▀█ █▀ █ ▀▄█
 
--]]

require 'options'

require 'diagnostics'

require 'keymaps'

require 'lazy-bootstrap'

require('lazy').setup('plugins', {
  change_detection = {
    notify = false,
  },
  install = {
    colorscheme = { 'catppuccin' },
  },
})

require 'autocmds'
