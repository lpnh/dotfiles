return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- MD Tables
  'dhruvasagar/vim-table-mode',

  -- Wakatime
  { 'wakatime/vim-wakatime', lazy = false },

  -- Autopairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
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

      vim.keymap.set('n', '<leader>k', '<cmd>WhichKey<CR>', { desc = 'Which [K]ey' })
    end,

    -- Document existing key chains
    keys = {
      { '<leader>d', group = '[D]iagnostic' },
      { '<leader>d_', hidden = true },
      { '<leader>s', group = '[S]earch' },
      { '<leader>s_', hidden = true },
      { '<leader>ss', group = '[S]earch [S]ymbols' },
      { '<leader>ss_', hidden = true },
      { '<leader>t', group = '[T]able' },
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

  {
    'luckasRanarison/tailwind-tools.nvim',
    opts = {
      custom_filetype = { 'rust' },
    },
  },
}
