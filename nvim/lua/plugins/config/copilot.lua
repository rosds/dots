local copilot = require("copilot")

copilot.setup({
    suggestion = {
        auto_trigger = true,
        keymap = {
            accept = "<c-f>"
        }
    }
})
