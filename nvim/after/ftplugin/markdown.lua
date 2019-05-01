vim.api.nvim_set_option_value("colorcolumn", "80", { scope = "local", win = 0 })

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true

vim.g.mkdp_preview_options = {
    uml = { server = "http://localhost:8080" },
}
