local cb = require'diffview.config'.diffview_callback

require 'diffview'.setup {
    key_bindings = {
        file_history_panel = {
            ["]q"] = cb("select_next_entry"),
            ["[q"] = cb("select_prev_entry"),
        }
    }
}

local n = require 'keymaps'.normal

n {
    ['<leader>dv'] = ':DiffviewOpen<cr>',
    ['<leader>dq'] = ':DiffviewClose<cr>',
}
