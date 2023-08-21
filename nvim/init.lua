vim.g.mapleader = " "

require("options")
require("globals")
require("terminal")

-- lazy bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

local v = require("keymaps").visual
local n = require("keymaps").normal

local follow_symlink = require("utils.fs").follow_symlink

vim.api.nvim_create_user_command("FollowSymlink", follow_symlink, { nargs = 0 })

n({
    -- find and replace
    ["<leader>rr"] = { 'yiw:%s/<c-r>"//g<left><left>', silent = false },
    -- edit nvim config
    ["<leader>vc"] = function()
        vim.cmd.vsplit("$MYVIMRC")
        vim.cmd.lcd("%:p:h")
        vim.cmd.setlocal("path=.,**,,")
    end,
    -- reload nvim config
    ["<leader>vv"] = ":luafile $MYVIMRC<cr>",
    -- quickfix list
    ["]q"] = ":cnext<cr>",
    ["[q"] = ":cprev<cr>",
    ["]Q"] = ":cfirst<cr>",
    ["[Q"] = ":clast<cr>",
    -- follow symlink
    ["<leader>ff"] = follow_symlink,
    -- open file with the system's default
    ["<leader>go"] = ':silent execute "!xdg-open " . shellescape("<cWORD>")<cr>',
    -- set current buffer file directory as local working directory
    ["<leader>lcd"] = ":lcd %:p:h<cr>",
    -- yank path w/o line number
    ["<leader>yf"] = ":let @+ = expand('%:p')<cr>",
    -- yank path with line number
    ["<leader>yF"] = ":let @+ = join([expand('%:p'), line('.')],':')<cr>",
    -- disable ighlight
    ["<esc><esc>"] = ":noh<cr>",
    -- toggle diagnostics
    ["<leader>td"] = function()
        if not vim.b.diagnostic_disabled then
            vim.diagnostic.disable()
        else
            vim.diagnostic.enable()
        end
        vim.b.diagnostic_disabled = not vim.b.diagnostic_disabled
    end,
    -- zoom in/out
    Zi = "<c-w>_|<c-w>|",
    Zo = "<c-w>=",
})

v({
    ["<leader>rr"] = { 'y:%s/<c-r>"//g<left><left>', silent = false },
    ["<leader>go"] = 'y:silent execute "!xdg-open <c-r>""<cr>',
})

local ag = require("augroup").augroup
ag("AllFiles")({
    {
        "BufWritePre",
        command = "silent! %s/\\s\\+$//e",
    },
})

vim.cmd([[colorscheme gruvbox]])
