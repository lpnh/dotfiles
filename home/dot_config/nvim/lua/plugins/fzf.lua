return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    'default-title',
    fzf_opts = {
      ['--no-scrollbar'] = true,
      -- ['--border'] = 'none',
    },
    defaults = {
      formatter = 'path.filename_first',
      -- formatter = 'path.dirname_first',
    },
    files = { cwd_prompt = false, git_icons = false },
    diagnostics = { file_icons = false },
    winopts = {
      fullscreen = true,
      preview = {
        winopts = {
          number = false,
        },
      },
    },
  },
  keys = {
    { '<c-j>', '<c-j>', ft = 'fzf', mode = 't', nowait = true },
    { '<c-k>', '<c-k>', ft = 'fzf', mode = 't', nowait = true },
    {
      '<leader><tab>',
      '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>',
      desc = 'Switch Buffer',
    },
    -- git
    { '<leader>gc', '<cmd>FzfLua git_commits<CR>', desc = 'Commits' },
    { '<leader>gs', '<cmd>FzfLua git_status<CR>', desc = 'Status' },
    -- search
    { '<leader>s"', '<cmd>FzfLua registers<cr>', desc = 'Registers' },
    { '<leader>sa', '<cmd>FzfLua autocmds<cr>', desc = 'Auto commands' },
    { '<leader>sb', '<cmd>FzfLua grep_curbuf<cr>', desc = 'Buffer' },
    { '<leader>sc', '<cmd>FzfLua command_history<cr>', desc = 'Command history' },
    { '<leader>sC', '<cmd>FzfLua commands<cr>', desc = 'Commands' },
    { '<leader>sd', '<cmd>FzfLua diagnostics_document<cr>', desc = 'Document diagnostics' },
    { '<leader>sD', '<cmd>FzfLua diagnostics_workspace<cr>', desc = 'Workspace diagnostics' },
    { '<leader>sf', '<cmd>FzfLua files<cr>', desc = 'Find files' },
    { '<leader>sg', '<cmd>FzfLua git_files<cr>', desc = 'Find files (git-files)' },
    { '<leader>sh', '<cmd>FzfLua help_tags<cr>', desc = 'Help pages' },
    { '<leader>sH', '<cmd>FzfLua highlights<cr>', desc = 'Search highlight groups' },
    { '<leader>sj', '<cmd>FzfLua jumps<cr>', desc = 'Jumplist' },
    { '<leader>sk', '<cmd>FzfLua keymaps<cr>', desc = 'Key maps' },
    { '<leader>sl', '<cmd>FzfLua loclist<cr>', desc = 'Location list' },
    { '<leader>sM', '<cmd>FzfLua man_pages<cr>', desc = 'Man pages' },
    { '<leader>sm', '<cmd>FzfLua marks<cr>', desc = 'Jump to mark' },
    { '<leader>so', '<cmd>FzfLua oldfiles<cr>', desc = 'Oldfiles' },
    { '<leader>sq', '<cmd>FzfLua quickfix<cr>', desc = 'Quickfix list' },
    { '<leader>sR', '<cmd>FzfLua resume<cr>', desc = 'Resume' },
    {
      '<leader>ss',
      function()
        require('fzf-lua').lsp_document_symbols {
          regex_filter = true,
        }
      end,
      desc = 'Go to symbol',
    },
    {
      '<leader>sw',
      function()
        require('fzf-lua').lsp_live_workspace_symbols {
          regex_filter = true,
        }
      end,
      desc = 'Go to symbol (workspace)',
    },
  },
}
