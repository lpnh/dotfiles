return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = require 'plugins.config.snacks.dashboard',
    indent = { enabled = true },
    input = { enabled = true },
    notifier = require 'plugins.config.snacks.notifier',
    quickfile = { enabled = true },
    scope = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    zen = {
      toggles = { diagnostics = false, indent = false },
    },

    styles = {
      notification = {
        wo = { wrap = true },
      },
      notification_history = {
        title = ' Notification History ',
      },
      zen = { minimal = true },
    },
  },
  keys = {
    -- stylua: ignore start
    { '<leader>bn', function() Snacks.scratch() end, desc = 'Scratch buffer new' },
    { '<leader>bs', function() Snacks.scratch.select() end, desc = 'Scratch buffer select' },
    { '<leader>o', function() Snacks.gitbrowse() end, desc = 'Open repo' },
    { '<leader>n', function() Snacks.notifier.show_history() end, desc = 'Notification history' },
    { 'grf', function() Snacks.rename.rename_file() end, desc = 'Rename file' },
    { ']r', function() Snacks.words.jump(vim.v.count1) end, desc = 'Next reference', mode = { 'n', 't' }, },
    { '[r', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev reference', mode = { 'n', 't' }, },
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

    local progress = vim.defaulttable()
    vim.api.nvim_create_autocmd('LspProgress', {
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value
        if not client or type(value) ~= 'table' then
          return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
          if i == #p + 1 or p[i].token == ev.data.params.token then
            p[i] = {
              token = ev.data.params.token,
              msg = ('[%3d%%] %s%s'):format(
                value.kind == 'end' and 100 or value.percentage or 100,
                value.title or '',
                value.message and (' **%s**'):format(value.message) or ''
              ),
              done = value.kind == 'end',
            }
            break
          end
        end

        local msg = {}
        progress[client.id] = vim.tbl_filter(
          function(v) return table.insert(msg, v.msg) or not v.done end,
          p
        )

        local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
        vim.notify(table.concat(msg, '\n'), 'info', {
          id = 'lsp_progress',
          title = client.name,
          opts = function(notif)
            notif.icon = #progress[client.id] == 0 and ' '
              or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
          end,
        })
      end,
    })
  end,
}
