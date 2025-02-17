-- chezmoi tmpl
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('chezmoi-tmpl', { clear = true }),
  pattern = '*.tmpl',
  callback = function()
    local buf_path = vim.fn.expand '%:p'
    if not string.match(buf_path, '%.local/share/chezmoi') then
      return
    end

    local base_ft = vim.fn.expand '%:r:e'
    if base_ft == '' then
      return
    end

    vim.treesitter.query.set(
      'gotmpl',
      'injections',
      string.format(
        [===[((text) @injection.content (#set! injection.language "%s") (#set! injection.combined))]===],
        base_ft
      )
    )

    vim.bo.filetype = 'gotmpl' -- this must come after the injection x.x
  end,
})

-- highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

-- oil autosave and discard
vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
  pattern = 'oil://*',
  callback = function()
    if vim.bo.modified then
      local oil = require 'oil'
      oil.save({ confirm = true }, function(canceled)
        if canceled then
          oil.discard_all_changes()
        end
      end)
    end
  end,
})
