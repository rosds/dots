local neorg = require("neorg")

neorg.setup({
    load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
            config = {
                workspaces = {
                    notes = "~/org",
                },
                default_workspace = "notes",
            },
        },
        ["core.keybinds"] = {},
    },
})

-- local neorg_ag = vim.api.nvim_create_augroup("neorg_keybindings", { clear = true })
vim.api.nvim_create_autocmd("Filetype", {
    pattern = "norg",
    -- group = neorg_ag,
    callback = function()
        vim.keymap.set("n", "<c-y>", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", { buffer = true })
        vim.keymap.set("i", "<C-Enter>", "<Plug>(neorg.itero.next-iteration)", { buffer = true })
        vim.keymap.set("n", "<C-Enter>", function()
            vim.cmd.startinsert()
            local f = vim.api.nvim_replace_termcodes("<Plug>(neorg.itero.next-iteration)", true, false, true)
            vim.api.nvim_feedkeys(f, "i", true)
        end, { buffer = true })
    end,
})
