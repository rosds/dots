local n = require 'keymaps'.normal

local t = require 'telescope.builtin'

-- local hl = vim.api.nvim_create_augroup("lsp_symbol_highlight", { clear = true })
-- vim.api.nvim_create_autocmd(
--     {"CursorHold", "CursorHoldI"},
--     { group = hl, callback = vim.lsp.buf.document_highlight, }
-- )
-- vim.api.nvim_create_autocmd(
--     "CursorMoved",
--     { group = hl, callback = vim.lsp.buf.clear_references, }
-- )

n {
    -- Go to
    ['<leader>sd'] = vim.lsp.buf.definition,
    ['<leader>sg'] = vim.lsp.buf.declaration,
    ['<leader>si'] = vim.lsp.buf.implementation,
    ['<leader>st'] = vim.lsp.buf.type_definition,

    -- Rename
    ['<leader>sr'] = vim.lsp.buf.rename,

    -- Formatting
    ['<leader>sf'] = vim.lsp.buf.formatting,

    -- Code action
    ['<leader>sa'] = vim.lsp.buf.code_action,

    -- References
    ['<leader>sc'] = t.lsp_references,
    ['<leader>ss'] = t.lsp_dynamic_workspace_symbols,

    -- Doc
    K = vim.lsp.buf.hover,

    -- Diagnostics
    ['<leader>se'] = vim.diagnostic.open_float,
    [']e'] = vim.diagnostic.goto_next,
    ['[e'] = vim.diagnostic.goto_prev,
}

-- Haskell LSP
require 'lspconfig'.hls.setup {}

-- Zig
require 'lspconfig'.zls.setup {}
