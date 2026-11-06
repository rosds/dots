local n = require("keymaps").normal

local ag = require("augroup").augroup
ag("LspAttach")({
    {
        "LspAttach",
        desc = "LSP actions",
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client:supports_method("textDocument/foldingRange") then
                local win = vim.api.nvim_get_current_win()
                vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
            end

            n({
                -- replaced with the telescope one
                -- ["<leader>sd"] = vim.lsp.buf.definition,
                ["<leader>sD"] = vim.lsp.buf.declaration,
                ["<leader>si"] = vim.lsp.buf.implementation,
                ["<leader>st"] = vim.lsp.buf.type_definition,
                ["<leader>sh"] = function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                end,
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
            }, { buffer = args.buf })
        end,
    },
})

-- Server settings live in lsp/<name>.lua; this module owns attachment behavior.
vim.lsp.enable({ "clangd", "lua_ls", "pyright", "hls", "zls", "harper_ls" })
