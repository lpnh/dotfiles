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
        float = { transparent = true, solid = false },
        custom_highlights = function(colors)
          return {
            Visual = { bg = colors.surface0 },
            BlinkCmpMenuSelection = { bg = colors.surface0 },
            FzfLuaHeaderText = { fg = colors.pink },
            FzfLuaLiveSym = { fg = colors.pink },
            FzfLuaBufFlagCur = { fg = colors.pink },
            SnippetTabstop = {},
            SnippetTabstopActive = {},
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
      local mode_map = {
        n = '(ᴗ_ ᴗ。)',
        nt = '(ᴗ_ ᴗ。)',
        i = '(•̀ - •́ )',
        R = '( •̯́ ₃ •̯̀)',
        v = '(⊙ _ ⊙ )',
        V = '(⊙ _ ⊙ )',
        no = 'Σ(°△°ꪱꪱꪱ)',
        ['\22'] = '(⊙ _ ⊙ )',
        t = '(＾▽＾)',
        ['!'] = 'Σ(°△°ꪱꪱꪱ)',
        c = 'Σ(°△°ꪱꪱꪱ)',
        s = '(^_-)',
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
                if vim.snippet and vim.snippet.active() then
                  return '( ･ω･)ﾉ'
                end
                if vim.fn.reg_recording() ~= '' then
                  return '(・・；)'
                end
                return mode_map[vim.api.nvim_get_mode().mode] or vim.api.nvim_get_mode().mode
              end,
            },
          },
          lualine_b = {
            { 'branch', separator = { right = '' }, color = { bg = '#363a4f' } },
            { 'diagnostics', separator = { right = '' }, color = { bg = '#363a4f' } },
          },
          lualine_c = { 'filename' },
          lualine_x = {},
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
    },
  },

  -- Git signs
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
