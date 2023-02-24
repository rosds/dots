local function file_last_commit()
    local current_buffer = vim.fn.expand("%:p")
    local output = vim.fn.system('git log -1 --format=%H --invert-grep --grep="^fixup! " ' .. current_buffer)
    if vim.v.shell_error ~= 0 then
        return nil
    end
    return vim.fn.trim(output)
end

return {
    file_last_commit = file_last_commit,
}
