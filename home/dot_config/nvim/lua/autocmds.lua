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

-- snacks notifier lsp progress
vim.api.nvim_create_autocmd('LspProgress', {
  callback = function(ev)
    local progress = vim.defaulttable()
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

-- highlight references of the word under the cursor
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-setup', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if
      client
      and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight)
    then
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
