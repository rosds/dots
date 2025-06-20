-- lazy bootstrap
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
    local lazy_repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazy_repo,
        lazy_path,
    })
end
vim.opt.rtp:prepend(lazy_path)

vim.g.mapleader = " "

require("options")
require("globals")
require("terminal")

require("lazy").setup("plugins", {
    install = {
        colorscheme = { "kanagawa-wave" },
    },
    checker = { enabled = true },
})

vim.keymap.set({ "n", "i" }, "<S-Insert>", "<C-R>+", {})

-- Inserts a real tab with shift-tab
vim.keymap.set("i", "<s-tab>", "<c-q><tab>", { silent = false })

local n = require("keymaps").normal

local follow_symlink = require("utils.fs").follow_symlink

vim.api.nvim_create_user_command("FollowSymlink", follow_symlink, { nargs = 0 })


n({
    -- find and replace
    ["<leader>rr"] = { 'yiw:%s/<c-r>"//g<left><left>', silent = false },
    -- edit nvim config
    ["<leader>vc"] = function()
        vim.cmd.tabnew("$MYVIMRC")
        vim.cmd.lcd("%:p:h")
        vim.cmd.setlocal("path=.,**,,")
    end,
    -- reload nvim config
    ["<leader>vv"] = ":luafile $MYVIMRC<cr>",
    -- follow symlink
    ["<leader>ff"] = follow_symlink,
    -- open file with the system's default
    ["<leader>go"] = ':silent execute "!xdg-open " . shellescape("<cWORD>")<cr>',
    -- set current buffer file directory as local working directory
    ["<leader>lcd"] = ":lcd %:p:h<cr>",
    -- yank path w/o line number
    ["<leader>yf"] = ":let @+ = expand('%:p')<cr>",
    -- yank path with line number
    ["<leader>yF"] = ":let @\" = join([expand('%:p'), line('.')],':')<cr>",
    -- disable ighlight
    ["<esc><esc>"] = ":noh<cr>",
    -- toggle diagnostics
    ["<leader>td"] = function()
        vim.diagnostic.enable(not vim.diagnostic.is_enabled())
    end,
    ["<leader>qq"] = function()
        if not not vim.g.qf_toggle then
            vim.cmd("cclose")
            vim.g.qf_toggle = false
        else
            vim.cmd("copen")
            vim.g.qf_toggle = true
        end
    end,
    -- zoom in/out
    Zi = "<c-w>_|<c-w>|",
    Zo = "<c-w>=",
})

-- Search and replace old fashion way
vim.keymap.set("v", "<leader>rr", 'y:%s/<c-r>"//g<left><left>', { silent = false })

-- Open file with system's default
vim.keymap.set("v", "<leader>go", 'y:silent execute "!xdg-open <c-r>""<cr>')

-- Yank path w/o line number
vim.keymap.set("v", "<LeftRelease>", '"+ygv', { desc = "yank on mouse selection" })

local ag = require("augroup").augroup
ag("AllFiles")({
    {
        "BufWritePre",
        command = "silent! %s/\\s\\+$//e",
    },
})

local group = vim.api.nvim_create_augroup("qf_group", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    group = group,
    callback = function(event)
        local opts = { buffer = event.buf, silent = true }
        vim.keymap.set("n", "<C-n>", "<cmd>cn<CR>zz<cmd>wincmd p<CR>", opts)
        vim.keymap.set("n", "<C-p>", "<cmd>cN<CR>zz<cmd>wincmd p<CR>", opts)
    end,
})

vim.cmd.colorscheme("kanagawa-wave")

-- Lua Rocks
require("luarocks")
