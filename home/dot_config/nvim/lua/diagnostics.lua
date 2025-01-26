local custom_signs = {
  ERROR = '',
  WARN = '',
  HINT = '󰌵',
  INFO = '',
}

local function get_vt_config(enabled)
  return {
    format = enabled and (vim.diagnostic.config().float.format or function(diagnostic)
      return diagnostic.message
    end) or function()
      return ''
    end,
    prefix = function(diagnostic)
      return custom_signs[vim.diagnostic.severity[diagnostic.severity]]
    end,
    spacing = 0,
  }
end

vim.diagnostic.config {
  float = {
    border = 'rounded',
    header = '',
    prefix = '',
    severity_sort = false,
  },
  severity_sort = true,
  signs = false,
  underline = false,
  virtual_text = get_vt_config(false),
}

local diagnostics_namespace = vim.api.nvim_create_namespace 'custom_diagnostics'

local is_vt_enabled = false

local function toggle_virtual_text()
  is_vt_enabled = not is_vt_enabled

  local status = is_vt_enabled and 'Enabled' or 'Disabled'
  Snacks.notify(status .. ' **Virtual Text**', {
    title = 'Virtual Text',
    level = vim.log.levels.INFO,
  })

  vim.diagnostic.config { virtual_text = get_vt_config(is_vt_enabled) }
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  callback = function()
    vim.diagnostic.config { virtual_text = get_vt_config(is_vt_enabled) }
  end,
})

vim.keymap.set('n', '<leader>v', toggle_virtual_text, { desc = 'Toggle Virtual Text' })
