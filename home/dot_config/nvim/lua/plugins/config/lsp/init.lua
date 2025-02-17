local servers = {
  bashls = { manual_install = true },
  clangd = true,
  -- gopls = { manual_install = true },
  html = true,
  jsonls = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  },
  lua_ls = {
    manual_install = true,
    settings = {
      Lua = {
        -- handle the "Undefined global" warnings
        diagnostics = { globals = { 'ya' } },
        completion = { callSnippet = 'Replace' },
      },
    },
  },
  rust_analyzer = {
    manual_install = true,
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = { command = 'clippy' },
        diagnostics = { enable = false },
        procMacro = { enable = true },
        rustfmt = { extraArgs = { '+nightly' } },
      },
    },
  },
  tailwindcss = {
    manual_install = true,
    filetypes = { 'html', 'rust' },
    init_options = {
      userLanguages = { rust = 'html' },
    },
  },
  taplo = { manual_install = true },
  typos_lsp = {
    init_options = { config = '~/.config/typos/typos.toml' },
  },
}

local servers_to_install = vim.tbl_filter(function(key)
  local t = servers[key]
  if type(t) == 'table' then
    return not t.manual_install
  else
    return t
  end
end, vim.tbl_keys(servers))

require('mason').setup()
require('mason-tool-installer').setup {
  ensure_installed = servers_to_install,
  auto_update = true,
}

for name, config in pairs(servers) do
  if config == true then
    config = {}
  end

  require('lspconfig')[name].setup(config)
end

vim.filetype.add { pattern = { ['.*/templates/.*%.html'] = 'html' } }

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-setup', { clear = true }),
  callback = function(event)
    -- Highlight references of the word under the cursor
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
