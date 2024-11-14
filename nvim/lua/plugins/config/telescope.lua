local telescope = require("telescope")
local actions = require("telescope.actions")
local actions_layout = require("telescope.actions.layout")
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")
local git = require("utils.git")

local function builtin_with_theme(theme)
    local b = {}
    setmetatable(b, {
        __index = function(_, k)
            return function(...)
                return builtin[k](theme(...))
            end
        end,
    })
    b.__index = b
    return b
end
local builtin_ivy = builtin_with_theme(themes.get_ivy)

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<c-j>"] = actions.move_selection_next,
                ["<c-k>"] = actions.move_selection_previous,
                ["<c-u>"] = false,
                ["<c-i>"] = actions.toggle_selection,
                ["<c-g>"] = actions.send_to_qflist,
                ["<c-f>"] = actions.send_selected_to_qflist,
                ["<c-h>"] = actions_layout.toggle_preview,
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
        },
        path_display = {
            truncate = 3,
        },
        -- preview = {
        --     hide_on_startup = true,
        -- }
    },
})

telescope.load_extension("fzf")

-------------------------------------------------------------------------------
-- Mappings
-------------------------------------------------------------------------------
local t = require("telescope.builtin")
local n = require("keymaps").normal
local v = require("keymaps").visual

local function super_rg(opts)
    local opts = opts or {}
    opts.attach_mappings = function(_, map)
        map({ "i", "n" }, "<c-t>", function(prompt_bufnr)
            local ft = vim.fn.input("Filetype: ")
            local action_state = require("telescope.actions.state")
            local picker = action_state.get_current_picker(prompt_bufnr)
            local current_input = picker:_get_prompt()
            actions.close(prompt_bufnr)

            super_rg({
                type_filter = ft,
                default_text = current_input,
            })
        end)
        -- use default mappings as well
        return true
    end

    builtin.live_grep(opts)
end

n({
    ["<leader>f"] = function()
        builtin.fd({ follow = true })
    end,
    ["<leader>p"] = function()
        if git.is_inside_git_worktree() then
            builtin_ivy.git_files({ use_git_root = true })
        else
            builtin_ivy.fd()
        end
    end,
    ["<leader>o"] = function()
        builtin_ivy.buffers({
            sort_mru = true,
            ignore_current_buffer = false,
            attach_mappings = function(_, map)
                map({ "i", "n" }, "<c-x>", actions.delete_buffer)
                return true
            end,
        })
    end,
    ["<leader><c-f>"] = builtin.current_buffer_fuzzy_find,
    ["<leader><c-r>"] = builtin_ivy.command_history,
    ["<leader>rg"] = builtin.grep_string,
    ["<leader>rl"] = super_rg,
    ["<leader>sc"] = function()
        return builtin.lsp_references({
            show_line = false,
        })
    end,
    ["<leader>/"] = builtin.current_buffer_fuzzy_find,
    ["<leader>sd"] = builtin.lsp_definitions,
    ["<leader>ss"] = builtin_ivy.lsp_dynamic_workspace_symbols,
    ["<leader>s."] = builtin_ivy.lsp_document_symbols,
    ["<leader>vh"] = builtin.help_tags,
    ["<leader>gb"] = builtin.git_branches,
    ["<leader>va"] = builtin.autocommands,
    ["<leader>co"] = builtin.colorscheme,
    ["z="] = function()
        builtin.spell_suggest(themes.get_cursor())
    end,
})

v({
    ["<leader>rg"] = builtin.grep_string,
})

-------------------------------------------------------------------------------
-- Commands
-------------------------------------------------------------------------------

-- :Rg Search for a string in the current directory using rg.
vim.api.nvim_create_user_command("Rg", function(args)
    local opts = {
        additional_args = {},
        search = ""
    }

    for index, value in ipairs(args["fargs"]) do
        -- if starts with "-" then it's a flag
        if string.sub(value, 1, 1) == "-" then
            table.insert(opts.additional_args, value)
            table.insert(opts.additional_args, args["fargs"][index + 1])
        else
            opts.search = value
        end
    end

    builtin.grep_string(opts)
end, { nargs = '+' })

-- :Rd Live grep in given directories
vim.api.nvim_create_user_command("Rd", function(args)
    builtin.live_grep({ search_dirs = args["fargs"] })
end, { nargs = 1 })

-- :Rt Live grep files of specified type
vim.api.nvim_create_user_command("Rt", function(args)
    builtin.live_grep({ type_filter = args["args"] })
end, { nargs = 1 })

-- :Fd search files
vim.api.nvim_create_user_command("Fd", function(args)
    builtin.fd({ search_dirs = args["fargs"] })
end, { nargs = "*" })
