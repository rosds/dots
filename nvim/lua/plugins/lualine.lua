local function fugitive_buffer()
    return "[Fugitive]"
end

local function is_fugitive_buffer()
    local buf_name = vim.api.nvim_buf_get_name(0)
    return vim.startswith(buf_name, "fugitive://")
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
        options = {
            section_separators = "",
            component_separators = "",
        },
        sections = {
            lualine_a = {
                {
                    fugitive_buffer,
                    cond = is_fugitive_buffer,
                    color = { fg = "White", bg = "Red" },
                },
                {
                    "filename",
                    path = 1,
                    symbols = { modified = "●", readonly = "" },
                },
            },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = {},
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {
                {
                    "filename",
                    path = 1,
                },
            },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },
    },
}
