local status, telescope = pcall(require, "telescope")
if not status then return end

local actions = require 'telescope.actions'
local actions_layout = require('telescope.actions.layout')

telescope.setup {
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
            }
        },

        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = 'smart_case'
            }
        },

        path_display = {
            truncate = 3,
        },

        preview = {
            hide_on_startup = true,
        }
    },
}

telescope.load_extension('fzf')

-------------------------------------------------------------------------------
-- Mappings
-------------------------------------------------------------------------------
local t = require('telescope.builtin')
local n = require 'keymaps'.normal
local v = require 'keymaps'.visual

local function super_rg()
    t.live_grep{
        attach_mappings = function(_, map)
            map({"i", "n"}, "<c-t>", function(prompt_bufnr)
                local ft = vim.fn.input("Filetype: ")
                local picker = require'telescope.actions.state'.get_current_picker(prompt_bufnr)
                local current_input = picker:_get_prompt()
                actions.close(prompt_bufnr)
                picker = t.live_grep({
                    type_filter = ft,
                })
                picker:set_prompt(current_input)
            end)
            -- use default mappings as well
            return true
        end
    }
end

n {
    ['<leader>p'] = function() t.fd({ follow = true }) end,
    ['<leader>f'] = t.git_files,
    ['<leader>o'] = t.buffers,
    ['<leader><c-r>'] = t.command_history,
    ['<leader>rg'] = t.grep_string,
    ['<leader>ri'] = function() t.grep_string({ search = vim.fn.input('Rg> ') }) end,
    ['<leader><c-f>'] = super_rg,
    ['<leader>vh'] = t.help_tags,
    ['<leader>gb'] = t.git_branches,
    ['<leader>va'] = t.autocommands,
}

v {
    ['<leader>rg'] = [[y:lua require("telescope.builtin").grep_string({ search = '<c-r>"' })<cr>]],
}


-------------------------------------------------------------------------------
-- Commands
-------------------------------------------------------------------------------

-- :Rg Search for a string in the current directory using rg.
vim.api.nvim_create_user_command(
    "Rg",
    function(args)
        t.grep_string({
            search = args["args"]
        })
    end,
    { nargs = 1 }
)

-- :Rd Live grep in given directories
vim.api.nvim_create_user_command(
    "Rd",
    function(args)
        t.live_grep({ search_dirs = args["fargs"] })
    end,
    { nargs = 1 }
)

-- :Rt Live grep files of specified type
vim.api.nvim_create_user_command(
    "Rt",
    function(args)
        t.live_grep({ type_filter = args["args"] })
    end,
    { nargs = 1 }
)
