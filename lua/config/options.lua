-- basic configs
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.opt.number = true
vim.opt.cc = { 100, }
vim.o.textwidth = 100
vim.wo.signcolumn = 'yes'
vim.g.mapleader = ','
vim.o.termguicolors = true
vim.wo.cursorline = true

-- borders for floating windows etc.
vim.o.winborder = "rounded"

-- show whitespace
vim.cmd([[set list]])
vim.cmd([[set listchars=trail:~,tab:>-,nbsp:␣]])

-- spell checking
vim.opt.spelllang = 'en'
vim.opt.spellsuggest = 'best,8'
