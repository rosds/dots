local saga = require 'lspsaga'
saga.init_lsp_saga()

-- lsp mappings
nmap('<leader>st', '<cmd>lua vim.lsp.buf.type_definition()<cr>') -- go to type
nmap('<leader>si', '<cmd>lua vim.lsp.buf.implementation()<cr>') -- go to impl
nmap('<leader>sh', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
-- nmap('<leader>sc', '<cmd>lua vim.lsp.buf.references()<cr>')
-- map.n(g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
-- map.n(gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

-- go to definition
nmap('<leader>sd', '<cmd>lua vim.lsp.buf.definition()<cr>') -- go to def
nmap('<leader>sj', "<cmd>lua require'lspsaga.provider'.lsp_finder()<cr>") -- go to def')
-- jump to the definition on a vertical split
nmap('<leader>sv', ':vs<cr><cmd>lua vim.lsp.buf.definition()<cr>') -- go to def

-- code action
-- nmap('<leader>sa', '<cmd>lua vim.lsp.buf.code_action()<cr>') -- code action
nmap('<leader>sa', "<cmd>lua require('lspsaga.codeaction').code_action()<CR>")

-- rename
-- nmap('<leader>sr', '<cmd>lua vim.lsp.buf.rename()<cr>') -- code action
nmap('<leader>sr', "<cmd>lua require'lspsaga.rename'.rename()<cr>") -- code action

-- diagnostic
-- nmap('<leader>se', "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})<cr>") -- code action
-- nmap(']e', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>')
-- nmap('[e', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>')
nmap('<leader>se', "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>") -- code action
nmap('[e', ':Lspsaga diagnostic_jump_next<cr>')
nmap(']e', ':Lspsaga diagnostic_jump_prev<cr>')

-- doc
-- nmap('K', '<cmd>lua vim.lsp.buf.hover()<cr>')
nmap('K', "<cmd>lua require'lspsaga.hover'.render_hover_doc()<cr>")


