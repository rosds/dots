require('codecompanion').setup({
    strategies = {
        chat = {
            adapter = "copilot"
        },
        inline = {
            adapter = "copilot"
        },
        agent = {
            adapter = "copilot"
        }
    },
    adapters   = {
        openai = function()
            return require("codecompanion.adapters").extend("openai", {
                env = {
                    api_key = "cmd:op read 'op://Private/openai/api_key' --no-newline",
                },
            })
        end,
        claude = function()
            return require("codecompanion.adapters").extend("copilot", {
                schema = {
                    model = {
                        default = "claude-3.7-sonnet"
                    }
                }
            })
        end,
    },
    display    = {
        chat = {
            show_settings = true
        }
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
    "<leader>ca",
    "<cmd>CodeCompanionChat Add<cr>",
    { noremap = true, silent = true }
)

vim.cmd([[cab cc CodeCompanion]])
vim.cmd([[cab ccc CodeCompanionChat]])
