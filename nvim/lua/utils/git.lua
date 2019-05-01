local fs = require("utils.fs")

local function path_or_default(path)
    return path or fs.buffer_path() or vim.fn.getcwd()
end

---Returns the root of the git repository containing the given path.
---@param path string|nil a path to a file or directory.
---@return string|nil path The absolut path to the root of the git repository.
local function file_git_root(path)
    local path = path_or_default(path)
    local git_cmd = "git -C " .. fs.file_dir(path)
    local cmd = git_cmd .. " rev-parse --show-toplevel"
    P(cmd)
    local output = vim.fn.system(git_cmd .. " rev-parse --show-toplevel")
    if vim.v.shell_error ~= 0 then
        return nil
    end
    return vim.fn.trim(output)
end

---@param path string|nil a path to a file or directory otherwise the current buffer path.
---@return boolean result True if the given path is inside a git worktree.
local function is_inside_git_worktree(path)
    local git_root = file_git_root(path)
    if git_root == nil then
        return false
    end
    local git_cmd = "git -C " .. git_root
    local result = vim.fn.system(git_cmd .. " rev-parse --is-inside-work-tree")
    return result == 0
end

---Returns the last non-fixup commit hash of the given file or directory.
---@param path string|nil a path to a file or directory otherwise the current buffer path.
---@return string|nil commit The last commit hash of the given file or directory.
local function file_last_commit(path)
    local path = path_or_default(path)
    local git_root = file_git_root(path)
    P(git_root)
    if git_root == nil then
        return nil
    end
    local git_cmd = "git -C " .. git_root
    local output = vim.fn.system(git_cmd .. ' log -1 --format=%H --invert-grep --grep="^fixup! " ' .. path)
    P(output)
    if vim.v.shell_error ~= 0 then
        return nil
    end
    return vim.fn.trim(output)
end

return {
    file_git_root = file_git_root,
    is_inside_git_worktree = is_inside_git_worktree,
    file_last_commit = file_last_commit,
}
