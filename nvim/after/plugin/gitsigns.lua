require('gitsigns').setup {
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        Keymaps {
            [']h'] = {
                "&diff ? ']c' : '<cmd>Gitsigns next_hunk<cr>'",
                expr = true,
                buffer = bufnr
            },
            ['[h'] = {
                "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'",
                expr = true,
                buffer = bufnr
            },
            ['<leader>hp'] = gs.preview_hunk,
            ['<leader>hu'] = gs.reset_hunk,
            ['<leader>hD'] = function() gs.diffthis('~') end,
            ['<leader>hb'] = function() gs.blame_line {full = true} end
        }
    end
}
