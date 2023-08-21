-- use pattern to find file
local Path = require("plenary.path")

local function fd(pattern)
    local fd_command = string.format('fd -1 -H -a -p -g "%s"', pattern)
    return vim.trim(vim.fn.system(fd_command))
end

--- Return a plenary Path of the current buffer
---@return Path path of the current buffer
local function buffer_path()
    local bufnr = vim.api.nvim_get_current_buf()
    return Path:new(vim.api.nvim_buf_get_name(bufnr))
end

local function follow_symlink()
    local current_win = vim.api.nvim_get_current_win()
    local cursor = vim.api.nvim_win_get_cursor(current_win)

    local bufold = vim.api.nvim_get_current_buf()
    local path = vim.fn.resolve(vim.api.nvim_buf_get_name(bufold))

    local bufnew = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_set_current_buf(bufnew)
    vim.api.nvim_buf_delete(bufold, { force = true })

    vim.api.nvim_buf_call(bufnew, function()
        vim.cmd("edit! " .. path)
    end)
    vim.api.nvim_win_set_cursor(current_win, cursor)
end

return {
    fd = fd,
    follow_symlink = follow_symlink,
    buffer_path = buffer_path,
}
