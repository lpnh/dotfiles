-- Keymaps for better default experience
-- See `:help vim.keymap.set()`

local map = vim.keymap;

map.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap `;` to `:` for convenience
map.set({ 'n', 'v' }, ';', ':')

-- Clear highlight (search) on pressing <Esc> in normal mode
map.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Remap for dealing with word wrap
map.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
map.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic  [Q]uickfix list' })

-- Move to window using the <ctrl> hjkl keys
map.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to left window' })
map.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to lower window' })
map.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to upper window' })
map.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to right window' })

-- Explorer - MiniFile
map.set('n', '<leader>e', '<cmd>:lua MiniFiles.open()<cr>', { desc = 'Open file explorer - MiniFiles.open()' })

-- Close buffer
map.set('n', '<leader>x', '<C-w>c', { desc = 'Close current buffer' })

-- Center buffer while navigating
map.set('n', '<C-d>', '<C-d>zz')
map.set('n', '<C-u>', '<C-u>zz')

-- Find/replace for the word under the cursor
map.set('n', '<leader>S', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = 'Find/Replace word under cursor' })

-- Why people remap this ?
map.set('n', 'Q', '<Nop>')

-- Make replace less painful
map.set('x', '<leader>p', [["_dP]], { desc = 'Replace while pasting' })
map.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Deleting using a black hole' })

-- Copy all
map.set('n', '<C-c>', '<cmd>%y+<CR>', { desc = 'Copy entire file' })

-- Split window vertically - New window on the [L]eft
map.set('n', '<leader>L', '<C-w>v', { noremap = true, silent = true, desc = 'Split window vertically' })

-- Old addiction to move lines around using `alt` key
map.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Disable arrow keys in normal mode
map.set('n', '<left>', '<cmd>echo "TJ does not allow this, sorry"<CR>')
map.set('n', '<right>', '<cmd>echo "TJ does not allow this, sorry"<CR>')
map.set('n', '<up>', '<cmd>echo "TJ does not allow this, sorry"<CR>')
map.set('n', '<down>', '<cmd>echo "TJ does not allow this, sorry"<CR>')

-- Highlight when yanking text
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- See `:help lua-guide-autocommands`

-- Select all
-- vim.keymap.set('n', '<C-a>', 'gg<S-v>G', { desc = 'Select all' })

-- Save
-- map.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Add terminal buffer
-- map.set('n', '<A-i>', '<C-w>v<cmd>terminal<CR>i')
