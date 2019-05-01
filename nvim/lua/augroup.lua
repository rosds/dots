-- Usage:
--
--  local ag = require 'augroup'.augroup
--  ag "name" {
--      {"BufWritePost", pattern = "pattern", command = function()...end},
--      {"BufWritePost", pattern = "pattern", callback = function()...end, "some description"},
--      ...
--  }
--
local augroup = function(name)
    assert(type(name) == 'string', 'augroup name must be a string')
    return function(autocmds)
        assert(type(autocmds) == 'table', 'autocmd must a table with each autocmd')
        local augroup = vim.api.nvim_create_augroup(name, { clear = true })

        for _, autocmd in ipairs(autocmds) do
            assert(autocmd[1] ~= nil, 'The first element in autocmd must be the events table')
            local events = table.remove(autocmd, 1)

            autocmd['group'] = augroup
            vim.api.nvim_create_autocmd(events, autocmd)
        end
    end
end

return {
    augroup = augroup,
}
