local overseer = require("overseer")

overseer.setup({
    task_list = {
        bindings = {
            ["<c-l>"] = false,
            ["K"] = "IncreaseDetail",
        },
    },
})

local get_last_task = function()
    local tasks = overseer.list_tasks({ recent_first = true })
    if vim.tbl_isempty(tasks) then
        return nil
    end
    return tasks[1]
end

vim.api.nvim_create_user_command("OverseerRestartLast", function()
    local task = get_last_task()
    if task == nil then
        vim.notify("No tasks found", vim.log.levels.WARN)
    else
        overseer.run_action(task, "restart")
    end
end, {})

vim.api.nvim_create_user_command("OverseerOpenVSplitLast", function()
    local task = get_last_task()
    if task == nil then
        vim.notify("No tasks found", vim.log.levels.WARN)
    else
        overseer.run_action(task, "open vsplit")
    end
end, {})
