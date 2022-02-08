vim.cmd [[
    nnoremap <silent><expr> <leader>m ':Mark ' . expand('<cword>') . '<cr>'
    nnoremap <silent> <leader>M :MarkClear<cr>
]]
