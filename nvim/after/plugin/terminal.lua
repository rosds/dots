local t = require 'keymaps'.terminal

t {
    ['<c-h>'] = '<c-\\><c-n>:TmuxNavigateLeft<cr>',
    ['<c-j>'] = '<c-\\><c-n>:TmuxNavigateDown<cr>',
    ['<c-k>'] = '<c-\\><c-n>:TmuxNavigateUp<cr>',
    ['<c-l>'] = '<c-\\><c-n>:TmuxNavigateRight<cr>',
    ['<esc>'] = '<c-\\><c-n>',
}

-- terminal
local terminal = vim.api.nvim_create_augroup('terminal', {})
vim.api.nvim_create_autocmd('TermOpen', {
    pattern = '*',
    command = 'startinsert',
    group = terminal,
})
vim.api.nvim_create_autocmd('TermOpen', {
    pattern = '*',
    command = 'setlocal nonumber norelativenumber',
    group = terminal,
})
vim.api.nvim_create_autocmd({'BufWinEnter', 'WinEnter'}, {
    pattern = 'term://*',
    command = 'startinsert',
    group = terminal,
})
