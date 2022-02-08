-- set breakpoints
nmap('<leader>db', '<cmd>lua require"dap".toggle_breakpoint()<cr>')
nmap('<leader>di', '<cmd>lua require"dap".step_into()<cr>')
nmap('<leader>do', '<cmd>lua require"dap".step_out()<cr>')
nmap('<leader>dj', '<cmd>lua require"dap".step_over()<cr>')
nmap('<leader>dc', '<cmd>lua require"dap".continue()<cr>')


nmap('<leader>dp', '<cmd>lua require"dap.ui.widgets".hover()<cr>')

local widgets = require('dap.ui.widgets')
local my_sidebar = widgets.sidebar(widgets.scopes)
_G.dap_sidebar = my_sidebar

nmap('<leader>dn', '<cmd>lua dap_sidebar.open()<cr>')
