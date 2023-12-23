local overseer = require("overseer")

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

return {
    {
        "stevearc/overseer.nvim",
        opts = {
            task_list = {
                bindings = {
                    ["<c-l>"] = false,
                    ["K"] = "IncreaseDetail",
                },
            },
        },
        keys = {
            { "<leader>tt", "<cmd>OverseerRun<cr>", desc = "" },
            { "<leader>to", "<cmd>OverseerToggle<cr>", desc = "" },
            { "<leader>tr", "<cmd>OverseerRestartLast<cr>", desc = "" },
            { "<leader>tv", "<cmd>OverseerOpenVSplitLast<cr>", desc = "" },
        },
    },
}
