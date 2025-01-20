return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = require 'plugins.snacks.dashboard',
    indent = { enabled = true },
    input = { enabled = true },
    notifier = require 'plugins.snacks.notifier',
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
    { '<leader>b', function() Snacks.scratch() end, desc = 'Toggle scratch buffer' },
    { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit' },
    { '<leader>gb', function() Snacks.git.blame_line() end, desc = 'Git blame line' },
    { '<leader>gB', function() Snacks.gitbrowse() end, desc = 'Git browse' },
    { '<leader>gf', function() Snacks.lazygit.log_file() end, desc = 'Lazygit current file history' },
    { '<leader>gl', function() Snacks.lazygit.log() end, desc = 'Lazygit Log (cwd)' },
    { '<leader>n', function() Snacks.notifier.show_history() end, desc = 'Show notification history' },
    { '<leader>S', function() Snacks.scratch.select() end, desc = 'Select scratch buffer' },
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
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        Snacks.toggle.diagnostics():map '<leader>d'
        Snacks.toggle.inlay_hints():map '<leader>h'
        Snacks.toggle.option('relativenumber', { name = 'relative number' }):map '<leader>tn'
        Snacks.toggle.option('wrap', { name = 'wrap' }):map '<leader>tw' -- useful for html stuff
        Snacks.toggle.zen():map '<leader>z'
      end,
    })

    local progress = vim.defaulttable()
    vim.api.nvim_create_autocmd('LspProgress', {
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
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
        progress[client.id] = vim.tbl_filter(function(v)
          return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
        vim.notify(table.concat(msg, '\n'), 'info', {
          id = 'lsp_progress',
          title = client.name,
          opts = function(notif)
            notif.icon = #progress[client.id] == 0 and ' ' or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
          end,
        })
      end,
    })
  end,
}
