local avante = require("avante")

avante.setup({
    provider = "codex",
    acp_providers = {
        codex = {
            command = "npx",
            args = { "-y", "@agentclientprotocol/codex-acp" },
        },
    },
    selector = {
        provider = "telescope",
    },
    input = {
        provider = "snacks",
    },
    providers = {
        "copilot",
    },
})

vim.keymap.set({ "v" }, "<leader>av", ":AvanteAsk<cr>", { desc = "Ask Avante about selected code" })
