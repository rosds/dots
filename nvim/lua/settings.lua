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
vim.o.completeopt = "menu,menuone,noselect"
vim.o.shortmess = vim.o.shortmess .. "c"

vim.o.splitbelow = true -- when splitting horizontally, put the new window below
vim.o.splitright = true -- when splitting vertically, put the new window to the right

-- max column width to 80
vim.o.tw = 80
vim.o.fo = vim.o.fo .. "t"

vim.o.smartcase = true
vim.o.ignorecase = true

vim.o.scroll = 10
vim.o.scrolloff = 8

vim.o.termguicolors = true

-- preview the swarch replacement result
vim.o.inccommand = "split"

-- color scheme
vim.o.background = "dark"

-- mark spaces
vim.o.list = true
vim.o.listchars = "eol:¬" -- ,tab:»·,trail:·,nbsp:·,extends:»,precedes:<,eol:¬"

-- use system clipboard
vim.o.clipboard = "unnamedplus"

vim.o.compatible = false

vim.o.signcolumn = "number"

-- no swap files
vim.cmd([[
    set noswapfile
    set nobackup
    set nowritebackup

    filetype plugin on

    augroup AllFiles
    autocmd!
    autocmd BufWritePre * :%s/\s\+$//e
    augroup END
]])
