return {
    cmd = { "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=never",
        "--fallback-style=Google",
        "--inlay-hints=true",
    },
    filetypes = { "c", "cpp" },
    root_markers = { "compile_commands.json", ".clangd" },
}
