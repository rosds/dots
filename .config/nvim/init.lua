require 'plugins'

-------------------------------------------------------------------------------
-- general config
-------------------------------------------------------------------------------

vim.g.mapleader = " "

-- spaces instead of tabs
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.updatetime = 100

-- complete options
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.shortmess = vim.o.shortmess .. "c"

vim.o.splitbelow = true -- when splitting horizontally, put the new window below
vim.o.splitright = true -- when splitting vertically, put the new window to the right

-- max column width to 80
vim.o.tw = 80
vim.o.fo = vim.o.fo .. "t"

vim.o.smartcase = true
vim.o.ignorecase = true

vim.o.scrolloff = 8

vim.o.termguicolors = true

-- preview the swarch replacement result
vim.o.inccommand = "split"

-- color scheme
vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])

-------------------------------------------------------------------------------
-- modules
-------------------------------------------------------------------------------

require 'mappings'
