require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = require('telescope.actions').close,
      }
    }
  },
}

-------------------------------------------------------------------------------
-- Mappings
-------------------------------------------------------------------------------
local t = require('telescope.builtin')

Keymaps {
    ['<leader>p'] = t.fd,
    ['<leader>o'] = t.buffers,
    ['<leader><c-r>'] = t.command_history,
}

-- grep
vim.cmd [[
command! -nargs=1 Rg lua require("telescope.builtin").grep_string({ search = vim.api.nvim_eval('"<args>"') })
]]

nmap('<leader>rg', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]])
vmap('<leader>rg', [[y:lua require("telescope.builtin").grep_string({ search = '<c-r>"' })<cr>]])

nmap('<leader>rl', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]])

-- help
nmap('<leader>vh', [[<cmd>lua require('telescope.builtin').help_tags()<cr>]])
