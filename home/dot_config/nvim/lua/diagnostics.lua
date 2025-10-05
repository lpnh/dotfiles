local custom_signs = {
  ERROR = '',
  WARN = '',
  HINT = '󰌵',
  INFO = '',
}

local vim_config = vim.diagnostic.config

local function vt_config(enabled)
  return {
    format = enabled and (vim_config().float.format or function(d) return d.message end)
      or function() return '' end,
    prefix = function(d) return custom_signs[vim.diagnostic.severity[d.severity]] end,
    spacing = 0,
  }
end

local vt_enabled = false

vim_config {
  float = {
    border = 'rounded',
    header = '',
    prefix = '',
    severity_sort = false,
  },
  severity_sort = true,
  signs = false,
  underline = false,
  virtual_text = vt_config(vt_enabled),
}

local function toggle_virtual_text()
  vt_enabled = not vt_enabled

  local status = vt_enabled and 'Enabled' or 'Disabled'
  Snacks.notify(status .. ' **Virtual Text**', {
    title = 'Virtual Text',
    level = vim.log.levels.INFO,
  })

  vim_config { virtual_text = vt_config(vt_enabled) }
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  callback = function() vim_config { virtual_text = vt_config(vt_enabled) } end,
})

vim.keymap.set('n', '<leader>v', toggle_virtual_text, { desc = 'Toggle Virtual Text' })
