return {
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            on_attach = function()
                local gs = package.loaded.gitsigns
                local km = require("keymaps")

                km.normal({
                    ["]h"] = gs.next_hunk,
                    ["[h"] = gs.prev_hunk,
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
        },
    },
}
