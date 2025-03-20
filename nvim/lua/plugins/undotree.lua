local function toggle()
    if vim.bo.filetype == "undotree" then
        vim.cmd.UndotreeToggle()
        return
    end

    vim.cmd.UndotreeShow()
    vim.cmd.UndotreeFocus()
end

return {
    "mbbill/undotree",
    keys = {
        { "<leader>uu", toggle,              desc = "Undotree Toggle" },
        { "<leader>uo", ":UndotreeShow<cr>", desc = "Undotree Open" },
    },
}
