local t = require 'keymaps'.terminal
local n = require 'keymaps'.normal

t {
    ['<c-h>'] = '<c-\\><c-n>:TmuxNavigateLeft<cr>',
    ['<c-j>'] = '<c-\\><c-n>:TmuxNavigateDown<cr>',
    ['<c-k>'] = '<c-\\><c-n>:TmuxNavigateUp<cr>',
    ['<c-l>'] = '<c-\\><c-n>:TmuxNavigateRight<cr>',
    ['<esc>'] = '<c-\\><c-n>',
}

local function term_keymaps()
    n {
        ['<cr>'] = {
            function()
                vim.cmd.startinsert()
                vim.api.nvim_feedkeys(
                    vim.api.nvim_replace_termcodes('<cr>', true, false, true),
                    'n', false
                )
            end,
            buffer = true
        }
    }
end

-- terminal
local ag = require 'augroup'.augroup
ag "Terminator" {
    { 'TermOpen',
        callback = function()
            vim.cmd.startinsert()
            term_keymaps()
        end,
    },
    { { 'BufWinEnter', 'WinEnter' },
        pattern = 'term://*',
        command = 'startinsert',
    },
    { 'TermLeave',
        command = 'setlocal number relativenumber',
    },
    { 'TermEnter',
        command = 'setlocal nonumber norelativenumber',
    },
}
