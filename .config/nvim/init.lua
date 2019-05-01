require 'globals'
require 'settings'
require 'plugins'
require 'mappings'

Keymaps {
    -- find and replace
    ['<leader>rr'] = {'yiw:%s/<c-r>"//g<left><left>', silent = false},

    -- edit nvim config
    ['<leader>vc'] = function()
        vim.cmd [[
                vsplit $MYVIMRC
                lcd %:p:h
                setlocal path=.,**,,
              ]]
    end,

    -- quickfix list
    [']q'] = ':cnext<cr>',
    ['[q'] = ':cprev<cr>',
    [']Q'] = ':cfirst<cr>',
    ['[Q'] = ':clast<cr>',

    -- open file with the system's default
    ['<leader>go'] = ':silent execute "!xdg-open " . shellescape("<cWORD>")<cr>',

    -- visual mode
    {
        mode = 'v',
        maps = {
            ['<leader>rr'] = {'y:%s/<c-r>"//g<left><left>', silent = false},
            ['<leader>go'] = 'y:silent execute "!xdg-open <c-r>""<cr>',
        }
    }
}

