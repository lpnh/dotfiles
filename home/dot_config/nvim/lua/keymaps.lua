local map = vim.keymap.set

map({ 'n', 'v' }, '<space>', '<nop>', { silent = true })

-- Favor `surround` instead
map('n', 's', '<nop>', { noremap = true, silent = true })

-- Clear highlight (search)
map('n', '<esc>', '<cmd>nohlsearch<cr>')

-- Open diagnostic float window
map('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Diagnostic float window' })

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move to window using hjkl keys
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to left window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to upper window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to right window' })

-- Alternate buffer
map('n', '<A-Tab>', '<cmd>b#<cr>', { desc = 'Alternate buffer', silent = true })

-- Close window
map('n', '<leader>c', '<C-w>c', { desc = 'Close window' })

-- Paste and delete using the black hole
map('x', '<leader>p', '"_dP', { desc = 'Paste' })
map('v', '<leader>d', '"_d', { desc = 'Delete' })

-- Split window vertically - New window on the right
map('n', '<C-S-l>', '<C-w>v', { noremap = true, silent = true, desc = 'Split window vertically' })

-- Split window horizontally - New window at the bottom
map('n', '<C-S-j>', '<C-w>s', { noremap = true, silent = true, desc = 'Split window horizontally' })

-- Old addiction to move lines around using `alt` key
map('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move down' })
map('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move up' })
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move down' })
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move up' })

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
        title = 'the party is over',
        level = vim.log.levels.INFO,
      })
    else
      for _, key in ipairs(nav_keys) do
        map('n', key, '<nop>', { noremap = true, silent = true })
      end
      Snacks.notify('Navigation keys **disabled**', {
        title = 'have fun',
        level = vim.log.levels.INFO,
      })
    end
    is_disabled = not is_disabled
  end

  return toggle_fn
end

local toggle_nav_keys = create_toggle_nav_keys()

vim.api.nvim_create_user_command('ToggleNavKeys', function() toggle_nav_keys() end, {})

map('n', '<leader>tn', toggle_nav_keys, {
  noremap = true,
  silent = true,
  desc = 'Toggle navigation keys',
})
