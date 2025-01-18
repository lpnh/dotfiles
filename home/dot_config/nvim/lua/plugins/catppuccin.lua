-- Color references: https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/palettes/mocha.lua
-- Integrations: https://github.com/catppuccin/nvim?tab=readme-ov-file#integrations
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  lazy = false,
  config = function()
    require('catppuccin').setup {
      transparent_background = true,
      custom_highlights = function(colors)
        return {
          Comment = { fg = colors.surface2 },
          CursorVisual = { bg = colors.surface0 },
          FzfLuaHeaderText = { fg = colors.pink },
          FzfLuaLiveSym = { fg = colors.pink },
          FzfLuaBufFlagCur = { fg = colors.pink },
          SnacksIndentScope = { fg = colors.surface2 },
          SnacksIndent = { fg = colors.surface0 },
          Visual = { bg = colors.surface0 },
          -- DiagnosticVirtualTextInfo = { fg = colors.teal },
          -- LineNr = { fg = colors.overlay0 },
          -- WarningMsg = { style = { 'italic' } },
          -- ErrorMsg = { style = { 'italic' } },
          -- CursorLine = { bg = colors.surface0 },
          -- FloatBorder = { fg = colors.lavender },
          -- DashboardFooter = { fg = colors.pink },
          -- LazyButton = { bg = colors.mantle },
          -- LazyButtonActive = { bg = colors.surface0 },
          -- TelescopeSelection = { fg = colors.rosewater },
        }
      end,
      integrations = {
        blink_cmp = true,
        mason = true,
        noice = true,
        snacks = true,
        which_key = true,
      },
    }

    vim.cmd.colorscheme 'catppuccin'
  end,
}
