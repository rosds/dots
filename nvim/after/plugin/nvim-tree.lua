local status, tree = pcall(require, 'nvim-tree')
if not status then
    return
end

local function to_dir(path)
    if vim.fn.isdirectory(path) == 0 then
        return vim.fn.fnamemodify(path, ':h')
    else
        return path
    end
end

tree.setup {
    renderer = {
        highlight_opened_files = "name",
    },
    update_focused_file = {
        enable = true,
        update_root = false,
    },
    view = {
        relativenumber = true,
        mappings = {
            list = {
                { key = "<C-e>", action = "", }, -- disable edit_in_place
                { key = "<CR>", action = "edit_in_place_if_only_window", action_cb = function(...)
                    local api = require 'nvim-tree.api'
                    if vim.w.open_replacing_current_buffer ~= nil then
                        api.node.open.replace_tree_buffer(...)
                    else
                        api.node.open.edit(...)
                    end
                    vim.wo.relativenumber = true
                end },
                { key = "<C-y>", action = "edit_in_place", }, -- disable edit_in_place
                {
                    key = "<C-f>",
                    action = "live_grep_in_directory",
                    action_cb = function(node)
                        print(vim.inspect(node))
                        print(to_dir(node.absolute_path))
                        require 'telescope.builtin'.live_grep({
                            cwd = to_dir(node.absolute_path),
                        })
                    end,
                },
                {
                    key = "<C-p>",
                    action = "print_node",
                    action_cb = function(node)
                        require 'telescope.builtin'.fd({
                            cwd = to_dir(node.absolute_path),
                        })
                    end,
                },
            },
        },
    },
    git = {
        ignore = false,
    },
}

local n = require 'keymaps'.normal

n {
    ['<leader>nf'] = ':NvimTreeFindFile!<cr>',
    ['<leader>nc'] = ':NvimTreeClose<cr>',
    ['<leader>nn'] = function()
        local view = require 'nvim-tree.view'
        if view.is_visible() then
            view.close()
        end

        vim.w.open_replacing_current_buffer = true
        tree.open({
            find_file = true,
            current_window = true,
            focus = true,
        })

        vim.wo.winfixwidth = false
        vim.wo.winfixheight = false
    end,
}

local ag = require 'augroup'.augroup

-- expand nvim-tree when active
ag "NvimTreeAG" {
    {
        "BufEnter",
        pattern = "NvimTree*",
        callback = function()
            vim.cmd.NvimTreeResize("+40")
            vim.wo.relativenumber = true
        end
    },
    {
        "BufLeave",
        pattern = "NvimTree*",
        callback = function()
            vim.cmd.NvimTreeResize("-40")
            vim.wo.relativenumber = false
        end
    },
}
