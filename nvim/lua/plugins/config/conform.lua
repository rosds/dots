local conform = require("conform")

conform.setup({
    log_level = vim.log.levels.DEBUG,
    default_format_opts = {
        lsp_format = "fallback",
    },
    format_on_save = {
        lsp_format = "fallback",
    },
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
            prepend_args = {
                "--style=file:/home/alfonso.ros/ade-home/gc/master/.clang-format",
            },
        },
        buildifier = {
            args = { "-path", "$FILENAME" },
        },
    },
})

vim.keymap.set({ "v", "n" }, "<leader>sf", function()
    conform.format()
end)
