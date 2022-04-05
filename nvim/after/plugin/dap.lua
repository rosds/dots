local n = require 'keymaps'.normal

local dap = require 'dap'
local widgets = require('dap.ui.widgets')

n {
    ['<leader>db'] = dap.toggle_breakpoint,
    ['<leader>di'] = dap.step_into,
    ['<leader>do'] = dap.step_out,
    ['<leader>dj'] = dap.step_over,
    ['<leader>dc'] = dap.continue,

    ['<leader>dp'] = widgets.hover,

    ['<leader>dn'] = widgets.sidebar(widgets.scopes).open,
}
