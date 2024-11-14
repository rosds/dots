vim.treesitter.language.register("python", { "bzl" })

vim.keymap.set(
    'n', '<leader>sd', vim.fn.GoToBazelDefinition, { noremap = true, silent = true, buffer = true }
)
