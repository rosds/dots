-------------------------------------------------------------------------------
-- Mappings
-------------------------------------------------------------------------------

nmap('<leader>p', [[<cmd>lua require('telescope.builtin').find_files()<cr>]])
nmap('<leader>o', [[<cmd>lua require('telescope.builtin').buffers()<cr>]])
nmap('<leader>rg', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]])
nmap('<leader>rl', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]])
