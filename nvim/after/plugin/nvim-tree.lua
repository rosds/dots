local status, tree = pcall(require, "nvim-tree")
if not status then
    return
end

local api = require("nvim-tree.api")
local view = require("nvim-tree.view")

local function to_dir(path)
    if vim.fn.isdirectory(path) == 0 then
        return vim.fn.fnamemodify(path, ":h")
    else
        return path
    end
end

--- A noop function in case plugins are not available
local function noop(...)
end

local custom_actions = {}
setmetatable(custom_actions, {
    __index = function()
        return noop
    end,
})

--------------------------------------------------------------------------------
-- telescope actions
local has_telescope, ts = pcall(require, "telescope.builtin")

local function open_tree_node()
    if not not vim.w.open_replacing_current_buffer then
        api.node.open.replace_tree_buffer()
    else
        api.node.open.edit()
    end
end

local function close_tree()
    if not not vim.w.open_replacing_current_buffer then
        vim.cmd.edit("#")
    else
        api.tree.close()
    end
end

if has_telescope then
    local function open_file_from_nvim_tree(path, line)
        api.tree.find_file({ buf = path })
        open_tree_node()

        if line then
            vim.api.nvim_win_set_cursor(0, { line, 0 })
        end
    end

    local function live_grep_entry_to_path(entry)
        return entry.cwd .. "/" .. entry.filename, entry.lnum
    end

    local function find_file_entry_to_path(entry)
        return entry.cwd .. "/" .. entry[1]
    end

    local function open_telescope_entry_with_nvim_tree(prompt_bufnr, entry_to_path_cb)
        return function()
            local selected = require("telescope.actions.state").get_selected_entry()
            require("telescope.actions").close(prompt_bufnr)
            open_file_from_nvim_tree(entry_to_path_cb(selected))
        end
    end

    function custom_actions.live_grep_bellow_node()
        local node = api.tree.get_node_under_cursor()
        ts.live_grep({
            cwd = to_dir(node.absolute_path),
            attach_mappings = function(prompt_bufnr, map)
                map({ "i", "n" }, "<cr>", open_telescope_entry_with_nvim_tree(prompt_bufnr, live_grep_entry_to_path))
                return true
            end,
        })
    end

    function custom_actions.find_file_bellow_node()
        local node = api.tree.get_node_under_cursor()
        ts.fd({
            cwd = to_dir(node.absolute_path),
            attach_mappings = function(prompt_bufnr, map)
                map({ "i", "n" }, "<cr>", open_telescope_entry_with_nvim_tree(prompt_bufnr, find_file_entry_to_path))
                return true
            end,
        })
    end
end

function custom_actions.open_term_in_file_dir()
    local node = api.tree.get_node_under_cursor()
    local working_dir = to_dir(node.absolute_path)
    view.abandon_current_window()

    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_win_set_buf(win, buf)
    vim.fn.termopen("zsh", { cwd = working_dir })
end

--------------------------------------------------------------------------------

local n = require("keymaps").normal

tree.setup({
    renderer = {
        highlight_opened_files = "name",
        indent_markers = {
            enable = true,
        },
    },
    prefer_startup_root = true,
    update_focused_file = {
        enable = true,
        update_root = true,
    },
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
    on_attach = function(bufnr)
        local function with_help(f, help)
            return { f, desc = "nvim-tree: " .. help, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        n({
            q = with_help(close_tree, "Close"),
            a = with_help(api.fs.create, "Create"),
            r = with_help(api.fs.rename, "Rename"),
            x = with_help(api.fs.cut, "Cut"),
            p = with_help(api.fs.paste, "Paste"),
            d = with_help(api.fs.remove, "Remove"),
            R = with_help(api.tree.reload, "Refresh"),
            h = with_help(api.node.navigate.parent, "Parent Directory"),
            H = with_help(api.tree.change_root_to_parent, "Up"),
            ["-"] = with_help(api.tree.change_root_to_parent, "Up"),
            J = with_help(api.node.navigate.sibling.next, "Next Sibling"),
            K = with_help(api.node.navigate.sibling.prev, "Previous Sibling"),
            ["<cr>"] = with_help(open_tree_node, "edit in place if only window"),
            ["<bs>"] = with_help(api.node.navigate.parent_close, "Close Directory"),
            ["<c-v>"] = with_help(api.node.open.vertical, "Vertical Split"),
            ["<c-x>"] = with_help(api.node.open.horizontal, "Vertical Split"),
            ["<c-f>"] = with_help(custom_actions.live_grep_bellow_node, "live grep bellow node"),
            ["<c-p>"] = with_help(custom_actions.find_file_bellow_node, "find file bellow node"),
            ["<c-t>"] = with_help(custom_actions.open_term_in_file_dir, "open term this dir"),
        })
    end,
    view = {
        relativenumber = true,
    },
    git = {
        ignore = false,
    },
})

local vinegar = function()
    if api.tree.is_visible() then
        api.tree.close()
    end
    api.tree.open({ current_window = true, find_file = true, update_root = true })

    vim.w.open_replacing_current_buffer = true
    vim.wo.winfixwidth = false
    vim.wo.winfixheight = false
end

n({
    ["<leader>nf"] = ":NvimTreeFindFile<cr>",
    ["<leader>nq"] = ":NvimTreeClose<cr>",
    ["<leader>nn"] = vinegar,
    ["<leader>."] = vinegar,
    ["<leader><c-v>"] = function()
        vim.cmd.vsplit()
        vinegar()
    end,
    ["<leader><c-s>"] = function()
        vim.cmd.split()
        vinegar()
    end,
})

local ag = require("augroup").augroup

-- expand nvim-tree when active
ag("NvimTreeAG")({
    {
        "BufEnter",
        pattern = "NvimTree*",
        callback = function()
            vim.cmd.NvimTreeResize("+40")
        end,
    },
    {
        "BufLeave",
        pattern = "NvimTree*",
        callback = function()
            vim.cmd.NvimTreeResize("-40")
        end,
    },
})
