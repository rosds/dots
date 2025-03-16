require('codecompanion').setup({
    strategies = {
        chat = {
            adapter = "copilot"
        },
        inline = {
            adapter = "copilot"
        }
    },
    adapters   = {
        openai = function()
            require('codecompanion.adapters').extend('openai', {
                env = {
                    api_key = "cmd:op read 'op://Private/openai/api_key' --no-newline"
                }
            })
        end
    }
})

vim.keymap.set(
    { "n" },
    "<leader>cc",
    "<cmd>CodeCompanionChat Toggle<cr>",
    { noremap = true, silent = true }
)
vim.keymap.set(
    { "n" },
    "<leader>ca",
    "<cmd>CodeCompanionAction<cr>",
    { noremap = true, silent = true }
)
vim.keymap.set(
    { "v" },
    "<leader>cc",
    "<cmd>CodeCompanionChat Add<cr>",
    { noremap = true, silent = true }
)

vim.cmd([[cab cc CodeCompanion]])
