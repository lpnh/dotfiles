-- chezmoi tmpl
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('chezmoi-tmpl', { clear = true }),
  pattern = '*.tmpl',
  callback = function()
    local buf_path = vim.fn.expand '%:p'
    if not string.match(buf_path, '%andromeda/chezmoi') then
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

-- highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- highlight references of the word under the cursor
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-setup', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local document_highlight = vim.lsp.protocol.Methods.textDocument_documentHighlight
    if client and client:supports_method(document_highlight) then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
        end,
      })
    end
  end,
})

-- snacks notifier lsp progress
vim.api.nvim_create_autocmd('LspProgress', {
  callback = function(ev)
    local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
    vim.notify(vim.lsp.status(), 2, {
      id = 'lsp_progress',
      title = 'LSP Progress',
      opts = function(notif)
        notif.icon = ev.data.params.value.kind == 'end' and ' '
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})
