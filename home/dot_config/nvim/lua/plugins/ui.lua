return {
  -- Icons
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  -- Add custom colors to icons
  {
    'dgox16/devicon-colorscheme.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('devicon-colorscheme').setup {
        colors = {
          blue = '#89b4fa',
          cyan = '#94e2d5',
          green = '#a6e3a1',
          magenta = '#f5c2e7',
          orange = '#eba0ac',
          purple = '#cba6f7',
          red = '#f38ba8',
          white = '#9399b2',
          yellow = '#f9e2af',
          bright_blue = '#89b4fa',
          bright_cyan = '#94e2d5',
          bright_green = '#a6e3a1',
          bright_magenta = '#f5c2e7',
          bright_orange = '#eba0ac',
          bright_purple = '#cba6f7',
          bright_red = '#f38ba8',
          bright_yellow = '#f9e2af',
        },
      }
    end,
  },

  -- Set lualine as statusline
  -- See `:help lualine.txt`
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        icons_enabled = true,
        theme = 'catppuccin',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_b = {
          {
            'branch',
            separator = { right = '' },
            color = { bg = '#363a4f' },
          },
          {
            'diff',
            separator = { right = '' },
            color = { bg = '#363a4f' },
          },
          {
            'diagnostics',
            separator = { right = '' },
            color = { bg = '#363a4f' },
          },
        },
        lualine_c = {
          {
            'buffers',
          },
        },
        lualine_x = {},
        lualine_y = {
          {
            'progress',
            color = { bg = '#363a4f' },
          },
        },
      },
      extensions = {
        'lazy',
        'mason',
        'oil',
      },
    },
  },

  -- Take care of messages, cmdline and popupmenu
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module='...'` entries
      'MunifTanjim/nui.nvim',
      -- optional: enable notification view
      {
        'rcarriga/nvim-notify',
        opts = {
          background_colour = '#000000',
          timeout = '1500',
        },
      },
    },
    opts = {
      cmdline = {
        -- view = "cmdline",
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      -- https://github.com/folke/noice.nvim/wiki/Configuration-Recipes#show-recording-messages
      routes = {
        {
          view = 'notify',
          filter = { event = 'msg_showmode' },
        },
      },
    },
  },

  -- Add indentation guides even on blank lines
  -- See `:help ibl`
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
    config = function()
      require('ibl').setup {
        indent = { char = '▏' },
        scope = {
          show_start = false,
        },
        exclude = {
          filetypes = {
            'dashboard',
          },
        },
      }
    end,
  },

  -- Add git related signs to the gutter and other utilities
  -- See `:help gitsigns`
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
}
