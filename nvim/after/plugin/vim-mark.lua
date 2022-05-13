local n = require 'keymaps'.normal

n {
    ['<leader>m'] = 'yiw:Mark <c-r>"<cr>',
    ['<leader>M'] = ':MarkClear<cr>',
}
