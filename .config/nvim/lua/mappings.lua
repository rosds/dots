function make_mapper(mode)
    return function(lhs, rhs, opts)
        local options = {noremap = true, silent = true}
        if opts then options = vim.tbl_extend('force', options, opts) end
        vim.api.nvim_set_keymap(mode, lhs, rhs, options)
    end
end

map = make_mapper('')
nmap = make_mapper('n')
imap = make_mapper('i')
omap = make_mapper('o')
