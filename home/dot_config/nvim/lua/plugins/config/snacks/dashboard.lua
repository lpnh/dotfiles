return {
  width = 40,
  row = nil, -- dashboard position. nil for center
  col = nil, -- dashboard position. nil for center
  pane_gap = 4, -- empty columns between vertical panes
  autokeys = '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', -- autokey sequence
  -- These settings are used by some built-in sections
  preset = {
    -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
    pick = nil,
    -- Used by the `keys` section to show keymaps.
    -- Set your curstom keymaps here.
    -- stylua: ignore start
    keys = {
      { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
      { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')", },
      { icon = ' ', key = 'g', desc = 'Live Grep', action = ':FzfLua live_grep_native' },
      { icon = ' ', key = 'h', desc = 'History', action = ":lua Snacks.dashboard.pick('oldfiles')", },
      { icon = '󱀸 ', key = 's', desc = 'Restore Session', section = 'session' },
      { icon = ' ', key = 'e', desc = 'Netrw', action = ':Explore' },
      { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})", },
      { icon = '󰒲 ', key = 'u', desc = 'Lazy Update', action = ':Lazy update', enabled = package.loaded.lazy ~= nil, },
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
  -- item field formatters
  formats = {
    icon = function(item)
      if item.file and item.icon == 'file' or item.icon == 'directory' then
        return M.icon(item.file, item.icon)
      end
      return { item.icon, width = 2, hl = 'icon' }
    end,
    footer = { '%s', align = 'center' },
    header = { '%s', align = 'center' },
    file = function(item, ctx)
      local fname = vim.fn.fnamemodify(item.file, ':~')
      fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
      local dir, file = fname:match '^(.*)/(.+)$'
      return dir and { { dir .. '/', hl = 'dir' }, { file, hl = 'file' } }
        or { { fname, hl = 'file' } }
    end,
  },
  sections = {
    { section = 'header' },
    { section = 'keys', gap = 1, padding = 1 },
  },
}
