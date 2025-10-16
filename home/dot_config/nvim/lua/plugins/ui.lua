return {
  -- Icons
  { 'nvim-tree/nvim-web-devicons', opts = {} },

  -- Catppuccin
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        transparent_background = true,
        float = { transparent = true },
        custom_highlights = function(colors)
          return {
            Visual = { bg = colors.surface0 },
            FzfLuaHeaderText = { fg = colors.pink },
            FzfLuaLiveSym = { fg = colors.pink },
            FzfLuaBufFlagCur = { fg = colors.pink },
          }
        end,
        -- https://github.com/catppuccin/nvim?tab=readme-ov-file#integrations
        integrations = {
          noice = true,
          snacks = { enabled = true, indent_scope_color = 'surface2' },
          which_key = true,
        },
      }

      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  -- Cafetière :3
  { 'lpnh/cafetiere.nvim', opts = {} },

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

  -- Take care of messages, cmdline, and popups
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    opts = {
      cmdline = { enabled = true },
      messages = { enabled = true },
      popupmenu = { enabled = false },
      notify = { enabled = false },
      lsp = {
        progress = { enabled = false },
        hover = { silent = true },
        signature = { enabled = false },
        message = { enabled = false },
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      routes = {
        { view = 'notify', filter = { event = 'msg_showmode' } },
      },
      views = {
        popup = { scrollbar = false },
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
