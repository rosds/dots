return {
    {
        "L3MON4D3/LuaSnip",
        tag = "v2.3.0",
        build = "make install_jsregexp",
        config = function()
            local ls = require("luasnip")
            local types = require("luasnip.util.types")

            ls.config.set_config({
                -- can jump to last snippet
                history = false,
                -- This one is cool cause if you have dynamic snippets, it updates as you type!
                updateevents = "TextChanged,TextChangedI",
                ext_opts = {
                    [types.choiceNode] = {
                        active = {
                            virt_text = { { "", "GruvboxYellowBold" } },
                        },
                    },
                },
            })

            -- ls.cleanup()
            --
            -- -- load snippets
            -- local snippet_files = vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true)
            -- for _, ft_path in ipairs(snippet_files) do
            --     local ft = vim.fn.fnamemodify(ft_path, ":t:r")
            --     ls.add_snippets(ft, loadfile(ft_path)())
            -- end

            require("luasnip.loaders.from_lua").load({ paths = "./lua/snippets" })

            local n = require("keymaps").normal
            n({
                -- ["<leader><leader>s"] = function()
                --     ls.cleanup()
                --     vim.cmd.source("~/.config/nvim/after/plugin/luasnip.lua")
                -- end,
                ["<leader><leader>s"] = function()
                    require("luasnip.loaders").edit_snippet_files({})
                end,
            })
        end,
    },
    { "saadparwaiz1/cmp_luasnip", dependencies = "L3MON4D3/LuaSnip" },
}
