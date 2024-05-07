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
        callback = function(args)
            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)

            --- toggle inlay hints
            vim.g.inlay_hints_visible = false
            local function toggle_inlay_hints()
                if vim.g.inlay_hints_visible then
                    vim.g.inlay_hints_visible = false
                    vim.lsp.inlay_hint.enable(bufnr, false)
                else
                    if client.server_capabilities.inlayHintProvider then
                        vim.g.inlay_hints_visible = true
                        vim.lsp.inlay_hint.enable(bufnr, true)
                    else
                        print("no inlay hints available")
                    end
                end
            end

            n({
                -- replaced with the telescope one
                -- ["<leader>sd"] = vim.lsp.buf.definition,
                ["<leader>sD"] = vim.lsp.buf.declaration,
                ["<leader>si"] = vim.lsp.buf.implementation,
                ["<leader>st"] = vim.lsp.buf.type_definition,
                ["<leader>sh"] = toggle_inlay_hints,
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
