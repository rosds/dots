local n = require 'keymaps'.normal

local saga = require 'lspsaga'
saga.init_lsp_saga()

local t = require 'telescope.builtin'
local rename = require 'lspsaga.rename'
local action = require 'lspsaga.codeaction'
local hover = require 'lspsaga.hover'
local diagnostic = require 'lspsaga.diagnostic'

local hl = vim.api.nvim_create_augroup("lsp_symbol_highlight", { clear = true })
vim.api.nvim_create_autocmd(
    {"CursorHold", "CursorHoldI"},
    { group = hl, callback = vim.lsp.buf.document_highlight, }
)
vim.api.nvim_create_autocmd(
    "CursorMoved",
    { group = hl, callback = vim.lsp.buf.clear_references, }
)

n {
    -- Go to
    ['<leader>sd'] = vim.lsp.buf.definition,            -- Definition
    ['<leader>sg'] = vim.lsp.buf.declaration,           -- Declaration
    ['<leader>si'] = vim.lsp.buf.implementation,        -- Implementation
    ['<leader>st'] = vim.lsp.buf.type_definition,       -- Type

    -- Rename
    ['<leader>sr'] = rename.rename,

    -- Formatting
    ['<leader>sf'] = vim.lsp.buf.formatting,

    -- Code action
    ['<leader>sa'] = action.code_action,

    -- References
    ['<leader>sc'] = t.lsp_references,
    ['<leader>ss'] = t.lsp_dynamic_workspace_symbols,
    ['<leader>sj'] = require 'lspsaga.provider'.lsp_finder,

    -- Doc
    K = hover.render_hover_doc,

    -- Diagnostics
    ['<leader>se'] = diagnostic.show_line_diagnostics,
    [']e'] = "<cmd>Lspsaga diagnostic_jump_next<cr>",
    ['[e'] = "<cmd>Lspsaga diagnostic_jump_prev<cr>",
}

-- Haskell LSP
require 'lspconfig'.hls.setup {}

-- Zig
require 'lspconfig'.zls.setup {}
