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
  -- 'diagnostics',
  'autocmds',
  'lazy',
}

for _, item in ipairs(config) do
  require('config.' .. item)
end
