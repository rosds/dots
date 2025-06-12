-- neovide font
if vim.g.neovide then
    vim.opt.guifont = "FiraCode Nerd Font:h8"
    vim.g.neovide_transparency = 0.95
end

vim.g.python3_host_prog = "/home/alfonso.ros/.pyenv/versions/neovim-env/bin/python"

-- spaces instead of tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- no swap files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 100

-- complete options
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:remove("c")
vim.opt.shortmess:append("c")

-- splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- max column width
vim.opt.textwidth = 128
vim.opt.formatoptions:remove("t")
vim.opt.formatoptions:append("t")
vim.opt.formatoptions:remove("o") -- no wrap comments on 'o' or 'O'

vim.opt.autochdir = false

vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.scroll = 10
vim.opt.scrolloff = 8

vim.opt.termguicolors = true

-- preview the search replacement result
vim.opt.inccommand = "split"

-- color scheme
vim.opt.background = "dark"

-- mark spaces
vim.opt.list = true
vim.opt.listchars = "eol:¬,tab:>-" -- ,tab:»·,trail:·,nbsp:·,extends:>,precedes:<"

-- use system clipboard
-- vim.opt.clipboard = "unnamed"
vim.opt.clipboard = "unnamedplus"

-- show the sign in the number column if it is not present
-- vim.o.signcolumn = "number"
vim.opt.signcolumn = "auto"
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.cursorline = true

-- have one global status line
vim.opt.laststatus = 2

-- hide the command line
vim.opt.cmdheight = 1

vim.diagnostic.config({
    virtual_lines = {
        current_line = true,
    },
    -- float = {
    --     source = "if_many",
    -- },
})

-- folding
vim.opt.foldlevel = 8
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.opt.conceallevel = 2

-- Re-enable for debugging
vim.lsp.set_log_level("off")
