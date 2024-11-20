---@class snacks.notifier.Config
---@field keep? fun(notif: snacks.notifier.Notif): boolean # global keep function
return {
  timeout = 3000, -- default timeout in ms
  width = { min = 40, max = 0.4 },
  height = { min = 1, max = 0.6 },
  -- editor margin to keep free. tabline and statusline are taken into account automatically
  margin = { top = 0, right = 1, bottom = 0 },
  padding = true, -- add 1 cell of left/right padding to the notification window
  sort = { 'level', 'added' }, -- sort by level and time
  -- minimum log level to display. TRACE is the lowest
  -- all notifications are stored in history
  level = vim.log.levels.TRACE,
  icons = {
    error = ' ',
    warn = ' ',
    info = ' ',
    debug = ' ',
    trace = ' ',
  },
  keep = function(notif)
    return vim.fn.getcmdpos() > 0
  end,
  ---@type snacks.notifier.style
  style = 'fancy',
  top_down = false, -- place notifications from top to bottom
  date_format = '%R', -- time format for notifications
  refresh = 50, -- refresh at most every 50ms
}
