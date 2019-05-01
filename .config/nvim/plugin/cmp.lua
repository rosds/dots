local cmp = require 'cmp'

cmp.setup({
    -- Enable LSP snippets
    snippet = {expand = function(args) vim.fn["vsnip#anonymous"](args.body) end},
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-u>'] = cmp.mapping.scroll_docs(4),
        ['<C-y>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
        })
    },

    -- Installed sources
    sources = {
        {name = 'nvim_lsp'}, {name = 'vsnip'}, {name = 'path'},
        {name = 'buffer', keyword_length = 5}
    }
})

-- lsp mappings

nmap('<leader>sd', '<cmd>lua vim.lsp.buf.definition()<cr>')       -- go to def
nmap('<leader>st', '<cmd>lua vim.lsp.buf.type_definition()<cr>')  -- go to type
nmap('<leader>si', '<cmd>lua vim.lsp.buf.implementation()<cr>')   -- go to impl
nmap('<leader>sa', '<cmd>lua vim.lsp.buf.code_action()<cr>')      -- code action
nmap('K',          '<cmd>lua vim.lsp.buf.hover()<cr>')
-- map.n(<c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
-- map.n(gr    <cmd>lua vim.lsp.buf.references()<CR>
-- map.n(g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
-- map.n(gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>


