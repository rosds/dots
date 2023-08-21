vim.api.nvim_create_user_command("OverseerRestartLast", function()
    local overseer = require("overseer")
    local tasks = overseer.list_tasks({ recent_first = true })
    if vim.tbl_isempty(tasks) then
        vim.notify("No tasks found", vim.log.levels.WARN)
    else
        overseer.run_action(tasks[1], "restart")
    end
end, {})

vim.api.nvim_create_user_command("OverseerOpenVSplitLast", function()
    local overseer = require("overseer")
    local tasks = overseer.list_tasks({ recent_first = true })
    if vim.tbl_isempty(tasks) then
        vim.notify("No tasks found", vim.log.levels.WARN)
    else
        overseer.run_action(tasks[1], "open vsplit")
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
            { "<leader>tt", "<cmd>OverseerRun<cr>",            desc = "" },
            { "<leader>to", "<cmd>OverseerToggle<cr>",         desc = "" },
            { "<leader>tr", "<cmd>OverseerRestartLast<cr>",    desc = "" },
            { "<leader>tv", "<cmd>OverseerOpenVSplitLast<cr>", desc = "" },
        },
    },
}
