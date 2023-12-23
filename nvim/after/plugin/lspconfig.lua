local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- capabilities.offsetEncoding = "utf-8"

-- haskell
lspconfig.hls.setup({ capabilities = capabilities })

-- zig
lspconfig.zls.setup({ capabilities = capabilities })

-- python
lspconfig.pyright.setup({
    capabilities = capabilities,
    root_dir = function(...)
        local fallback = require("lspconfig.server_configurations.pyright").default_config.root_dir
        local bazel_root_dir = require("lspconfig").util.root_pattern("WORKSPACE")
        return bazel_root_dir(...) or fallback(...)
    end,
})

-- cpp
lspconfig.clangd.setup({
    cmd = { "clangd", "--background-index", "--clang-tidy" },
    capabilities = vim.tbl_extend("force", capabilities, { offsetEncoding = "utf-8" }),
})

-- lua
require("neodev").setup({})
require("lspconfig").lua_ls.setup({
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
            -- neodev
            completion = {
                callSnippet = "Replace",
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

-- rust
-- vscode lldb extension
-- local extension_path = '/home/alfonsoros/.vscode/extensions/vadimcn.vscode-lldb-1.6.10/'
-- local codelldb_path = extension_path .. 'adapter/codelldb'
-- local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'
--

if vim.fn.executable("rust-analyzer") then
    lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
    })
end

-- grammarly
lspconfig.grammarly.setup({
    init_options = {
        clientId = "client_REwND5XbXKmu1qCq6fsGms",
    },
    filetypes = { "markdown", "text" },
    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = true,
            signs = true,
            underline = true,
            update_in_insert = false,
        }),
    },
    capabilities = capabilities,
})

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
