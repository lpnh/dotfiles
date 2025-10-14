local map = vim.keymap.set

map({ 'n', 'v' }, '<space>', '<nop>', { silent = true })

-- Clear search highlight
map('n', '<esc>', '<cmd>nohlsearch<CR>')

-- Wrapped text navigation
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Scroll a small, consistent distance
map({ 'n', 'v' }, '<C-d>', '5j', { noremap = true })
map({ 'n', 'v' }, '<C-u>', '5k', { noremap = true })

-- Alternate buffer
map('n', '<A-Tab>', '<cmd>b#<CR>', { desc = 'Alternate buffer', silent = true })

-- Window navigation
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to left window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to upper window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to right window' })

-- Split window vertically (new window on the right)
map('n', '<C-S-l>', '<C-w>v', { noremap = true, silent = true, desc = 'Split window vertically' })

-- Split window horizontally (new window at the bottom)
map('n', '<C-S-j>', '<C-w>s', { noremap = true, silent = true, desc = 'Split window horizontally' })

-- Close window
map('n', '<leader>c', '<cmd>close<CR>', { desc = 'Close window' })

-- Paste and delete using the black hole
map('v', '<leader>p', '"_dP', { desc = 'Paste' })
map('v', '<leader>d', '"_d', { desc = 'Delete' })

-- Old habit to move lines around using `alt` key
map('n', '<A-j>', '<cmd>m .+1<CR>==', { desc = 'Move down' })
map('n', '<A-k>', '<cmd>m .-2<CR>==', { desc = 'Move up' })
map('i', '<A-j>', '<esc><cmd>m .+1<CR>==gi', { desc = 'Move down' })
map('i', '<A-k>', '<esc><cmd>m .-2<CR>==gi', { desc = 'Move up' })
