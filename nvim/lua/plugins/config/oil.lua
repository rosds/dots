local function to_dir(path)
    if vim.fn.isdirectory(path) == 0 then
        return vim.fn.fnamemodify(path, ":h")
    else
        return path
    end
end

local function live_grep_bellow_entry()
    local ts = require("telescope.builtin")
    local oil = require("oil")

    local entry = oil.get_cursor_entry()
    local current_dir = oil.get_current_dir()
    local entry_path = current_dir .. entry.name

    ts.live_grep({ cwd = to_dir(entry_path) })
end

require("oil").setup({
    keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-r>"] = "actions.refresh",
        ["<C-c>"] = false,
        ["gq"] = "actions.close",
        ["gt"] = "actions.open_terminal",
        ["<C-f>"] = live_grep_bellow_entry,
    },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
