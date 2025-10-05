--[[

      █▄ █ █ █ █ █▄ ▄█
      █ ▀█ ▀▄▀ █ █ ▀ █

   ▄▀▀ ▄▀▀▄ █▄ █ █▀ █ ▄▀
   ▀▄▄ ▀▄▄▀ █ ▀█ █▀ █ ▀▄█

--]]

local config = {
  'options',
  'keymaps',
  'user_cmds',
  'diagnostics',
  'autocmds',
}

for _, item in ipairs(config) do
  require('config.' .. item)
end

require 'config.lazy'
