return {
  'ibhagwan/fzf-lua',
  lazy = false,
  opts = {
    'default-title',
    fzf_opts = { ['--no-scrollbar'] = true },
    defaults = { formatter = 'path.filename_first' },
    files = { cwd_prompt = false, git_icons = false },
    diagnostics = { file_icons = false },
    winopts = {
      fullscreen = true,
      preview = { winopts = { number = false } },
    },
  },
  keys = {
    -- stylua: ignore start
    { '<c-j>', '<c-j>', ft = 'fzf', mode = 't', nowait = true },
    { '<c-k>', '<c-k>', ft = 'fzf', mode = 't', nowait = true },
    -- lsp
    { 'gd', '<cmd>FzfLua lsp_definitions<cr>', desc = 'Definitions'},
    { 'gD', '<cmd>FzfLua lsp_declarations<cr>', desc = 'Declarations' },
    { 'gR', '<cmd>FzfLua lsp_references<cr>', desc = 'References'},
    { 'gI', '<cmd>FzfLua lsp_implementations<cr>', desc = 'Implementation'},
    { 'gy', '<cmd>FzfLua lsp_typedefs<cr>', desc = 'Type definition'},
    { 'gs', function() require('fzf-lua').lsp_document_symbols { regex_filter = true } end, desc = 'Symbols' },
    { 'gsw', function() require('fzf-lua').lsp_live_workspace_symbols { regex_filter = true } end, desc = 'Symbols (workspace)' },
    -- misc
    { '<leader>s"', '<cmd>FzfLua registers<cr>', desc = 'Registers' },
    { '<leader>sa', '<cmd>FzfLua autocmds<cr>', desc = 'Autocmds' },
    { '<leader>sc', '<cmd>FzfLua files cwd=~/.config/nvim<cr>', desc = 'Neovim config' },
    { '<leader>sC', '<cmd>FzfLua commands<cr>', desc = 'Commands' },
    { '<leader>sd', '<cmd>FzfLua diagnostics_document<cr>', desc = 'Diagnostics' },
    { '<leader>sD', '<cmd>FzfLua diagnostics_workspace<cr>', desc = 'Diagnostics (workspace)' },
    { '<leader>sf', '<cmd>FzfLua files<cr>', desc = 'Files' },
    { '<leader>sg', '<cmd>FzfLua live_grep_native<cr>', desc = 'Live grep' },
    { '<leader>sh', '<cmd>FzfLua help_tags<cr>', desc = 'Help' },
    { '<leader>sH', '<cmd>FzfLua highlights<cr>', desc = 'Highlights' },
    { '<leader>sj', '<cmd>FzfLua jumps<cr>', desc = 'Jumplist' },
    { '<leader>sk', '<cmd>FzfLua keymaps<cr>', desc = 'Keymaps' },
    { '<leader>sm', '<cmd>FzfLua man_pages<cr>', desc = 'Manpages' },
    { '<leader>so', '<cmd>FzfLua oldfiles<cr>', desc = 'Oldfiles' },
    { '<leader>sr', '<cmd>FzfLua resume<cr>', desc = 'Resume' },
    { '<leader>sw', '<cmd>FzfLua grep_cword<cr>', desc = 'Word' },
    { '<leader>sz', '<cmd>FzfLua zoxide<cr>', desc = 'Zoxide' },
    { '<leader><tab>', '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>', desc = 'Jump to Buffer' },
    -- stylua: ignore end
  },
}
