-- Open new terminal
local function alacritty_split()
  vim.api.nvim_command '!niri msg action maximize-column'
  vim.fn.jobstart { 'alacritty', '-T', 'alacritty_split' }
end

vim.api.nvim_create_user_command('AlacrittySplit', function() alacritty_split() end, {})

vim.keymap.set('n', '<leader>a', alacritty_split, {
  noremap = true,
  silent = true,
  desc = 'Open new terminal',
})

-- Let's have some fun
local function create_toggle_nav_keys()
  local is_disabled = false
  local nav_keys = { 'h', 'j', 'k', 'l' }

  local function toggle_fn()
    if is_disabled then
      for _, key in ipairs(nav_keys) do
        vim.keymap.del('n', key)
      end
      Snacks.notify('Navigation keys **enabled**', {
        title = 'vim motions are my passion',
        level = vim.log.levels.INFO,
      })
    else
      for _, key in ipairs(nav_keys) do
        vim.keymap.set('n', key, '<nop>', { noremap = true, silent = true })
      end
      Snacks.notify('Navigation keys **disabled**', {
        title = 'lol. good luck!',
        level = vim.log.levels.INFO,
      })
    end
    is_disabled = not is_disabled
  end

  return toggle_fn
end

local toggle_nav_keys = create_toggle_nav_keys()

vim.api.nvim_create_user_command('ToggleNavKeys', function() toggle_nav_keys() end, {})
