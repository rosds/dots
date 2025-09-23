vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '👉', texthl = '', linehl = '', numhl = '' })

local dap = require("dap")

local keymap_restore = {}

dap.listeners.after['event_initialized']['me'] = function()
    for _, buf in pairs(vim.api.nvim_list_bufs()) do
        local keymaps = vim.api.nvim_buf_get_keymap(buf, 'n')
        for _, keymap in pairs(keymaps) do
            if keymap.lhs == "K" then
                table.insert(keymap_restore, keymap)
                vim.api.nvim_buf_del_keymap(buf, 'n', 'K')
            end
        end
    end
    vim.api.nvim_set_keymap(
        'n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
end

dap.listeners.after['event_terminated']['me'] = function()
    for _, keymap in pairs(keymap_restore) do
        if keymap.rhs then
            vim.api.nvim_buf_set_keymap(
                keymap.buffer,
                keymap.mode,
                keymap.lhs,
                keymap.rhs,
                { silent = keymap.silent == 1 }
            )
        elseif keymap.callback then
            vim.keymap.set(
                keymap.mode,
                keymap.lhs,
                keymap.callback,
                { buffer = keymap.buffer, silent = keymap.silent == 1 }
            )
        end
    end
    keymap_restore = {}
end

dap.adapters.gdb = {
    type = "executable",
    command = "/usr/local/bin/gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
}

dap.configurations.c = {
    {
        name = "bazel inproc test",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        stopAtBeginningOfMainSubprogram = false,
        cwd = "${workspaceFolder}",
        env = {
            IDA_RESOURCE_ACQUISITION_STRATEGY = "use_inproc"
        }
    },
    {
        name = "inproc custom path",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        stopAtBeginningOfMainSubprogram = false,
        cwd = "${workspaceFolder}",
        env = {
            IDA_RESOURCE_ACQUISITION_STRATEGY = "use_inproc"
        }
    },
}

dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c

--- Select an item using Telescope.
--- @param title string title of the picker.
--- @param items string[] list of items to choose from.
--- @param display fun(item): string function to format the display of each item.
--- @param opts table options for the picker.
--- @param on_choice fun(selected) callback function to call with the selected item.
local function telescope_select(title, items, display, opts, on_choice)
    local pickers      = require("telescope.pickers")
    local finders      = require("telescope.finders")
    local conf         = require("telescope.config").values
    local actions      = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    pickers.new(opts, {
        prompt_title = title,
        finder = finders.new_table {
            results = items,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = display(entry),
                    ordinal = display(entry),
                }
            end,
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                on_choice(selection)
            end)
            return true
        end,
    }):find()
end

local function continue()
    if dap.session() then
        dap.continue()
        return
    end

    local configs = dap.configurations[vim.bo.filetype] or {}
    if #configs == 0 then
        vim.notify("No DAP configurations found for " .. vim.bo.filetype, vim.log.levels.WARN)
        return
    end

    local themes = require("telescope.themes")
    telescope_select("Select DAP Configuration", configs, function(conf) return conf.name end, themes.get_dropdown({}),
        function(selected)
            if not selected or not selected.value then
                vim.notify("No configuration selected", vim.log.levels.WARN)
                return
            end

            local config = selected.value
            if config.name == "bazel inproc test" then
                local bazel = require("bazel.utils")
                local bazel_telescope = require("bazel.telescope")

                local current_file_path = bazel.file_path()
                local query = 'kind(".*_test", rdeps(//..., ' .. current_file_path .. '))'

                bazel_telescope.select_label(query, themes.get_dropdown({}), function(selected_label)
                    if not selected_label or not selected_label.value then
                        vim.notify("No bazel test selected", vim.log.levels.WARN)
                        return
                    end

                    config.program = bazel.bazel_bin_path(selected_label.value)
                    dap.run(config)
                end)
                return
            end

            dap.run(config)
        end)
end

return {
    continue = continue
}
