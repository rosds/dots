--- Check if the current buffer corresponds to a symbolic link
--- @return boolean: true if it is a symbolic link, false otherwise
local function is_symlink(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    if not vim.api.nvim_buf_is_valid(bufnr) then
        return false
    end

    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname == "" then
        return false -- No file name, so it cannot be a symlink
    end

    local lstat = vim.uv.fs_lstat(bufname)
    return lstat and lstat.type == "link" or false
end

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
    if not is_symlink() then
        return
    end

    local current_win = vim.api.nvim_get_current_win()
    local cursor = vim.api.nvim_win_get_cursor(current_win)

    local bufold = vim.api.nvim_get_current_buf()
    local path = vim.fn.resolve(vim.api.nvim_buf_get_name(bufold))

    vim.cmd.edit(vim.fn.fnameescape(path))
    vim.api.nvim_win_set_cursor(current_win, cursor)
    vim.api.nvim_buf_set_name(bufold, path)
end

--- Search for files using `fd` and return the results as a list.
--- @param glob_pattern string: glob pattern to match (e.g. "*.h" or "*.cpp")
--- @param search_dir string|nil: directory to search from (optional). If nil, uses current buffer's directory.
--- @return table: list of matched file paths
local function find_files_with_fd(glob_pattern, search_dir)
    local dir = search_dir or vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p:h")
    dir = vim.fn.resolve(dir) -- resolve symlinks etc.
    if not dir:match("/$") then
        dir = dir .. "/" -- ensure trailing slash
    end

    local escaped_pattern = vim.fn.shellescape(glob_pattern)
    local escaped_dir = vim.fn.shellescape(dir)
    local cmd = "fd --glob " .. escaped_pattern .. " " .. escaped_dir .. " --absolute-path"

    local handle = io.popen(cmd)
    if not handle then
        vim.notify("Failed to run fd", vim.log.levels.ERROR)
        return
    end
    local output = handle:read("*a")
    handle:close()

    local results = {}
    for line in output:gmatch("[^\r\n]+") do
        -- Strip the search dir prefix from the absolute path
        if line:sub(1, #dir) == dir then
            local rel = line:sub(#dir + 1)
            table.insert(results, rel)
        else
            table.insert(results, line) -- fallback: add raw line
        end
    end

    if #results == 0 then
        vim.notify("No matches found", vim.log.levels.INFO)
    else
        vim.api.nvim_put(results, "l", true, true) -- insert lines below cursor
        vim.notify("Relative paths inserted below cursor", vim.log.levels.INFO)
    end
end

return {
    find_file = fd,
    find_files = find_files_with_fd,
    file_dir = file_dir,
    is_symlink = is_symlink,
    follow_symlink = follow_symlink,
    buffer_path = buffer_path,
    find_upwards = find_upwards,
    is_under_directory = is_under_directory,
}
