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
      })
    end,
  },
})

require("mason").setup({})
require("mason-lspconfig").setup({})
require("fidget").setup({})

-- lua
vim.lsp.enable('lua_ls')

-- cpp
vim.lsp.enable('clangd')

-- python
vim.env.PYENV_VERSION = vim.fn.system("pyenv version"):match("(%S+)%s+%(.-%)")
vim.lsp.enable('pyright')

-- haskell
vim.lsp.enable('hls')

local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- capabilities.offsetEncoding = "utf-8"

-- zig
lspconfig.zls.setup({ capabilities = capabilities })

-- python
lspconfig.ruff.setup({
  init_options = {
    settings = {
      lineLength = 88
    }
  }
})

-- go
if vim.fn.executable("gopls") then
  lspconfig.gopls.setup({
    capabilities = capabilities,
  })
end

-- harper
lspconfig.harper_ls.setup {
  settings = {
    ["harper-ls"] = {
      markdown = {
        IgnoreLinkTitle = true,
      },
      fileDictPath = "~/.harper/",
      userDictPath = "~/.harper/apex.txt"
    }
  },
}

-- rust
-- vscode lldb extension
-- local extension_path = '/home/alfonsoros/.vscode/extensions/vadimcn.vscode-lldb-1.6.10/'
-- local codelldb_path = extension_path .. 'adapter/codelldb'
-- local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'
--

-- lspconfig.rust_analyzer.setup({
--     capabilities = capabilities,
--     on_attach = function(client, bufnr)
--         vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
--     end,
-- })

-- require('rust-tools').setup({
--     server = {
--         settings = {
--             ["rust-analyzer"] = {
--                 checkOnSave = {
--                     allTargets = true,
--                     command = "clippy",
--                 },
--                 cargo = {
--                     allFeatures = true,
--                 },
--                 diagnostics = {
--                     -- this is pretty annoying with log macros, don't know why
--                     disabled = { "missing-unsafe" },
--                 },
--                 updates = {
--                     channel = "nightly",
--                 },
--                 procMacro = {
--                     enable = true,
--                 },
--             },
--         },
--         capabilities = capabilities,
--     },
--     -- dap = {
--     --     adapter = require('rust-tools.dap')
--     --     .get_codelldb_adapter(codelldb_path, liblldb_path)
--     -- }
-- })
