return {
  'ibhagwan/fzf-lua',
  lazy = false,
  opts = {
    'ivy',
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
    { '<leader>r', '<cmd>FzfLua lsp_references<cr>', desc = 'References'},
    { 'gd', '<cmd>FzfLua lsp_definitions<cr>', desc = 'Definitions'},
    { 'gD', '<cmd>FzfLua lsp_declarations<cr>', desc = 'Declarations' },
    { 'gI', '<cmd>FzfLua lsp_implementations<cr>', desc = 'Implementation'},
    { 'gy', '<cmd>FzfLua lsp_typedefs<cr>', desc = 'Type definition'},
    { 'gs', function() require('fzf-lua').lsp_document_symbols { regex_filter = true } end, desc = 'Symbols' },
    { 'gsw', function() require('fzf-lua').lsp_live_workspace_symbols { regex_filter = true } end, desc = 'Symbols (workspace)' },
    -- misc
    { '<leader>d', '<cmd>FzfLua diagnostics_document<cr>', desc = 'Diagnostics' },
    { '<leader>f', '<cmd>FzfLua quickfix<cr>', desc = 'Quickfix' },
    { '<leader>g', '<cmd>FzfLua live_grep_native<cr>', desc = 'Ripgrep' },
    { '<leader>sa', '<cmd>FzfLua autocmds<cr>', desc = 'Autocmds' },
    { '<leader>sc', '<cmd>FzfLua files cwd=~/.config/nvim<cr>', desc = 'Neovim config' },
    { '<leader>sC', '<cmd>FzfLua commands<cr>', desc = 'Commands' },
    { '<leader>sd', '<cmd>FzfLua diagnostics_workspace<cr>', desc = 'Diagnostics (workspace)' },
    { '<leader>sf', '<cmd>FzfLua files<cr>', desc = 'Files' },
    { '<leader>sh', '<cmd>FzfLua help_tags<cr>', desc = 'Help' },
    { '<leader>sH', '<cmd>FzfLua highlights<cr>', desc = 'Highlights' },
    { '<leader>sj', '<cmd>FzfLua jumps<cr>', desc = 'Jumplist' },
    { '<leader>sk', '<cmd>FzfLua keymaps<cr>', desc = 'Keymaps' },
    { '<leader>sm', '<cmd>FzfLua man_pages<cr>', desc = 'Manpages' },
    { '<leader>so', '<cmd>FzfLua oldfiles<cr>', desc = 'Oldfiles' },
    { '<leader>sr', '<cmd>FzfLua resume<cr>', desc = 'Resume' },
    { '<leader>sw', '<cmd>FzfLua grep_cword<cr>', desc = 'Word' },
    { '<leader>s"', '<cmd>FzfLua registers<cr>', desc = 'Registers' },
    { '<leader><tab>', '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>', desc = 'Buffers' },
    -- stylua: ignore end
  },
}
