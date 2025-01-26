local custom_signs = {
  ERROR = '',
  WARN = '',
  HINT = '󰌵',
  INFO = '',
}
local default_vt = {
  format = function()
    return ''
  end,
  prefix = function(diagnostic)
    return custom_signs[vim.diagnostic.severity[diagnostic.severity]]
  end,
  spacing = 0,
}

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
  virtual_text = default_vt,
}

local virtual_text_on = true

local function ToggleVirtualText()
  local default_format = vim.diagnostic.config().float.format or function(diagnostic)
    return diagnostic.message
  end
  Snacks.notify((virtual_text_on and 'Enabled' or 'Disabled') .. ' **Virtual Text**', {
    title = 'Virtual Text',
    level = vim.log.levels.INFO,
  })
  vim.diagnostic.config {
    virtual_text = {
      format = virtual_text_on and default_format or default_vt.format,
      prefix = function(diagnostic)
        return custom_signs[vim.diagnostic.severity[diagnostic.severity]]
      end,
      spacing = 0,
    },
  }
  virtual_text_on = not virtual_text_on
end

vim.keymap.set('n', '<leader>v', ToggleVirtualText, { desc = 'Toggle Virtual Text' })
