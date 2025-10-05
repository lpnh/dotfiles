return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    version = false,
    build = ':TSUpdate',
    config = function()
      local ensure_installed = {
        -- 'bash',
        -- 'c',
        -- 'css',
        -- 'diff',
        -- 'dockerfile',
        -- 'fish',
        -- 'gotmpl',
        -- 'html',
        -- 'json',
        -- 'jsonc',
        -- 'just',
        -- 'kdl',
        'lua',
        -- 'luadoc',
        'markdown',
        'markdown_inline',
        -- 'query',
        -- 'regex',
        -- 'ron',
        'rust',
        -- 'sql',
        'toml',
        -- 'tsx',
        -- 'vim',
        -- 'vimdoc',
        -- 'yaml',
      }

      local TS = require 'nvim-treesitter'

      TS.setup()
      TS.install(ensure_installed)

      vim.api.nvim_create_autocmd('User', {
        pattern = 'TSUpdate',
        callback = function()
          local parsers = require 'nvim-treesitter.parsers'

          parsers.askama = {
            install_info = {
              path = '~/repos/parsers/tree-sitter-askama',
              generate = true,
              generate_from_json = false,
              queries = 'queries/neovim',
            },
          }
          parsers.rue = {
            install_info = {
              path = '~/repos/parsers/tree-sitter-rue',
              generate = true,
              generate_from_json = false,
              queries = 'queries/neovim',
            },
          }
          parsers.yarn = {
            install_info = {
              path = '~/repos/parsers/tree-sitter-yarn',
              generate = true,
              generate_from_json = false,
              queries = 'queries/neovim',
            },
          }
        end,
      })

      vim.filetype.add {
        pattern = {
          ['.*/templates/.*%.html'] = 'askama',
        },
        extension = { rue = 'rue', yarn = 'yarn' },
      }

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('custom_treesitter', { clear = true }),
        callback = function() pcall(vim.treesitter.start) end,
      })
    end,
  },
  -- {
  --   'nvim-treesitter/nvim-treesitter-textobjects',
  --   build = ':TSUpdate',
  --   lazy = false,
  --   opts = {
  --     highlight = {
  --       enable = true,
  --       additional_vim_regex_highlighting = false,
  --     },
  --     incremental_selection = {
  --       enable = true,
  --       keymaps = {
  --         init_selection = '<C-space>',
  --         node_incremental = '<C-space>',
  --         scope_incremental = '<C-s>',
  --         node_decremental = '<M-space>',
  --       },
  --     },
  --     textobjects = {
  --       select = {
  --         enable = true,
  --         lookahead = true, -- automatically jump forward to textobj
  --         keymaps = {
  --           ['af'] = '@function.outer',
  --           ['if'] = '@function.inner',
  --           ['ac'] = '@class.outer',
  --           ['ic'] = '@class.inner',
  --           ['ab'] = '@block.outer',
  --           ['ib'] = '@block.inner',
  --           ['aa'] = '@parameter.outer',
  --           ['ia'] = '@parameter.inner',
  --         },
  --         include_surrounding_whitespace = true,
  --       },
  --       move = {
  --         enable = true,
  --         set_jumps = true,
  --         goto_next_start = {
  --           [']a'] = '@parameter.outer',
  --           [']f'] = '@function.outer',
  --           [']c'] = '@class.outer',
  --         },
  --         goto_next_end = {
  --           [']A'] = '@parameter.outer',
  --           [']F'] = '@function.outer',
  --           [']C'] = '@class.outer',
  --         },
  --         goto_previous_start = {
  --           ['[a'] = '@parameter.outer',
  --           ['[f'] = '@function.outer',
  --           ['[c'] = '@class.outer',
  --         },
  --         goto_previous_end = {
  --           ['[A'] = '@parameter.outer',
  --           ['[F'] = '@function.outer',
  --           ['[C'] = '@class.outer',
  --         },
  --         goto_next = {
  --           [']q'] = '@conditional.outer',
  --         },
  --         goto_previous = {
  --           ['[q'] = '@conditional.outer',
  --         },
  --       },
  --     },
  --   },
  --   config = function()
  --   end,
  -- },
}
