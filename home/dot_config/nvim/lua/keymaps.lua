-- Keymaps for better default experience
-- See `:help vim.keymap.set()`

local map = vim.keymap

map.set({ 'n', 'v' }, '<space>', '<nop>', { silent = true })

-- Favor `surround` keybindings instead
map.set('n', 's', '<nop>', { noremap = true, silent = true })

-- Remap `;` to `:` for convenience
map.set({ 'n', 'v' }, ';', ':', { desc = 'Enter command-line mode' })

-- Clear highlight (search) on pressing <Esc> in normal mode
map.set('n', '<esc>', '<cmd>nohlsearch<CR>')

-- Remap for dealing with word wrap
map.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to left window' })
map.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to lower window' })
map.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to upper window' })
map.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to right window' })

-- Alternate buffer
map.set('n', '<A-Tab>', '<cmd>b#<CR>', { desc = 'Alternate buffer', silent = true })

-- Close buffer
map.set('n', '<leader>x', '<C-w>c', { desc = 'Close current buffer' })

-- Center buffer while navigating
map.set('n', '<C-d>', '<C-d>zz')
map.set('n', '<C-u>', '<C-u>zz')

-- Make replace less painful
map.set('x', '<leader>p', [["_dP]], { desc = 'Replace while pasting' })
map.set('v', '<leader>d', [["_d]], { desc = 'Deleting using black hole' })

-- Copy all
map.set('n', '<C-c>', '<cmd>%y+<CR>', { desc = 'Copy entire file' })

-- Split window vertically - New window on the right
map.set('n', '<C-S-l>', '<C-w>v', { noremap = true, silent = true, desc = 'Split window vertically' })

-- Split window horizontally - New window at the bottom
map.set('n', '<C-S-j>', '<C-w>s', { noremap = true, silent = true, desc = 'Split window horizontally' })

-- Old addiction to move lines around using `alt` key
map.set('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move down' })
map.set('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move up' })
map.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move down' })
map.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move up' })

-- Disable arrow keys in normal mode
map.set('n', '<left>', '<cmd>echo "TJ does not allow this"<CR>')
map.set('n', '<right>', '<cmd>echo "TJ does not allow this"<CR>')
map.set('n', '<up>', '<cmd>echo "TJ does not allow this"<CR>')
map.set('n', '<down>', '<cmd>echo "TJ does not allow this"<CR>')

-- Highlight when yanking text
-- See `:help lua-guide-autocommands`
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
