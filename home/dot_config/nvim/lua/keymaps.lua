local map = vim.keymap.set

map({ 'n', 'v' }, '<space>', '<nop>', { silent = true })

-- Favor `surround` keybindings instead
map('n', 's', '<nop>', { noremap = true, silent = true })

-- Remap `;` to `:` for convenience
map({ 'n', 'v' }, ';', ':', { desc = 'Enter command-line mode' })

-- Clear highlight (search)
map('n', '<esc>', '<cmd>nohlsearch<CR>')

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move to window using hjkl keys
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to left window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to upper window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to right window' })

-- Alternate buffer
map('n', '<A-Tab>', '<cmd>b#<CR>', { desc = 'Alternate buffer', silent = true })

-- Close buffer
map('n', '<leader>c', '<C-w>c', { desc = 'Close current buffer' })

-- Center buffer while navigating
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- Make replace less painful
map('x', '<leader>p', [["_dP]], { desc = 'Replace while pasting' })
map('v', '<leader>d', [["_d]], { desc = 'Deleting using black hole' })

-- Split window vertically - New window on the right
map('n', '<C-S-l>', '<C-w>v', { noremap = true, silent = true, desc = 'Split window vertically' })

-- Split window horizontally - New window at the bottom
map('n', '<C-S-j>', '<C-w>s', { noremap = true, silent = true, desc = 'Split window horizontally' })

-- Old addiction to move lines around using `alt` key
map('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move down' })
map('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move up' })
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move down' })
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move up' })

-- Disable arrow keys in normal mode
map('n', '<left>', '<cmd>echo "TJ does not allow this"<CR>')
map('n', '<right>', '<cmd>echo "TJ does not allow this"<CR>')
map('n', '<up>', '<cmd>echo "TJ does not allow this"<CR>')
map('n', '<down>', '<cmd>echo "TJ does not allow this"<CR>')

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
