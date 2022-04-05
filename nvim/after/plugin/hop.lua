local km = require 'keymaps'
local hop = require 'hop'

hop.setup{}

km.mode({'n', 'v'}) {
    ['<leader>j'] = hop.hint_char1,
}
