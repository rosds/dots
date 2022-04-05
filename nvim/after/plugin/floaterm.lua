local n = require 'keymaps'.normal

n {
    ['<F1>'] = ':FloatermToggle<cr>',
}

vim.cmd [[
augroup NVIM_FLOATERM
autocmd!
autocmd FileType floaterm tnoremap <buffer> <F1> <c-\><c-n>:FloatermToggle<cr>
augroup END
]]
