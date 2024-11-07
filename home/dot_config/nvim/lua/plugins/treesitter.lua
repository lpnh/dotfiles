return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nushell/tree-sitter-nu' },
    build = ':TSUpdate',
    lazy = vim.fn.argc(-1) == 0,
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'css',
        'diff',
        'dockerfile',
        'fish',
        'html',
        'json',
        'jsonc',
        'just',
        'kdl',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'nu',
        'query',
        'regex',
        'ron',
        'rust',
        'sql',
        'toml',
        'tsx', -- required by treesitter itself (?)
        'vim',
        'vimdoc',
        'yaml',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = '<C-s>',
          node_decremental = '<M-space>',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['aa'] = { query = '@parameter.outer', desc = '[A]round [A]rgument' },
            ['ia'] = { query = '@parameter.inner', desc = '[I]nside [A]rgument' },
            ['af'] = { query = '@function.outer', desc = '[A]round [F]unction' },
            ['if'] = { query = '@function.inner', desc = '[I]nside [F]unction' },
            ['ac'] = { query = '@class.outer', desc = '[A]round [C]lass' },
            ['ic'] = { query = '@class.inner', desc = '[I]nside [C]lass' },
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']f'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']F'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[f'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[F'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
          goto_next = {
            [']c'] = '@conditional.outer',
          },
          goto_previous = {
            ['[c'] = '@conditional.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
}
