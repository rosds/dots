-- UI2 experimental
-- Private experimental UI APIs may be absent in stable Neovim builds.
local has_ui2, ui2 = pcall(require, "vim._core.ui2")
if has_ui2 then
    ui2.enable({ enable = false })
end

-- neovide font
if vim.g.neovide then
    vim.opt.guifont = "FiraCode Nerd Font Mono:h8"
    vim.g.neovide_opacity = 0.95
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

-- Show a status line in each window
vim.opt.laststatus = 2

-- Keep one command-line row visible
vim.opt.cmdheight = 1

vim.diagnostic.config({
    -- virtual_lines = {
    --     current_line = true,
    -- },
    virtual_text = true,
    -- float = {
    --     source = "if_many",
    -- },
})

-- folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

vim.opt.conceallevel = 2

-- Re-enable for debugging
vim.lsp.log.set_level("off")

-- disable local .nvimrc.lua files
vim.opt.exrc = false
