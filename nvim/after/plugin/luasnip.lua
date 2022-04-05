local n = require 'keymaps'.normal
local ls = require 'luasnip'
local types = require 'luasnip.util.types'

ls.config.set_config {
    -- can jump to last snippet
    history = true,
    -- This one is cool cause if you have dynamic snippets, it updates as you type!
    updateevents = "TextChanged,TextChangedI",

    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = {{"<- choice!", "GruvboxYellowBold"}}
            }
        }
    }
}

ls.cleanup()

-- load snippets
local snippet_files = vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true)
for _, ft_path in ipairs(snippet_files) do
    local ft = vim.fn.fnamemodify(ft_path, ":t:r")
    ls.add_snippets(ft, loadfile(ft_path)())
end

n {
    ['<leader><leader>s'] = '<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>'
}
