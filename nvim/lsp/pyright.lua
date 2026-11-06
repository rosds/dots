return {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "pyrightconfig.json", ".git", "WORKSPACE", "MODULE.bazel" },
    settings = {
        pyright = {
            disableOrganizeImports = true,
        },
    },
}
