---Return a plenary Path of the current buffer
---@return string|nil path of the current buffer
local function buffer_path()
    local bufnr = vim.api.nvim_get_current_buf()
    local name = vim.api.nvim_buf_get_name(bufnr)
    if name == "" then
        return nil
    else
        return name
    end
end

--- Search for a file upwards using the current buffer path as the starting
--- point.
--- @return string|nil path of the current buffer
local function find_upwards(pattern)
    local path = buffer_path()
    if path == nil then
        return nil
    end

    local dir = vim.fn.fnamemodify(path, ":p:h")
    local result = vim.fn.findfile(pattern, dir .. ";")
    if result == "" then
        return nil
    else
        return result
    end
end

--- Search for a file downwards using the current buffer path as the starting
--- point.
--- @return bool If file is found in under pattern
local function is_under_directory(file, dir)
    local result = vim.fn.findfile(file, dir)
    return result == "" and result:sub(1, 1) ~= "/"
end

-- use pattern to find file
local function fd(pattern)
    local fd_command = string.format('fd -1 -H -a -p -g "%s"', pattern)
    return vim.trim(vim.fn.system(fd_command))
end

---Return the directory of the given path.
---@param path string a path to a file or directory.
---@return string path
local function file_dir(path)
    return vim.fn.fnamemodify(path, ":p:h")
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
    file_dir = file_dir,
    follow_symlink = follow_symlink,
    buffer_path = buffer_path,
    find_upwards = find_upwards,
    is_under_directory = is_under_directory,
}
