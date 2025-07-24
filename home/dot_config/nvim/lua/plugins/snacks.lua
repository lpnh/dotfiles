return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      width = 40,
      preset = {
        keys = {
          -- stylua: ignore start
          { icon = ' ', key = 'j', desc = 'Jump', section = 'session' },
          { icon = ' ', key = 'a', desc = 'New', action = ':ene | startinsert' },
          { icon = ' ', key = 'f', desc = 'Files', action = ":lua Snacks.dashboard.pick('files')" },
          { icon = ' ', key = 'g', desc = 'Grep', action = ':FzfLua live_grep_native' },
          { icon = ' ', key = 'o', desc = 'Oldfiles', action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = '󰏇 ', key = 'e', desc = 'Oil', action = ':Oil' },
          { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = '󰒲 ', key = 'u', desc = 'Update', action = ':Lazy update', enabled = package.loaded.lazy ~= nil },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
          -- stylua: ignore end
        },
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
    },
    indent = { enabled = true },
    input = { enabled = true },
    lazygit = { enabled = true },
    notifier = { style = 'fancy', top_down = false },
    quickfile = { enabled = true },
    scope = { enabled = true },
    statuscolumn = { enabled = true },
    zen = { toggles = { diagnostics = false, indent = false } },
    styles = {
      notification = { wo = { wrap = true } },
      notification_history = { title = ' Notification History ' },
      zen = { minimal = true },
    },
  },
  keys = {
    -- stylua: ignore start
    { '<leader>bn', function() Snacks.scratch() end, desc = 'New buffer' },
    { '<leader>bs', function() Snacks.scratch.select() end, desc = 'Select buffer' },
    { '<leader>g', function() Snacks.lazygit() end, desc = 'Open lazygit' },
    { '<leader>n', function() Snacks.notifier.show_history() end, desc = 'Notification history' },
    { '<leader>r', function() Snacks.gitbrowse() end, desc = 'Open repository' },
    { 'grf', function() Snacks.rename.rename_file() end, desc = 'Rename file' },
    -- stylua: ignore end
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...) Snacks.debug.inspect(...) end
        _G.bt = function() Snacks.debug.backtrace() end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        Snacks.toggle.diagnostics():map '<leader>td'
        Snacks.toggle.inlay_hints():map '<leader>h'
        Snacks.toggle.zen():map '<leader>z'
        Snacks.toggle.option('relativenumber', { name = 'relative number' }):map '<leader>tr'
        Snacks.toggle.option('wrap', { name = 'wrap' }):map '<leader>tw' -- useful for html stuff
      end,
    })
  end,
}
