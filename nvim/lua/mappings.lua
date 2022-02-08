function make_mapper(mode)
    return function(lhs, rhs, opts)
        local options = {noremap = true, silent = true}
        if opts then options = vim.tbl_extend('force', options, opts) end
        vim.api.nvim_set_keymap(mode, lhs, rhs, options)
    end
end


-- returns a tuple with the rhs and options
local function mapspec(t)
    if type(t) == 'string' or type(t) == 'function' then return t, {} end

    assert(type(t) == 'table')
    local target = t[1]
    table.remove(t, 1)

    -- By default noremap and silent are true
    local options = {noremap = true, silent = true}
    options = vim.tbl_extend('force', options, t)

    return target, options
end

local function apply_map(mode, lhs, spec)
    local rhs, opts = mapspec(spec)
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Specify keymaps
--
-- This function is meant to be used in
function Keymaps(maps)
    assert(type(maps) == 'table', 'Keymaps expects a table of mappings')
    for key, value in pairs(maps) do
        if type(key) == 'string' then
            -- If the key is a string, then take the pair as a normal mode mapping
            apply_map('n', key, value)
        else
            -- The second possibility is to specify a map with the keys:
            --  * mode: the mode to be used by the provided mappings
            --  * maps: a list of key value maps to be set in the given mode
            assert(value['mode'] ~= nil and value['maps'] ~= nil)

            local prefix = value['leader'] and '<leader>' or ''

            for k, v in pairs(value['maps']) do
                apply_map(value['mode'], prefix .. k, v)
            end
        end
    end
end

map = make_mapper('')
nmap = make_mapper('n')
imap = make_mapper('i')
omap = make_mapper('o')
smap = make_mapper('s')
tmap = make_mapper('t')
vmap = make_mapper('v')
