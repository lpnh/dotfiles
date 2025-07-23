return {
  -- Lualine
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      local ok, statusline = pcall(require, 'arrow.statusline')

      local function arrow()
        if ok then
          return statusline.text_for_statusline_with_icons()
        end
      end

      local mode_map = {
        n = '(ᴗ_ ᴗ。)',
        nt = '(ᴗ_ ᴗ。)',
        i = '(•̀ - •́ )',
        R = '( •̯́ ₃ •̯̀)',
        v = '(⊙ _ ⊙ )',
        V = '(⊙ _ ⊙ )',
        no = 'Σ(°△°ꪱꪱꪱ)',
        ['\22'] = '(⊙ _ ⊙ )',
        t = '(⌐■_■)',
        ['!'] = 'Σ(°△°ꪱꪱꪱ)',
        c = 'Σ(°△°ꪱꪱꪱ)',
        s = 'SUB',
      }

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'catppuccin',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = { 'snacks_dashboard' },
        },
        sections = {
          lualine_a = {
            {
              'mode',
              fmt = function()
                return mode_map[vim.api.nvim_get_mode().mode] or vim.api.nvim_get_mode().mode
              end,
            },
          },
          lualine_b = {
            { 'branch', separator = { right = '' }, color = { bg = '#363a4f' } },
            { 'diagnostics', separator = { right = '' }, color = { bg = '#363a4f' } },
          },
          lualine_c = { 'filename' },
          lualine_x = { arrow },
          lualine_y = { { 'progress', color = { bg = '#363a4f' } } },
        },
        extensions = { 'lazy', 'oil' },
      }
    end,
  },

  -- Take care of messages, cmdline and popupmenu
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    opts = {
      cmdline = {},
      lsp = {
        progress = { enabled = false },
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
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
        { view = 'notify', filter = { event = 'msg_showmode' } },
        {
          filter = { event = 'notify', find = '^.*WARNING.*vim.treesitter.get_parser.*$' },
          opts = { skip = true },
        },
      },
    },
  },

  -- Add git related signs to the gutter and other utilities
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

  -- Markdown
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = 'markdown',
    opts = {
      enabled = false,
      latex = { enabled = false },
    },
    keys = {
      {
        '<leader>tm',
        '<cmd>RenderMarkdown toggle<cr>',
        ft = 'markdown',
        desc = 'Toggle MD rendering',
      },
    },
  },
}
