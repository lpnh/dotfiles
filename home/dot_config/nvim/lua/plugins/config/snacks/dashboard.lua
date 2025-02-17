return {
  width = 40,
  preset = {
    keys = {
    -- stylua: ignore start
      { icon = ' ', key = 'j', desc = 'Jump', section = 'session' },
      { icon = ' ', key = 'n', desc = 'New', action = ':ene | startinsert' },
      { icon = ' ', key = 'f', desc = 'Files', action = ":lua Snacks.dashboard.pick('files')" },
      { icon = ' ', key = 'g', desc = 'Grep', action = ':FzfLua live_grep_native' },
      { icon = ' ', key = 'o', desc = 'Oldfiles', action = ":lua Snacks.dashboard.pick('oldfiles')" },
      { icon = '󰏇 ', key = 'e', desc = 'Oil', action = ':Oil' },
      { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
      { icon = '󰒲 ', key = 'u', desc = 'Update', action = ':Lazy update', enabled = package.loaded.lazy ~= nil },
      { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
    },
    -- stylua: ignore end
    -- Used by the `header` section
    header = [[


░░░    ░░  ░░░░░░░   ░░░░░░   ░░    ░░  ░░  ░░░    ░░░
▒▒▒▒   ▒▒  ▒▒       ▒▒    ▒▒  ▒▒    ▒▒  ▒▒  ▒▒▒▒  ▒▒▒▒
▒▒ ▒▒  ▒▒  ▒▒▒▒▒    ▒▒    ▒▒  ▒▒    ▒▒  ▒▒  ▒▒ ▒▒▒▒ ▒▒
▓▓  ▓▓ ▓▓  ▓▓       ▓▓    ▓▓   ▓▓  ▓▓   ▓▓  ▓▓  ▓▓  ▓▓
██   ████  ███████   ██████     ████    ██  ██      ██]],
  },
  sections = {
    { section = 'header' },
    { section = 'keys', gap = 1, padding = 1 },
  },
}
