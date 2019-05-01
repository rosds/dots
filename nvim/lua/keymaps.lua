-- Return the mapping options table
-- By default `noremap` and `silent `are set to true
local function getopts(o)
    local options = { noremap = true, silent = true }
    return vim.tbl_extend("force", options, o or {})
end

-- Returns the rhs and opts out of the map value
--
-- The values for the key-value map list can be either:
--
--  * string
--  * function
--  * table
--
--  In the case of the table, it must have a value without key, that is either a
--  string or a function. The rest of the entries are taken as options.
--
local function mapspec(t)
    if type(t) == "string" or type(t) == "function" then
        return t, getopts({})
    end

    assert(t[1] ~= nil, "Mapping has to include either a string or a function")
    local rhs = table.remove(t, 1)

    return rhs, getopts(t)
end

local function make_mode_mapper(mode)
    return function(ls)
        assert(type(ls) == "table", "Expects a mappings pairs")
        for lhs, value in pairs(ls) do
            assert(type(lhs) == "string", "Error on mapping without key")
            local rhs, opts = mapspec(value)
            vim.keymap.set(mode, lhs, rhs, opts)
        end
    end
end

return {
    map = make_mode_mapper(""),
    insert = make_mode_mapper("i"),
    normal = make_mode_mapper("n"),
    visual = make_mode_mapper("v"),
    operator = make_mode_mapper("o"),
    terminal = make_mode_mapper("t"),
    mode = make_mode_mapper,
}
