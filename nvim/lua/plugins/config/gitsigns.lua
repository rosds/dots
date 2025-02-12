local gs = require("gitsigns")

gs.setup(
    {
        on_attach = function()
            local km = require("keymaps")

            -- jump hunks
            vim.keymap.set('n', "]h", function() gs.nav_hunk('next') end)
            vim.keymap.set('n', "[h", function() gs.nav_hunk('prev') end)

            -- stage hunk
            vim.keymap.set('n', "<leader>hs", gs.stage_hunk)
            vim.keymap.set('v', "<leader>hs", function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)

            km.normal({
                ["<leader>hs"] = gs.stage_hunk,
                ["<leader>hu"] = gs.reset_hunk,
                ["<leader>hU"] = gs.reset_buffer,
                ["<leader>hp"] = gs.preview_hunk,
                ["<leader>hd"] = gs.diffthis,
                ["<leader>hD"] = function()
                    gs.diffthis("~")
                end,
                ["<leader>hb"] = gs.toggle_current_line_blame,
                ["<leader>hB"] = function()
                    gs.blame_line({ full = true })
                end,
            })

            km.mode({ "o", "x" })({
                ah = ":<C-U>Gitsigns select_hunk<cr>",
                ih = ":<C-U>Gitsigns select_hunk<cr>",
            })
        end,
    })
