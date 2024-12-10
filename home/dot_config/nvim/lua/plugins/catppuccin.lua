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
          SnacksIndentScope = { fg = colors.surface2 },
          SnacksIndent = { fg = colors.surface0 },
          --     Comment = { fg = colors.overlay1 },
          --     LineNr = { fg = colors.overlay0 },
          --     WarningMsg = { style = { 'italic' } },
          --     ErrorMsg = { style = { 'italic' } },
          --     CursorLine = { bg = colors.surface0 },
          --     FloatBorder = { fg = colors.lavender },
          --     DashboardFooter = { fg = colors.pink },
          --     LazyButton = { bg = colors.mantle },
          --     LazyButtonActive = { bg = colors.surface0 },
          --     TelescopeSelection = { fg = colors.rosewater },
          --     Visual = { bg = colors.surface0 },
        }
      end,
      integrations = {
        beacon = true,
        indent_blankline = {
          enabled = true,
          scope_color = 'surface1',
        },
        mason = true,
        noice = true,
        notify = true,
        snacks = true,
        which_key = true,
      },
    }

    vim.cmd.colorscheme 'catppuccin'
  end,
}
