local lint = require("lint")

local pydocstyle = lint.linters.pydocstyle
pydocstyle.args = { "--convention=google" }

lint.linters_by_ft = {
    python = { "ruff", "pydocstyle" },
}

local group = vim.api.nvim_create_augroup("nvim_lint_augroup", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    group = group,
    callback = function()
        require("lint").try_lint()
    end,
})
