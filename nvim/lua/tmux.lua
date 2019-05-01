local function is_tmux()
    local tmux = vim.fn.getenv("TMUX")
    return tmux ~= nil and tmux ~= ""
end

local function current_pane()
    return vim.fn.getenv("TMUX_PANE")
end

local function split(opts)
    opts = opts or {}

    local split_type = opts.split_horizontal and "-h" or "-v"
    local target_pane = opts.target_pane or current_pane()
    local width_percentage = opts.width_percentage or 30
    local shell_command = opts.shell_command or ""

    local flags = { "tmux", "split-window", split_type, "-t", target_pane, "-p", width_percentage }
    if opts.shell_command then
        table.insert(flags, shell_command)
    end

    vim.fn.system(flags)
end

local function split_horizontal(opts)
    if not is_tmux() then
        return
    end
    opts = vim.tbl_extend("force", opts or {}, { split_horizontal = true })
    split(opts)
end

local function run_on_horizontal_split(cmd)
    if type(cmd) ~= "string" then
        error("cmd must be a string")
    end

    if not is_tmux() then
        return
    end

    if cmd == "" then
        split_horizontal()
    else
        split_horizontal({ shell_command = cmd .. " | less" })
    end
end

return {
    split_horizontal = split_horizontal,
    run = run_on_horizontal_split,
}
