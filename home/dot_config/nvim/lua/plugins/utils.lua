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
    opts = {},
    keys = {
      {
        '<leader>r',
        function()
          require('grug-far').open { prefills = { search = vim.fn.expand '<cword>' } }
        end,
        desc = 'Replace word under the cursor',
      },
    },
  },

  -- WhichKey
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      win = {
        border = 'single',
      },
    },
    keys = {
      { '<leader>k', '<cmd>WhichKey<CR>', desc = 'WhichKey' },
    },
  },

  -- Sessions
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
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
    lazy = false,
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    keys = {
      { '-', '<cmd>Oil<CR>', desc = 'Open parent directory' },
    },
  },

  -- Arrow
  {
    'otavioschwanck/arrow.nvim',
    dependencies = {
      { 'echasnovski/mini.icons' },
    },
    opts = {
      show_icons = true,
      leader_key = '<A-a>',
      buffer_leader_key = 'm',
    },
    keys = {
      {
        '<A-h>',
        function()
          require('arrow.persist').previous()
        end,
      },
      {
        '<A-l>',
        function()
          require('arrow.persist').next()
        end,
      },
    },
  },

  -- Crates dependencies QOL
  {
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    opts = {},
  },

  -- Markdown
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    ft = { 'markdown' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      enabled = false,
    },
    keys = {
      { '<leader>mr', '<cmd>RenderMarkdown toggle<CR>', desc = 'Toggle MD rendering' },
    },
  },

  -- Tailwind QOL
  {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim',
    },
    opts = {
      extension = {
        patterns = { -- a map of filetypes to Lua pattern lists
          rust = { 'class=["\']([^"\']+)["\']' },
        },
      },
    },
    keys = {
      { '<leader>stc', '<cmd>Telescope tailwind classes<CR>', desc = 'Search classes in the current document' },
      { '<leader>stu', '<cmd>Telescope tailwind utilities<CR>', desc = 'Search all utility classes available' }, -- TODO: fix this
      { '<leader>tc', '<cmd>TailwindConcealToggle<CR>', desc = 'Toggle tailwind conceal' },
      { '<leader>ts', '<cmd>TailwindSort<CR>', desc = 'Sort tailwind classes' },
      { '<leader>tp', '<cmd>TailwindPrevClass<CR>', desc = 'Move to the next class' },
      { '<leader>tn', '<cmd>TailwindNextClass<CR>', desc = 'Move to the previous class' },
    },
  },
}
