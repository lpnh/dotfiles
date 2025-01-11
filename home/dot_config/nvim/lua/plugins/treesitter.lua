return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
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
    },
    config = function(_, opts)
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
