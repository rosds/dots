tmap('<c-h>', '<c-\\><c-n>:TmuxNavigateLeft<cr>')
tmap('<c-j>', '<c-\\><c-n>:TmuxNavigateDown<cr>')
tmap('<c-k>', '<c-\\><c-n>:TmuxNavigateUp<cr>')
tmap('<c-l>', '<c-\\><c-n>:TmuxNavigateRight<cr>')
tmap('<esc>', '<c-\\><c-n>')

vim.cmd[[
augroup terminal
    autocmd!
    autocmd TermOpen * startinsert
    autocmd TermOpen * setlocal nonumber norelativenumber
    autocmd BufWinEnter,WinEnter term://* startinsert
augroup END
]]
