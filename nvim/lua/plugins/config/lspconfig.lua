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
        ["]e"] = vim.diagnostic.goto_next,
        ["[e"] = vim.diagnostic.goto_prev,
      })
    end,
  },
})

require("mason").setup({})
require("mason-lspconfig").setup({})
require("fidget").setup({})

local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- capabilities.offsetEncoding = "utf-8"

-- haskell
lspconfig.hls.setup({ capabilities = capabilities })

-- zig
lspconfig.zls.setup({ capabilities = capabilities })

-- python
lspconfig.ruff.setup({})

vim.env.PYENV_VERSION = vim.fn.system("pyenv version"):match("(%S+)%s+%(.-%)")
lspconfig.pyright.setup({
  capabilities = capabilities,
  settings = {
    pyright = {
      -- ruff does this
      disableOrganizeImports = true,
    },
  },
})

-- cpp
lspconfig.clangd.setup({
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=never",
    "--fallback-style=Google",
    "--inlay-hints=true",
  },
  capabilities = vim.tbl_extend("force", capabilities, { offsetEncoding = "utf-8" }),
})

-- lua
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

-- go
if vim.fn.executable("gopls") then
  lspconfig.gopls.setup({
    capabilities = capabilities,
  })
end

-- jinja lsp
lspconfig.jinja_lsp.setup {
  capabilities = capabilities
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
