if not vim.g.started_by_firenvim then
    return
end

local ag = require "augroup".augroup
ag "Firenvim" {
    {
        "BufEnter",
        pattern = "gitlab.apex.ai_*.txt",
        callback = function()
            vim.opt.filetype = "markdown"
            vim.opt.laststatus = 0

            local n = require 'keymaps'.normal
            n {
                ["<esc><esc>"] = function() vim.fn["firenvim#hide_frame"]() end,
                ["<c-z>"] = function() vim.fn["firenvim#focus_page"]() end,
            }
        end,
    },
    -- {
    --     {"TextChanged", "TextChangedI"},
    --     pattern = "*",
    --     nested = true,
    --     command = "write",
    -- }
}
