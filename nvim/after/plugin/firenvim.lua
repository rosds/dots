if not vim.g.started_by_firenvim then
    return
end

vim.opt.laststatus = 0

local n = require 'keymaps'.normal
n {
    ["<esc><esc>"] = function() vim.fn["firenvim#hide_frame"]() end,
}


local ag = require "augroup".augroup
ag "AllFile" {
    {
        "BufEnter",
        pattern = "gitlab.apex.ai_*.txt",
        callback = function() vim.opt.filetype = "markdown" end,
    },
    -- {
    --     {"TextChanged", "TextChangedI"},
    --     pattern = "*",
    --     nested = true,
    --     command = "write",
    -- }
}
