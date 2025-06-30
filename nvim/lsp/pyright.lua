return {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "pyrightconfig.json", ".git" },
    settings = {
        pyright = {
            disableOrganizeImports = true,
        }
    }
}
