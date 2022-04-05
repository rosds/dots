-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require'nvim-tree'.setup {}

-------------------------------------------------------------------------------
-- Mappings
-------------------------------------------------------------------------------
local n = require 'keymaps'.normal

n {
    ['<leader>nn'] = ':NvimTreeFindFileToggle<cr>',
    ['<leader>nc'] = ':NvimTreeClose<cr>',
}

vim.cmd [[
    hi NvimTreeSWindowPicker ctermfg=Green guifg=Green gui=bold
]]

