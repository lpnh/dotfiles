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
          -- Comment = { fg = colors.surface2 },
          CursorVisual = { bg = colors.surface0 },
          Visual = { bg = colors.surface0 },
          FzfLuaHeaderText = { fg = colors.pink },
          FzfLuaLiveSym = { fg = colors.pink },
          FzfLuaBufFlagCur = { fg = colors.pink },
        }
      end,
      integrations = {
        blink_cmp = true,
        noice = true,
        snacks = { enabled = true, indent_scope_color = 'surface2' },
        which_key = true,
      },
    }

    vim.cmd.colorscheme 'catppuccin'
  end,
}
