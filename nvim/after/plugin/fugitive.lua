local n = require 'keymaps'.normal
local v = require 'keymaps'.visual
local ag = require 'augroup'.augroup

local fixup_and_rebase_current_file = function()
    local current_buffer = vim.fn.expand('%:p')
    local last_commit = vim.fn.trim(vim.fn.system('git log -1 --format=%H --invert-grep --grep="^fixup! " ' .. current_buffer))
    local fixup_command = 'git commit --fixup=' .. last_commit
    local rebase_command = 'git -c sequence.editor=true rebase --interactive --autosquash ' .. last_commit .. '^'
    vim.cmd.Dispatch(fixup_command .. ' && ' .. rebase_command)
end

vim.api.nvim_create_user_command('FixupBuffer', fixup_and_rebase_current_file, {})

n {
    ['<leader>gg'] = ':G<cr>',
    ['<leader>glo'] = ':0Gclog --max-count=20<cr>',
    ['<leader>gll'] = ':Gclog --max-count=20<cr>',
    ['<leader>gl'] = ':diffget //3<cr>',
    ['<leader>gh'] = ':diffget //2<cr>',
    ['<leader>gF'] = fixup_and_rebase_current_file,
}

v {
    ['<leader>gb'] = ':GBrowse<cr>'
}

ag 'my_fugitive' {
    {
        { 'BufEnter', 'BufWinEnter' },
        pattern = 'fugitive://*',
        callback = function()
            n {
                go = { ":Gedit<cr>", buffer = true },
                gpf = { ":G push --force-with-lease<cr>", buffer = true },
            }
        end,
    }
}
