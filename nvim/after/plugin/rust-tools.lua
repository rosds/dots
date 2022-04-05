-- vscode lldb extension
local extension_path = '/home/alfonsoros/.vscode/extensions/vadimcn.vscode-lldb-1.6.10/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'


local opts = {
    server = {
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    allTargets = true,
                    command = "clippy",
                },
                cargo = {
                    allFeatures = true,
                },
                diagnostics = {
                    -- this is pretty annoying with log macros, don't know why
                    disabled = { "missing-unsafe" },
                },
                updates = {
                    channel = "nightly",
                },
                procMacro = {
                    enable = true,
                },
            },
        }
    },
    dap = {
        adapter = require('rust-tools.dap')
        .get_codelldb_adapter(codelldb_path, liblldb_path)
    }

}

require('rust-tools').setup(opts)
