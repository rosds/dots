local t = require("keymaps").terminal
local n = require("keymaps").normal

t({
    ["<c-h>"] = "<c-\\><c-n>:TmuxNavigateLeft<cr>",
    ["<c-j>"] = "<c-\\><c-n>:TmuxNavigateDown<cr>",
    ["<c-k>"] = "<c-\\><c-n>:TmuxNavigateUp<cr>",
    ["<c-l>"] = "<c-\\><c-n>:TmuxNavigateRight<cr>",
    ["<esc>"] = "<c-\\><c-n>",
})

local function feedkeys(keys)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", false)
end

local function term_keymaps()
    n({
        ["<cr>"] = {
            function()
                vim.cmd.startinsert()
                feedkeys("<cr>")
            end,
            buffer = true,
        },
    })
end

-- terminal
local ag = require("augroup").augroup
ag("TerminalAG")({
    {
        "TermOpen",
        pattern = "term://*",
        callback = function()
            term_keymaps()
        end,
    },
    {
        "TermLeave",
        pattern = "term://*",
        callback = function()
            vim.wo.number = true
            vim.wo.relativenumber = true
        end,
    },
    {
        "TermEnter",
        pattern = "term://*",
        callback = function()
            vim.wo.number = false
            vim.wo.relativenumber = false
        end,
    },
    -- prevent closing the terminal window after the job exits
    {
        "TermClose",
        callback = function()
            feedkeys("<c-\\><c-n>")
        end,
    },
})
