local ts = require("telescope.builtin")
local oil = require("oil")

local function to_dir(path)
    if vim.fn.isdirectory(path) == 0 then
        return vim.fn.fnamemodify(path, ":h")
    else
        return path
    end
end

local function live_grep()
    local entry = oil.get_cursor_entry()
    assert(entry)
    local current_dir = oil.get_current_dir()
    local entry_path = current_dir .. entry.name

    ts.live_grep({ cwd = to_dir(entry_path) })
end

local function find_files()
    ts.find_files({ cwd = oil.get_current_dir() })
end

require("oil").setup({
    keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-r>"] = "actions.refresh",
        ["<C-c>"] = false,
        ["gq"] = "actions.close",
        ["gt"] = "actions.open_terminal",
        ["<C-f>"] = { callback = live_grep, desc = "find string" },
        ["<C-p>"] = { callback = find_files, desc = "find file" },
        ["<leader>yf"] = "actions.yank_entry",
    },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
