return {
    "epwalsh/obsidian.nvim",
    lazy = true,
    event = { "BufReadPre " .. vim.fn.expand("~") .. "/my-vault/**.md" },
    opts = {
        dir = "~/my-vault", -- no need to call 'vim.fn.expand' here
    },
    config = function(_, opts)
        require("obsidian").setup(opts)
        vim.keymap.set("n", "gf", function()
            if require("obsidian").util.cursor_on_markdown_link() then
                return "<cmd>ObsidianFollowLink<CR>"
            else
                return "gf"
            end
        end, { noremap = false, expr = true })
    end,
}
