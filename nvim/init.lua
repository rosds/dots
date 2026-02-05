-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("options")
require("terminal")

require("lazy").setup("plugins", {
    install = {
        colorscheme = { "kanagawa-wave" },
    },
    checker = { enabled = true },
})

-- Add health check command for easy debugging
vim.api.nvim_create_user_command("CheckHealth", function()
    require("lazy").health()
    require("telescope").health()
    require("nvim-treesitter").health()
end, { desc = "Check health of all major plugins" })

require("globals")

vim.keymap.set({ "n", "i" }, "<S-Insert>", "<C-R>+", {})

-- Inserts a real tab with shift-tab
vim.keymap.set("i", "<s-tab>", "<c-q><tab>", { silent = false })

local n = require("keymaps").normal

local fs = R("utils.fs")
vim.api.nvim_create_user_command("FollowSymlink", fs.follow_symlink, { nargs = 0 })
vim.api.nvim_create_user_command("Fd", function(opts)
    fs.find_files(opts.args)
end, { nargs = 1 })

n({
    -- find and replace
    ["<leader>rr"] = { 'yiw:%s/<c-r>"//g<left><left>', silent = false },
    ["<leader>RR"] = function()
        local word = vim.fn.expand("<cword>")
        vim.ui.input({
            prompt = "Replace " .. word .. ": ",
            default = word,
        }, function(replace_with)
            if replace_with == nil then
                return
            end
            local cmd = string.format("rg -l -0 %s | xargs -0 sed -i 's/%s/%s/g'", word, word, replace_with)
            vim.system({ vim.o.shell, vim.o.shellcmdflag, cmd }, {
                text = true,
            }, function(res)
                if res.code == 0 then
                    vim.notify("Replace completed", vim.log.levels.INFO)
                else
                    vim.notify("Error during replace: " .. res.stderr, vim.log.levels.ERROR)
                end
            end):wait()
            vim.cmd("edit!")
        end)
    end,

    -- edit nvim config
    ["<leader>vc"] = function()
        vim.cmd.tabnew("$MYVIMRC")
        vim.cmd.lcd("%:p:h")
        vim.cmd.setlocal("path=.,**,,")
    end,
    -- reload nvim config
    ["<leader>vv"] = ":luafile $MYVIMRC<cr>",
    -- follow symlink
    ["<leader>ff"] = fs.follow_symlink,
    -- open file with the system's default
    ["<leader>go"] = ':silent execute "!xdg-open " . shellescape("<cWORD>")<cr>',
    -- set current buffer file directory as local working directory
    ["<leader>lcd"] = ":lcd %:p:h<cr>",
    -- yank path w/o line number
    ["<leader>yf"] = ":let @+ = expand('%:.')<cr>",
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
vim.keymap.set("v", "<leader>gx", 'y:silent execute "!xdg-open <c-r>""<cr>')

-- Yank path w/o line number
vim.keymap.set("v", "<LeftRelease>", '"+ygv', { desc = "yank on mouse selection" })

local init_lua_augroup = vim.api.nvim_create_augroup("init.lua", { clear = true })

-- remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    group = init_lua_augroup,
    command = "silent! %s/\\s\\+$//e",
})

vim.api.nvim_create_autocmd("BufReadPost", {
    group = init_lua_augroup,
    callback = function()
        fs.follow_symlink()
    end,
})

local qf_nav_group = vim.api.nvim_create_augroup("qf_nav_group", { clear = true })

-- convenient quickfix navigation
vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    group = qf_nav_group,
    callback = function(event)
        local opts = { buffer = event.buf, silent = true }
        vim.keymap.set("n", "<C-n>", "<cmd>cn<CR>zz<cmd>wincmd p<CR>", opts)
        vim.keymap.set("n", "<C-p>", "<cmd>cN<CR>zz<cmd>wincmd p<CR>", opts)
    end,
})

require("lsp")

-- Lua Rocks
require("luarocks")
