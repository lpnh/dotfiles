-- Add catppuccin ♥
-- Color references: https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/palettes/mocha.lua
-- Integrations: https://github.com/catppuccin/nvim?tab=readme-ov-file#integrations
return {
  'catppuccin/nvim',
  name = 'catppuccin', -- ??? Is this line necessary ???
  priority = 1000,
  lazy = false,
  config = function()
    require('catppuccin').setup {
      transparent_background = true,
      custom_highlights = function(colors)
        return {
          IblScope = { fg = colors.overlay0 },
          IblIndent = { fg = colors.surface1 },
          Comment = { fg = colors.overlay1 },
          LineNr = { fg = colors.overlay0 },
          WarningMsg = { style = { 'italic' } },
          ErrorMsg = { style = { 'italic' } },
          CursorLine = { bg = colors.surface1 },
          FloatBorder = { fg = colors.lavender },
          DashboardFooter = { fg = colors.pink },
        }
      end,
      integrations = {
        indent_blankline = {
          enabled = true,
          scope_color = 'surface1',
        },
        noice = true,
        which_key = true,
      },
    }
    require('catppuccin').load()
  end,
}
