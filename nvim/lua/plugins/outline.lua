return {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {
        { "<leader>so", "<cmd>Outline<cr>", desc = "Toggle Outline" },
    },
    config = function()
        require("plugins.config.outline")
    end,
}
