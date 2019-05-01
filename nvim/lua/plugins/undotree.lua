local function show_and_focus_undotree()
    vim.cmd.UndotreeShow()
    vim.cmd.UndotreeFocus()
end

return {
    "mbbill/undotree",
    keys = {
        { "<leader>uu", show_and_focus_undotree, desc = "UndotreeToggle" },
    },
}
