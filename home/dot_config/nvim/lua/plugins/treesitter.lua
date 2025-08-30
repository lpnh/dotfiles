return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
  build = ':TSUpdate',
  lazy = false,
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'css',
      'diff',
      'dockerfile',
      'fish',
      'gotmpl',
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
        lookahead = true, -- automatically jump forward to textobj
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['ab'] = '@block.outer',
          ['ib'] = '@block.inner',
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
        },
        include_surrounding_whitespace = true,
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          [']a'] = '@parameter.outer',
          [']f'] = '@function.outer',
          [']c'] = '@class.outer',
        },
        goto_next_end = {
          [']A'] = '@parameter.outer',
          [']F'] = '@function.outer',
          [']C'] = '@class.outer',
        },
        goto_previous_start = {
          ['[a'] = '@parameter.outer',
          ['[f'] = '@function.outer',
          ['[c'] = '@class.outer',
        },
        goto_previous_end = {
          ['[A'] = '@parameter.outer',
          ['[F'] = '@function.outer',
          ['[C'] = '@class.outer',
        },
        goto_next = {
          [']q'] = '@conditional.outer',
        },
        goto_previous = {
          ['[q'] = '@conditional.outer',
        },
      },
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)

    require('nvim-treesitter.parsers').get_parser_configs().askama = {
      install_info = {
        url = '~/repos/parsers/tree-sitter-askama',
        files = { 'src/parser.c', 'src/scanner.c' },
        branch = 'main',
        generate_requires_npm = false,
        requires_generate_from_grammar = false,
      },
    }

    require('nvim-treesitter.parsers').get_parser_configs().rue = {
      install_info = {
        url = '~/repos/parsers/tree-sitter-rue',
        files = { 'src/parser.c' },
        branch = 'main',
        generate_requires_npm = false,
        requires_generate_from_grammar = false,
      },
    }

    require('nvim-treesitter.parsers').get_parser_configs().yarn = {
      install_info = {
        url = '~/repos/parsers/tree-sitter-yarn',
        files = { 'src/parser.c', 'src/scanner.c' },
        branch = 'main',
        generate_requires_npm = false,
        requires_generate_from_grammar = false,
      },
    }

    vim.filetype.add {
      pattern = {
        ['.*/templates/.*%.html'] = { 'askama', { priority = 10 } },
      },
    }

    vim.filetype.add {
      extension = { rue = 'rue' },
    }

    vim.filetype.add {
      extension = { yarn = 'yarn' },
    }
  end,
}
