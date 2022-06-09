local n = require 'keymaps'.normal
local v = require 'keymaps'.visual

n {
    ['<leader>m'] = 'yiw:silent Mark <c-r>"<cr>',
    ['<leader>M'] = ':silent MarkClear<cr>',
}

v {
    ['<leader>m'] = 'y:silent Mark <c-r>"<cr>',
}
