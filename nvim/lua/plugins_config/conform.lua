local conform = require("conform")

conform.setup({
    log_level = vim.log.levels.DEBUG,
    formatters_by_ft = {
        lua = { "stylua" },
        bzl = { "buildifier" },
        cpp = { "clang_format" },
        python = function(bufnr)
            if conform.get_formatter_info("ruff_format", bufnr).available then
                return {
                    "ruff_fix",
                    "ruff_format",
                    "ruff_organize_imports",
                    "black",
                }
            else
                return { "isort", "black" }
            end
        end,
        toml = { "taplo" },
    },
    formatters = {
        clang_format = {
            args = { "--assume-filename", "$FILENAME", "--fallback-style=LLVM" },
        },
        buildifier = {
            args = { "-path", "$FILENAME" },
        },
    },
})

local group = vim.api.nvim_create_augroup("conform_augroup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    group = group,
    callback = function(args)
        conform.format({ bufnr = args.buf })
    end,
})

vim.keymap.set({ "v", "n" }, "<leader>sf", function()
    conform.format()
end, { silent = true })
