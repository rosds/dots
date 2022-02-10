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

-- Keymaps {
--     ['<leader>p'] = require('telescope.builtin').fd,
--     ['<leader>o'] = require('telescope.builtin').buffers,
--     ['<leader><c-r>'] = require('telescope.builtin').command_history,
-- }
nmap('<leader>p', '<cmd>lua require("telescope.builtin").fd()<cr>')
nmap('<leader>o', '<cmd>lua require("telescope.builtin").buffers()<cr>')
nmap('<leader><c-r>', '<cmd>lua require("telescope.builtin").command_history()<cr>')

-- lsp
nmap('<leader>sc', [[<cmd>lua require('telescope.builtin').lsp_references()<cr>]])
nmap('<leader>ss', [[<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>]])

-- grep
vim.cmd [[
command! -nargs=1 Rg lua require("telescope.builtin").grep_string({ search = vim.api.nvim_eval('"<args>"') })
]]

nmap('<leader>rg', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]])
vmap('<leader>rg', [[y:lua require("telescope.builtin").grep_string({ search = '<c-r>"' })<cr>]])

nmap('<leader>rl', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]])

-- help
nmap('<leader>vh', [[<cmd>lua require('telescope.builtin').help_tags()<cr>]])
