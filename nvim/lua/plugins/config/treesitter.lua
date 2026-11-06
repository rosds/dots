local ensureInstalled = {
    "c",
    "cpp",
    "fennel",
    "haskell",
    "json",
    "lua",
    "markdown",
    "python",
    "rust",
    "xml",
    "yaml",
}

local alreadyInstalled = require("nvim-treesitter.config").get_installed()
local parsersToInstall = vim.iter(ensureInstalled)
    :filter(function(parser)
        return not vim.tbl_contains(alreadyInstalled, parser)
    end)
    :totable()

require("nvim-treesitter").install(parsersToInstall)

vim.keymap.set({ "x", "o" }, "af", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "aa", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ia", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
end)

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "cpp", "python", "rust", "lua", "bzl", "haskell", "xml" },
    callback = function(event)
        if vim.bo[event.buf].filetype == "xml" then
            vim.treesitter.get_parser(event.buf):parse()
        end

        vim.treesitter.start(event.buf)

        -- folds, provided by Neovim
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldmethod = "expr"

        vim.schedule(function()
            for _, win in ipairs(vim.fn.win_findbuf(event.buf)) do
                vim.api.nvim_win_call(win, function()
                    vim.cmd("normal! zx")
                end)
            end
        end)
    end,
})
