---Returns the word under the cursor.
local function cursor_word()
    return vim.fn.escape(vim.fn.expand("<cword>"), [[\/]])
end

---Returns the lines in the current visual selection.
local function visual_lines()
    local _, start_row, start_col, _ = unpack(vim.fn.getpos("'<"))
    local _, end_row, end_col, _ = unpack(vim.fn.getpos("'>"))
    local lines = vim.fn.getline(start_row, end_row)
    lines[1] = string.sub(lines[1], start_col)
    lines[#lines] = string.sub(lines[#lines], 1, end_col)
    return lines
end

return {
    cursor_word = cursor_word,
    visual_lines = visual_lines,
}
