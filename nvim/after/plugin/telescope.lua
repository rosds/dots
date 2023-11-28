local status, telescope = pcall(require, "telescope")
if not status then
    return
end

local actions = require("telescope.actions")
local actions_layout = require("telescope.actions.layout")
local themes = require("telescope.themes")
local git = require("utils.git")

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
            -- shorten = 2,
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

    t.live_grep(opts)
end

n({
    ["<leader>f"] = function()
        t.fd({ follow = true })
    end,
    ["<leader>p"] = function()
        if git.is_inside_git_worktree() then
            t.git_files(themes.get_ivy({ use_git_root = true }))
        else
            t.fd(themes.get_ivy())
        end
    end,
    ["<leader>o"] = function()
        t.buffers(themes.get_ivy({ sort_mru = true, ignore_current_buffer = true }))
    end,
    ["<leader><c-f>"] = t.current_buffer_fuzzy_find,
    ["<leader><c-r>"] = function()
        t.command_history(themes.get_ivy())
    end,
    ["<leader>rg"] = t.grep_string,
    ["<leader>rl"] = super_rg,
    ["<leader>sc"] = function()
        return t.lsp_references({
            show_line = false,
        })
    end,
    ["<leader>ss"] = t.lsp_dynamic_workspace_symbols,
    ["<leader>s."] = t.lsp_document_symbols,
    ["<leader>vh"] = t.help_tags,
    ["<leader>gb"] = t.git_branches,
    ["<leader>va"] = t.autocommands,
    ["<leader>co"] = t.colorscheme,
    ["z="] = function()
        t.spell_suggest(themes.get_cursor())
    end,
})

v({
    ["<leader>rg"] = [[y:lua require("telescope.builtin").grep_string({ search = '<c-r>"' })<cr>]],
})

-------------------------------------------------------------------------------
-- Commands
-------------------------------------------------------------------------------

-- :Rg Search for a string in the current directory using rg.
vim.api.nvim_create_user_command("Rg", function(args)
    t.grep_string({
        search = args["args"],
    })
end, { nargs = 1 })

-- :Rd Live grep in given directories
vim.api.nvim_create_user_command("Rd", function(args)
    t.live_grep({ search_dirs = args["fargs"] })
end, { nargs = 1 })

-- :Rt Live grep files of specified type
vim.api.nvim_create_user_command("Rt", function(args)
    t.live_grep({ type_filter = args["args"] })
end, { nargs = 1 })

-- :Fd search files
vim.api.nvim_create_user_command("Fd", function(args)
    t.fd({ search_dirs = args["fargs"] })
end, { nargs = "*" })
