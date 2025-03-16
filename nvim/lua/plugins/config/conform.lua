local conform = require("conform")

conform.setup({
    log_level = vim.log.levels.DEBUG,
    default_format_opts = {
        lsp_format = "fallback",
    },
    format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end
        return { lsp_format = "fallback" }
    end,
    formatters_by_ft = {
        lua = { "stylua" },
        bzl = { "buildifier" },
        cpp = { "clang_format" },
        zsh = { "beautysh" },
        json = { "jq" },
        elixir = { "mix" },
        haskell = { "ormolu" },
        python = function(bufnr)
            if conform.get_formatter_info("ruff_format", bufnr).available then
                return {
                    "ruff_fix",
                    "ruff_organize_imports",
                    "ruff_format",
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
            prepend_args = { "-warnings=-out-of-order-load" },
            args = { "-path", "$FILENAME" },
        },
    },
})

vim.keymap.set({ "v", "n" }, "<leader>sf", function()
    conform.format()
end)

vim.api.nvim_create_user_command("AutoFormatDisable", function(args)
    if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
    else
        vim.g.disable_autoformat = true
    end
end, {
    desc = "Disable autoformat-on-save",
    bang = true,
})

vim.api.nvim_create_user_command("AutoFormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
end, {
    desc = "Re-enable autoformat-on-save",
})
