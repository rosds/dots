vim.g.firenvim_config = {
    globalSettings = {
        cmdlineTimeout = 3000,
    },
    localSettings = {
        ["https?://gitlab\\.apex\\.ai/"] = {
            takeover = "nonempty",
            priority = 1,
            content = "text",
            selector = "textarea[id=issue-description]",
        },
        [".*"] = {
            takeover = "never",
            priority = 0,
        },
    },
}

return {
    {
        "glacambre/firenvim",
        cond = not not vim.g.started_by_firenvim,
        build = ":call firenvim#install(0)",
        config = function()
            local ag = require("augroup").augroup
            ag("Firenvim")({
                {
                    "BufEnter",
                    pattern = "gitlab.apex.ai_*.txt",
                    callback = function()
                        vim.opt.filetype = "markdown"
                        vim.opt.laststatus = 0

                        -- vim.g.gruvbox_material_transparent_background = 0
                        -- vim.cmd.colorscheme("gruvbox-material")

                        local n = require("keymaps").normal
                        n({
                            ["<esc><esc>"] = function()
                                vim.fn["firenvim#hide_frame"]()
                            end,
                            ["<c-z>"] = function()
                                vim.fn["firenvim#focus_page"]()
                            end,
                        })
                    end,
                },
                -- {
                --     {"TextChanged", "TextChangedI"},
                --     pattern = "*",
                --     nested = true,
                --     command = "write",
                -- }
            })
        end,
    },
}
