vim.g.mapleader = " "

require 'options'
require 'plugins'
require 'globals'

vim.cmd.colorscheme("gruvbox")

if vim.fn.getenv("TERM") ~= vim.NIL then
    vim.cmd [[hi normal guibg=none]]
end

local v = require 'keymaps'.visual
local n = require 'keymaps'.normal

n {
    -- find and replace
    ['<leader>rr'] = { 'yiw:%s/<c-r>"//g<left><left>', silent = false },

    -- edit nvim config
    ['<leader>vc'] = function()
        vim.cmd [[
                vsplit $MYVIMRC
                lcd %:p:h
                setlocal path=.,**,,
              ]]
    end,

    -- quickfix list
    [']q'] = ':cnext<cr>',
    ['[q'] = ':cprev<cr>',
    [']Q'] = ':cfirst<cr>',
    ['[Q'] = ':clast<cr>',

    -- open file with the system's default
    ['<leader>go'] = ':silent execute "!xdg-open " . shellescape("<cWORD>")<cr>',

    -- set current buffer file directory as local working directory
    ['<leader>lcd'] = ':lcd %:p:h<cr>',

    -- yank path with line number
    ['<leader>yF'] = ":let @+ = join([expand('%:p'), line('.')],':')<cr>",

    -- disable highlight
    ['<esc><esc>'] = ":noh<cr>",

    -- toggle diagnostics
    ['<leader>td'] = function()
        if vim.g.is_diagnostic_enabled == nil then
            vim.g.is_diagnostic_enabled = false
        end

        if vim.g.is_diagnostic_enabled == true then
            vim.diagnostic.disable()
            vim.g.is_diagnostic_enabled = false
        else
            vim.diagnostic.enable()
            vim.g.is_diagnostic_enabled = true
        end
    end,

    -- zoom in/out
    Zi = '<c-w>_|<c-w>|',
    Zo = '<c-w>=',
}

v {
    ['<leader>rr'] = { 'y:%s/<c-r>"//g<left><left>', silent = false },
    ['<leader>go'] = 'y:silent execute "!xdg-open <c-r>""<cr>',
}

local ag = require "augroup".augroup
ag "AllFile" {
    {
        'BufWritePre',
        command = "silent! %s/\\s\\+$//e",
    }
}
