local status, neorg = pcall(require, 'neorg')
if not status then return end

neorg.setup {
    load = {
        ["core.defaults"] = {},
        ["core.keybinds"] = {
            config = {
                neorg_leader = "<leader>o",
            }
        },
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    work = "~/notes/work",
                    home = "~/notes/home",
                }
            }
        },
        ["core.gtd.base"] = {
            config = {
                workspace = "work",
            }
        },
        ["core.norg.concealer"] = {},
    }
}
