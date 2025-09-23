local avante = require("avante")

avante.setup({
    provider = "copilot",
    providers = {
        copilot = {
            model = "claude-3.7-sonnet",
        },
    },
    selector = {
        provider = "telescope",
    },
    input = {
        provider = "snacks"
    }
})

vim.keymap.set({ "n" }, "<leader>cc", ":AvanteChat<cr>", { desc = "Open Avante Chat" })
