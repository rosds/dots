-------------------------------------------------------------------------------
-- LSP Mappings
-------------------------------------------------------------------------------
local n = require("keymaps").normal
local mode = require("keymaps").mode

local ag = require("augroup").augroup
ag("LspAttach")({
    {
        "LspAttach",
        desc = "LSP actions",
        callback = function()
            n({
                ["<leader>sd"] = vim.lsp.buf.definition,
                ["<leader>sD"] = vim.lsp.buf.declaration,
                ["<leader>si"] = vim.lsp.buf.implementation,
                ["<leader>st"] = vim.lsp.buf.type_definition,
                ["<c-w>]"] = function()
                    vim.cmd.vsplit()
                    vim.lsp.buf.definition()
                end,
                -- Rename
                ["<leader>sr"] = vim.lsp.buf.rename,
                -- Code action
                ["<leader>sa"] = vim.lsp.buf.code_action,
                -- Doc
                K = vim.lsp.buf.hover,
                -- Diagnostics
                ["<leader>se"] = vim.diagnostic.open_float,
                ["]e"] = vim.diagnostic.goto_next,
                ["[e"] = vim.diagnostic.goto_prev,
            })

            -- Formatting
            mode({ "v", "n" })({
                ["<leader>sf"] = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end,
    },
})

local function lsp_config()
    require("mason").setup({})
    require("mason-lspconfig").setup({})
    require("fidget").setup({})
end

return {
    "j-hui/fidget.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    { "neovim/nvim-lspconfig", config = lsp_config },
}
