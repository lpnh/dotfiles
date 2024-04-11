-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable unnecessary providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- See `:help option-list`
local opt = vim.opt

opt.breakindent = true -- Enable break indent
opt.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim.
opt.completeopt = 'menuone,noselect' -- Better completion experience
opt.expandtab = true -- Use spaces instead of tabs
opt.fillchars = {
  eob = ' ', -- Remove the `~` char on empty lines
  fold = ' ', -- Remove trailing char after fold title
}
opt.hlsearch = true -- Set search highlight as default
opt.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search
opt.inccommand = 'split' -- Preview substitutions live, as you type
opt.list = true -- Sets how neovim will display certain whitespaces
opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣',
}
opt.number = true -- Make line numbers default
opt.relativenumber = true -- Make relative number default
opt.shell = '/usr/bin/nu' -- Set nushell as default shell
opt.scrolloff = 10 -- Number of screen lines to keep above and below
opt.shiftwidth = 4 -- Number of spaces tabs count for
opt.shortmess:append 'sI' -- Disable nvim intro
opt.showmode = false -- Fix noice notification
opt.signcolumn = 'yes' -- Keep signcolumn on by default
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.softtabstop = 4
-- opt.spell = true -- Enable built in spellchecking
-- opt.spelllang = {
--   'en_us',
--   'pt_br',
-- }
opt.splitbelow = true -- New windows will appear below
opt.splitright = true
opt.laststatus = 3 -- Add line to split windows
opt.tabstop = 4 -- Set default indenting / tab spacing
opt.termguicolors = true -- True color support
opt.timeoutlen = 300 -- Decrease update time
opt.undofile = true -- Save undo history
opt.updatetime = 250 -- Decrease update time
