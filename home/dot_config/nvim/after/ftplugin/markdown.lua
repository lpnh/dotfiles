vim.diagnostic.config {
  float = {
    border = 'rounded',
    format = function(diagnostic)
      local extracted = string.match(diagnostic.message, '%s([^%[]+)')
      return extracted or diagnostic.message
    end,
    header = '',
    prefix = '',
    severity_sort = false,
  },
}
