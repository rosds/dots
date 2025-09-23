local n = require("keymaps").normal

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

-- c/c++
vim.lsp.config("clangd", {
    cmd = {
        "clangd",
        "--background-index=false",
        "-j=1",
        "--pch-storage=disk",
        "--clang-tidy",
        "--header-insertion=never",
        "--fallback-style=Google",
        "--inlay-hints=true",
    },
    filetypes = { "c", "cpp" },
    root_markers = { "compile_commands.json", ".clangd" },
})
vim.lsp.enable("clangd")

-- lua
vim.lsp.enable("lua_ls")

-- python
vim.env.PYENV_VERSION = vim.fn.system("pyenv version"):match("(%S+)%s+%(.-%)")
vim.lsp.enable("pyright")

-- haskell
vim.lsp.enable("hls")

-- zig
vim.lsp.enable("zls")

-- Harper
vim.lsp.config("harper_ls", {
    settings = {
        ["harper-ls"] = {
            userDictPath = "",
            fileDictPath = "",
            linters = {
                SpellCheck = true,
                SpelledNumbers = false,
                AnA = true,
                SentenceCapitalization = true,
                UnclosedQuotes = true,
                WrongQuotes = false,
                LongSentences = true,
                RepeatedWords = true,
                Spaces = true,
                Matcher = true,
                CorrectNumberSuffix = true,
            },
            codeActions = {
                ForceStable = false,
            },
            markdown = {
                IgnoreLinkTitle = false,
            },
            diagnosticSeverity = "hint",
            isolateEnglish = false,
            dialect = "American",
            maxFileLength = 120000,
        },
    },
})
vim.lsp.enable("harper_ls")
