local obsidian = require("obsidian")

obsidian.setup({
    workspaces = {
        {
            name = "notes",
            path = "~/vaults/notes",
        },
    },
    notes_subdir = "notes",
    follow_url_func = function(url)
        vim.fn.jobstart({ "xdg-open", url })
    end,
    ui = { enable = false },
})

local function take_note()
    vim.ui.input({
        prompt = "Note title: ",
        default = "",
    }, function(input)
        if input then
            vim.cmd("ObsidianNew " .. input)
        else
            print("No input provided.")
        end
    end)
end

vim.keymap.set("n", "<leader>nn", take_note, { desc = "Obsidian: Take a new note" })
vim.keymap.set("n", "<leader>ns", ":ObsidianSearch<cr>", { desc = "Obsidian: Search notes" })

return {
    take_note = take_note,
}
