return {
    cmd = { "clangd",
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
}
