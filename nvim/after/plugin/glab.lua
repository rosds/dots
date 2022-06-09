local list_issues = function()
    local issues = vim.fn.systemlist("PAGER=cat glab issue -R gitlab.apex.ai/ApexAI/grand_central list --mine")
    -- remove the annoying header
    table.remove(issues, 1)
    table.remove(issues, 1)
    table.remove(issues, 1)
    return issues
end

local view_issue = function(issue)
    local cmd = string.format("PAGER=cat glab issue -R gitlab.apex.ai/ApexAI/grand_central view %s", issue)
    return vim.fn.systemlist(cmd)
end

local n = require 'keymaps'.normal

n {
    ['<leader>gi'] = function()
        local issues = list_issues()

        local pickers = require('telescope.pickers')
        local finders = require('telescope.finders')
        local actions = require('telescope.actions')
        local action_state = require('telescope.actions.state')

        pickers.new({}, {
            prompt_title = 'GitLab Issues',
            finder = finders.new_table {
                results = issues
            },
            attach_mappings = function(prompt_bufnr)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    local _, _, issue  = selection[1]:find('^#(%d+)')
                    vim.api.nvim_put(view_issue(issue), "", false, true)
                end)
                return true
            end,
        }):find()
    end,
}

