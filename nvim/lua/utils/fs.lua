-- use pattern to find file
local function fd(pattern)
    local fd_command = string.format('fd -1 -H -a -p -g "%s"', pattern)
    return vim.trim(vim.fn.system(fd_command))
end

return {
    fd = fd,
}
