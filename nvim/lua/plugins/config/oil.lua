local ts = require("telescope.builtin")
local oil = require("oil")

require("oil").setup({
    keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-r>"] = "actions.refresh",
        ["<C-c>"] = false,
        ["gq"] = "actions.close",
        ["gt"] = "actions.open_terminal",
        ["<C-f>"] = { callback = function() ts.live_grep({ cwd = oil.get_current_dir() }) end, desc = "find string" },
        ["<C-p>"] = { callback = function() ts.find_files({ cwd = oil.get_current_dir() }) end, desc = "find file" },
        ["<leader>yf"] = "actions.yank_entry",
    },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
