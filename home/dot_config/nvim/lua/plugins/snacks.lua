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
          { icon = ' ', key = 'f', desc = 'Files', action = ":lua Snacks.dashboard.pick('files')" },
          { icon = ' ', key = 'g', desc = 'Grep', action = ':FzfLua live_grep_native' },
          { icon = '󰏇 ', key = 'e', desc = 'Oil', action = ':Oil' },
          { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = '󰹩 ', key = 't', desc = 'TSUpdate', action = ':TSUpdate' },
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
    notifier = { style = 'fancy', top_down = false },
    quickfile = { enabled = true },
    scope = { enabled = true },
    statuscolumn = { enabled = true },
    styles = {
      notification = { wo = { wrap = true } },
      notification_history = { title = ' Notification History ' },
    },
  },
  keys = {
    -- stylua: ignore start
    { '<leader>pn', function() Snacks.scratch() end, desc = 'New buffer' },
    { '<leader>ps', function() Snacks.scratch.select() end, desc = 'Select buffer' },
    { '<leader>n', function() Snacks.notifier.show_history() end, desc = 'Notification history' },
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

        Snacks.toggle.diagnostics():map '<leader>D'
        Snacks.toggle.inlay_hints():map '<leader>h'
        Snacks.toggle.option('relativenumber', { name = 'relative number' }):map '<leader>l'
        -- Snacks.toggle.option('wrap', { name = 'wrap' }):map '<leader>w' -- useful for html stuff

        local custom_signs = {
          ERROR = '',
          WARN = '',
          HINT = '󰌵',
          INFO = '',
        }

        local vim_config = vim.diagnostic.config
        local vt_enabled = false

        local function vt_config(enabled)
          return {
            format = enabled and (vim_config().float.format or function(d) return d.message end)
              or function() return '' end,
            prefix = function(d) return custom_signs[vim.diagnostic.severity[d.severity]] end,
            spacing = 0,
          }
        end

        -- Initial diagnostic configuration
        vim_config {
          float = { border = 'rounded', header = '', prefix = '', severity_sort = false },
          severity_sort = true,
          signs = false,
          underline = false,
          virtual_text = vt_config(vt_enabled),
        }

        Snacks.toggle
          .new({
            name = 'Virtual Text',
            get = function() return vt_enabled end,
            set = function(state)
              vt_enabled = state
              vim_config { virtual_text = vt_config(state) }
            end,
          })
          :map('<leader>v', { desc = 'Toggle Virtual Text' })

        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
          callback = function() vim_config { virtual_text = vt_config(vt_enabled) } end,
        })
      end,
    })
  end,
}
