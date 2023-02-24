vim.g.mapleader = " "

require("options")
require("globals")

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

local function edit_symlink_origin()
    local symlink = vim.fn.fnamemodify(vim.fn.expand("%"), ":p")
    local origin = vim.fn.resolve(vim.fn.fnamemodify(symlink, ":h"))
    vim.cmd("edit " .. origin)
end

vim.api.nvim_create_user_command("EditSymlinkOrigin", edit_symlink_origin, { nargs = 0 })

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
    -- open file with the system's default
    ["<leader>go"] = ':silent execute "!xdg-open " . shellescape("<cWORD>")<cr>',
    -- set current buffer file directory as local working directory
    ["<leader>lcd"] = ":lcd %:p:h<cr>",
    -- yank path with line number
    ["<leader>yF"] = ":let @+ = join([expand('%:p'), line('.')],':')<cr>",
    -- disable ighlight
    ["<esc><esc>"] = ":noh<cr>",
    -- toggle diagnostics
    ["<leader>td"] = function()
        if not vim.b.diagnostic_disabled then
            vim.diagnostic.disable()
            vim.b.diagnostic_disabled = true
        else
            vim.diagnostic.enable()
            vim.b.diagnostic_disabled = false
        end
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
ag("AllFile")({
    {
        "BufWritePre",
        command = "silent! %s/\\s\\+$//e",
    },
})

vim.cmd([[colorscheme everforest]])
