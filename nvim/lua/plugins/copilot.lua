local whitelisted_projects = {
    "/home/alfonso.ros/ade-home/vsomeip",
}

local in_whitelist = function(path)
    for _, project in ipairs(whitelisted_projects) do
        local result = vim.fn.findfile(path, project)
        if result ~= "" and result:sub(1, 1) ~= "/" then
            return true
        end
    end
    return false
end

return {
    {
        "github/copilot.vim",
        enabled = true,
        init = function()
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_assume_mapped = true
            vim.g.copilot_tab_fallback = ""
            -- vim.g.copilot_filetypes = {
            --     ["*"] = false,
            --     python = true,
            --     cpp = true,
            --     lua = true,
            --     rust = true,
            -- }
        end,
        config = function()
            local group = vim.api.nvim_create_augroup("copilot_enable_cond", { clear = true })
            vim.api.nvim_create_autocmd({ "BufRead" }, {
                pattern = "*",
                group = group,
                callback = function(ev)
                    if ev.file == nil then
                        return
                    end

                    if in_whitelist(ev.file) then
                        vim.b.copilot_enabled = true
                    end
                end,
            })
        end,
    },
}
