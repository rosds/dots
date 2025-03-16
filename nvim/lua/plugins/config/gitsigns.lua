local gs = require("gitsigns")

gs.setup(
    {
        on_attach = function()
            -- jump hunks
            vim.keymap.set('n', "]h", function() gs.nav_hunk('next') end)
            vim.keymap.set('n', "[h", function() gs.nav_hunk('prev') end)

            -- stage hunk
            vim.keymap.set('n', "<leader>hs", gs.stage_hunk)
            vim.keymap.set('v', "<leader>hs", function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)
            vim.keymap.set('n', "<leader>hS", gs.stage_buffer)

            -- undo stage
            vim.keymap.set('n', "<leader>hu", gs.undo_stage_hunk)

            -- reset hunk
            vim.keymap.set('n', "<leader>hr", gs.reset_hunk)
            vim.keymap.set('v', "<leader>hr", function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)
            vim.keymap.set('n', "<leader>hR", gs.reset_buffer)

            -- line blame
            vim.keymap.set('n', "<leader>tb", gs.toggle_current_line_blame)
            vim.keymap.set('n', "<leader>hb", function() gs.blame_line({ full = true }) end)

            vim.keymap.set('n', '<leader>hp', gs.preview_hunk)

            -- diff
            vim.keymap.set('n', '<leader>hd', gs.diffthis)
            vim.keymap.set('n', '<leader>hD', function() gs.diffthis("~") end)

            -- text object
            vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<cr>")
        end,
    })
