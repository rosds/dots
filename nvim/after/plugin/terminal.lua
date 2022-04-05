local t = require 'keymaps'.terminal

t {
    ['<c-h>'] = '<c-\\><c-n>:TmuxNavigateLeft<cr>',
    ['<c-j>'] = '<c-\\><c-n>:TmuxNavigateDown<cr>',
    ['<c-k>'] = '<c-\\><c-n>:TmuxNavigateUp<cr>',
    ['<c-l>'] = '<c-\\><c-n>:TmuxNavigateRight<cr>',
    ['<esc>'] = '<c-\\><c-n>',
}

vim.cmd[[
augroup terminal
    autocmd!
    autocmd TermOpen * startinsert
    autocmd TermOpen * setlocal nonumber norelativenumber
    autocmd BufWinEnter,WinEnter term://* startinsert
augroup END
]]
