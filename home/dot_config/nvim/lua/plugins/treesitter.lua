return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  version = false,
  build = ':TSUpdate',
  config = function()
    -- Local parsers
    vim.api.nvim_create_autocmd('User', {
      pattern = 'TSUpdate',
      callback = function()
        local parsers = require 'nvim-treesitter.parsers'

        parsers.askama = {
          install_info = {
            path = '~/repos/parsers/tree-sitter-askama',
          },
        }
        parsers.rue = {
          install_info = {
            path = '~/repos/parsers/tree-sitter-rue',
          },
        }
        parsers.yarn = {
          install_info = {
            path = '~/repos/parsers/tree-sitter-yarn',
          },
        }
      end,
    })

    vim.filetype.add {
      extension = {
        rue = 'rue',
        yarn = 'yarn',
        html = function()
          for i = 1, 40 do
            local line = vim.fn.getline(i)
            if line == '' then
              break
            end
            if line:match '{[%%{#][%-+~]?%s*%w' then
              return 'askama'
            end
          end
          return 'html'
        end,
      },
      pattern = {
        ['.*/templates/.*%.html'] = 'askama',
      },
    }

    local ensure_installed = {
      'askama',
      'bash',
      'c',
      'css',
      'diff',
      'dockerfile',
      'fish',
      'gitcommit',
      'gotmpl',
      'html',
      'javascript',
      'json',
      'just',
      'kdl',
      'lua',
      'markdown',
      'markdown_inline',
      'query',
      'regex',
      'ron',
      'rue',
      'rust',
      'sql',
      'toml',
      'vim',
      'vimdoc',
      'yaml',
      'yarn',
    }

    require('nvim-treesitter').install(ensure_installed)

    -- Treesitter highlighting
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('custom_treesitter', { clear = true }),
      callback = function() pcall(vim.treesitter.start) end,
    })
  end,
}
