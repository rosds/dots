return {
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
    },
    {
        "nvim-neorg/neorg",
        dependencies = { "luarocks.nvim" },
        lazy = false,
        version = "*", -- Pin Neorg to the latest stable release
        opts = {
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {},
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/org",
                        },
                        default_workspace = "notes",
                    },
                },
                ["core.keybinds"] = {
                    config = {
                        hook = function(keybinds)
                            keybinds.remap(
                                "norg",
                                "n",
                                "<c-y>",
                                "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_cycle<CR>"
                            )
                            keybinds.remap(
                                "norg",
                                { "n", "i" },
                                "<C-Enter>",
                                "<cmd>Neorg keybind norg core.itero.next-iteration<CR>"
                            )
                            keybinds.remap(
                                "norg",
                                { "n", "i" },
                                "<leader><enter>",
                                "<cmd>Neorg keybind norg core.itero.next-iteration<CR>"
                            )
                        end,
                    },
                },
            },
        },
    },
}
