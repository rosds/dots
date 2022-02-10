local ls = require 'luasnip'

ls.config.set_config {
    -- can jump to last snippet
    history = true,
    -- This one is cool cause if you have dynamic snippets, it updates as you type!
    updateevents = "TextChanged,TextChangedI"
}

local snippets = {}

-- load snippets
for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/snippets/*.lua",
                                                       true)) do
    local ft = vim.fn.fnamemodify(ft_path, ":t:r")
    snippets[ft] = loadfile(ft_path)()
end

ls.snippets = snippets

Keymaps {
    ['<leader><leader>s'] = '<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>'
}
