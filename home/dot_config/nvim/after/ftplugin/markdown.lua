local signs = {
  ERROR = '',
  WARN = '',
  HINT = '󰌵',
  INFO = '',
}
vim.diagnostic.config {
  virtual_lines = false,
  virtual_text = {
    format = function(diagnostic)
      local space_index = string.find(diagnostic.message, ' ')
      if space_index then
        return string.sub(diagnostic.message, space_index)
      end
      return diagnostic.message
    end,
    prefix = function(diagnostic)
      return signs[vim.diagnostic.severity[diagnostic.severity]]
    end,
    spacing = 0,
  },
}
