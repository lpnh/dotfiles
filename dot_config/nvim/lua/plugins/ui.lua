return {
  -- Set lualine as statusline
  -- See `:help lualine.txt`
  {
    'nvim-lualine/lualine.nvim',
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
          'filename',
        },
        lualine_x = {},
        lualine_y = {
          {
            'progress',
            color = { bg = '#363a4f' },
          },
        },
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
      { 'rcarriga/nvim-notify', opts = { background_colour = '#000000' } },
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

  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nushell/tree-sitter-nu',
    },
    build = ':TSUpdate',
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

  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup()
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

  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        theme = 'doom',
        config = {
          header = {
            '                                                   ',
            '                                                   ',
            '                                                   ',
            '                                                   ',
            '                                                   ',
            '                                                   ',
            '                                                   ',
            '                                                   ',
            '                                                   ',
            '                                                   ',
            '                                                   ',
            '                                                   ',
            '                                                   ',
            '                                                   ',
            '                                                   ',
            ' ░░░    ░░ ░░░░░░░  ░░░░░░  ░░    ░░ ░░ ░░░    ░░░ ',
            ' ▒▒▒▒   ▒▒ ▒▒      ▒▒    ▒▒ ▒▒    ▒▒ ▒▒ ▒▒▒▒  ▒▒▒▒ ',
            ' ▒▒ ▒▒  ▒▒ ▒▒▒▒▒   ▒▒    ▒▒ ▒▒    ▒▒ ▒▒ ▒▒ ▒▒▒▒ ▒▒ ',
            ' ▓▓  ▓▓ ▓▓ ▓▓      ▓▓    ▓▓  ▓▓  ▓▓  ▓▓ ▓▓  ▓▓  ▓▓ ',
            ' ██   ████ ███████  ██████    ████   ██ ██      ██ ',
            '                                                   ',
            '                                                   ',
            '                                                   ',
            '                                                   ',
            '                                                   ',
          },
          center = {
            {
              icon = '',
              icon_hl = '@field',
              desc = '  New               ',
              desc_hl = '@field',
              key = 'a',
              key_hl = '@field',
              key_format = ' %s',
              action = 'enew',
            },
            {
              icon = '',
              icon_hl = '@field',
              desc = '  History',
              desc_hl = '@field',
              key = 'h',
              key_hl = '@field',
              key_format = ' %s',
              action = 'Telescope oldfiles',
            },
            {
              icon = '',
              icon_hl = '@field',
              desc = '  File Tree',
              desc_hl = '@field',
              key = 'e',
              key_hl = '@field',
              key_format = ' %s',
              action = 'MiniFiles.open()',
            },
            {
              icon = '',
              icon_hl = '@field',
              desc = '  Settings',
              desc_hl = '@field',
              key = 'c',
              key_hl = '@field',
              key_format = ' %s',
              action = 'NeovimConfig',
            },
            {
              icon = '',
              icon_hl = '@field',
              desc = '  Dotfiles',
              desc_hl = '@field',
              key = 'd',
              key_hl = '@field',
              key_format = ' %s',
              action = 'Dotfiles',
            },
            {
              icon = '',
              icon_hl = '@field',
              desc = '  Update',
              desc_hl = '@field',
              key = 'u',
              key_hl = '@field',
              key_format = ' %s',
              action = 'Lazy update',
            },
            {
              icon = '',
              icon_hl = '@field',
              desc = '  Quit',
              desc_hl = '@field',
              key = 'q',
              key_hl = '@field',
              key_format = ' %s',
              action = 'quit',
            },
          },
          footer = {},
        },
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },
}
