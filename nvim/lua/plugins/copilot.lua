return {
    "github/copilot.vim",
    enabled = true,
    init = function()
        vim.g.copilot_no_tab_map = true
        vim.g.copilot_assume_mapped = true
        vim.g.copilot_tab_fallback = ""
        -- vim.g.copilot_filetypes = {
        --     ["*"] = false,
        --     python = true,
        --     cpp = true,
        --     lua = true,
        --     rust = true,
        -- }
    end,
}
