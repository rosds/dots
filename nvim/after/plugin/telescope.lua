local actions = require 'telescope.actions'
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<c-u>"] = false,
        ["<c-i>"] = actions.toggle_selection,
        ["<c-g>"] = actions.send_to_qflist,
        ["<c-f>"] = actions.send_selected_to_qflist,
      }
    }
  },
}

-------------------------------------------------------------------------------
-- Mappings
-------------------------------------------------------------------------------
local t = require('telescope.builtin')
local n = require 'keymaps'.normal
local v = require 'keymaps'.visual

-- grep
vim.cmd [[
command! -nargs=1 Rg lua require("telescope.builtin").grep_string({ search = vim.api.nvim_eval('"<args>"') })
]]

n {
    ['<leader>p'] = t.fd,
    ['<leader>o'] = t.buffers,
    ['<leader><c-r>'] = t.command_history,
    ['<leader>rg'] = t.grep_string,
    ['<leader>rl'] = t.live_grep,
    ['<leader>vh'] = t.help_tags,
}

v {
    ['<leader>rg'] = [[y:lua require("telescope.builtin").grep_string({ search = '<c-r>"' })<cr>]],
}
