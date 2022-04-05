local n = require 'keymaps'.normal
local v = require 'keymaps'.visual

n {
    ['<leader>gg'] = ':G<cr>',
    ['<leader>glo'] = ':0Gclog<cr>',
    ['<leader>gll'] = ':Gclog<cr>',
    ['<leader>gl'] = ':diffget //3<cr>',
    ['<leader>gh'] = ':diffget //2<cr>',
}

v {
    ['<leader>gb'] = ':GBrowse<cr>'
}
