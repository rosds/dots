local avante = require("avante")

avante.setup({
    provider = "copilot",
    -- provider = "codex",
    selector = {
        provider = "telescope",
    },
    input = {
        provider = "snacks",
    },
})

vim.keymap.set({ "n" }, "<leader>cc", ":AvanteToggle<cr>", { desc = "Open Avante Chat" })
