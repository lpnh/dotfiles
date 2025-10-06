return {
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
      'kdl',
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
}
