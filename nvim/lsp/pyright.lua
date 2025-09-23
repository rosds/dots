return {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "pyrightconfig.json", ".git", "WORKSPACE" },
    settings = {
        pyright = {
            disableOrganizeImports = true,
        }
    }
}
