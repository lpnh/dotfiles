return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Wakatime
  { 'wakatime/vim-wakatime', lazy = false },

  -- Autopairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  -- Find and Replace
  {
    'MagicDuck/grug-far.nvim',
    config = function()
      require('grug-far').setup {}

      vim.keymap.set('n', '<leader>r', function()
        require('grug-far').open { prefills = { search = vim.fn.expand '<cword>' } }
      end, { desc = 'Replace word under the cursor' })
    end,
  },

  -- Display pending keybinds
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup {
        win = {
          border = 'single',
        },
      }

      vim.keymap.set('n', '<leader>k', '<cmd>WhichKey<CR>', { desc = 'Which key' })
    end,

    -- Document existing key chains
    keys = {
      { '<leader>d', group = 'Diagnostic' },
      { '<leader>d_', hidden = true },
      { '<leader>m', group = 'Markdown' },
      { '<leader>m_', hidden = true },
      { '<leader>s', group = 'Search' },
      { '<leader>s_', hidden = true },
      { '<leader>ss', group = 'Search symbols' },
      { '<leader>ss_', hidden = true },
      { '<leader>t', group = 'Tailwind' },
      { '<leader>t_', hidden = true },
      { '<leader>v', group = 'LÖVE' },
      { '<leader>v_', hidden = true },
    },
  },

  -- Mini modules
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      -- Better Around/Inside textobjects
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      require('mini.surround').setup()
    end,
  },

  -- Oil
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup {
        view_options = {
          -- Show files and directories that start with "."
          show_hidden = true,
        },
      }

      vim.keymap.set('n', '-', '<cmd>Oil<CR>', { desc = 'Oil: Open parent directory' })
    end,
  },

  -- Grapple
  {
    'cbochs/grapple.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', lazy = true },
    },
    opts = {
      scope = 'git', -- also try out "git_branch"
    },
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = 'Grapple',
    keys = {
      { '<A-m>', '<cmd>Grapple toggle<cr>', desc = 'Grapple toggle tag' },
      { '<A-e>', '<cmd>Grapple toggle_tags<cr>', desc = 'Grapple open tags window' },
      { '<A-l>', '<cmd>Grapple cycle_tags next<cr>', desc = 'Grapple cycle next tag' },
      { '<A-h>', '<cmd>Grapple cycle_tags prev<cr>', desc = 'Grapple cycle previous tag' },
      { '<A-1>', '<cmd>Grapple select index=1<cr>', desc = 'Select first tag' },
      { '<A-2>', '<cmd>Grapple select index=2<cr>', desc = 'Select second tag' },
      { '<A-3>', '<cmd>Grapple select index=3<cr>', desc = 'Select third tag' },
      { '<A-4>', '<cmd>Grapple select index=4<cr>', desc = 'Select fourth tag' },
    },
  },

  {
    'saecki/crates.nvim',
    ft = { 'toml' },
    opts = {},
  },

  -- Web stuff
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup {
        opts = {
          -- Defaults
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
        -- Also override individual filetype configs, these take priority.
        -- Empty by default, useful if one of the "opts" global settings
        -- doesn't work well in a specific filetype
        per_filetype = {
          ['html'] = {
            enable_close = false,
          },
        },
      }
    end,
  },
  {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('tailwind-tools').setup {
        -- your configuration
        extension = {
          queries = {
            -- a list of filetypes having custom `class` queries
            -- https://github.com/luckasRanarison/tailwind-tools.nvim?tab=readme-ov-file#treesitter-queries
          },
          patterns = { -- a map of filetypes to Lua pattern lists
            rust = { 'class=["\']([^"\']+)["\']' },
          },
        },
      }

      vim.keymap.set('n', '<leader>stc', '<cmd>Telescope tailwind classes<CR>', { desc = 'Search classes in the current document' })
      vim.keymap.set('n', '<leader>stu', '<cmd>Telescope tailwind utilities<CR>', { desc = 'Search all utility classes available' })
      vim.keymap.set('n', '<leader>tc', '<cmd>TailwindConcealToggle<CR>', { desc = 'Toggle tailwind conceal' })
      vim.keymap.set('n', '<leader>ts', '<cmd>TailwindSort<CR>', { desc = 'Sort tailwind classes' })
      vim.keymap.set('n', '<leader>tp', '<cmd>TailwindPrevClass<CR>', { desc = 'Move to the next class' })
      vim.keymap.set('n', '<leader>tn', '<cmd>TailwindNextClass<CR>', { desc = 'Move to the previous class' })
    end,
  },
}
