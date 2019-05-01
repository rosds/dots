local function open_orgmode()
    vim.cmd([[
        e ~/org/index.org
        lcd %:p:h
    ]])
end

return {
    {
        "nvim-orgmode/orgmode",
        ft = "org",
        config = function()
            local orgmode = require("orgmode")

            -- use treesitter for syntax highlighting
            orgmode.setup_ts_grammar()

            -- Treesitter configuration
            require("nvim-treesitter.configs").setup({
                -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { "org" }, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
                },
                ensure_installed = { "org" }, -- Or run :TSUpdate org
            })

            orgmode.setup({
                mappings = {
                    global = {
                        org_agenda = "<leader>wo",
                        org_capture = "<leader>wc",
                    },
                },
                org_agenda_files = { "~/org/**/*.org" },
                org_default_notes_file = "~/org/refile.org",
                org_hide_emphasis_markers = true,
                org_indent_mode = "noindent",
            })

            -- :Org command
            vim.api.nvim_create_user_command("Org", open_orgmode, {})
        end,
        cmd = "Org",
        keys = {
            { "<leader>ww", open_orgmode, desc = "Orgmode" },
        },
    },
}
