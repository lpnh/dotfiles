-- LSP Configuration & Plugins
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Additional Lua LSP for the Neovim config, runtime and plugins
    { 'folke/neodev.nvim', opts = {} },
  },
  config = function()
    -- Attach
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
        end

        -- Jump to the definition of the word under the cursor
        --  This is where a variable was first declared, or where a function is defined, etc
        --  To jump back, press <C-t>
        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

        -- Find references for the word under the cursor
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

        -- Jump to the implementation of the word under the cursor
        --  Useful when the language has ways of declaring types without an actual implementation
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

        -- Jump to the type of the word under the cursor
        --  Useful when not sure what type a variable is and want to see
        --  the definition of its *type*, not where it was *defined*
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

        -- Fuzzy find all the symbols in the current document
        --  Symbols are things like variables, functions, types, etc
        map('<leader>ssd', require('telescope.builtin').lsp_document_symbols, '[S]earch [S]ymbols in [D]ocument')

        -- Fuzzy find all the symbols in the current workspace
        --  Similar to document symbols, except searches over the entire project
        map('<leader>ssw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[S]earch [S]ymbols in [W]orkspace')

        -- Execute a code action, usually the cursor needs to be on top of an error
        -- or a suggestion from the LSP for this to activate.
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        -- Opens a popup that displays documentation about the word under the cursor
        --  See `:help K` for why this keymap.
        map('K', vim.lsp.buf.hover, 'Hover Documentation')

        -- Opens a popup that displays signature information about the word under the cursor
        map('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- Enable inlay hints if the language server supports them
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    -- Detach
    vim.api.nvim_create_autocmd('LspDetach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
      callback = function(event)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event.buf }
      end,
    })

    -- Capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    -- Servers
    local servers = {
      typos_lsp = {},
      clangd = {},
      gopls = {},
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
          },
        },
      },
      taplo = {},
      html = { filetypes = { 'rs', 'html' } },
      tailwindcss = {},
      htmx = {},
    }

    -- Mason
    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'codelldb',
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
