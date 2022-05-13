local n = require 'keymaps'.normal

n {
    ['<leader>bb'] = ':Make test --no-run --all-features<cr>',
    ['<leader>bc'] = ':Make +nightly clippy --all-features<cr>',
    ['<leader>bf'] = ':Make +nightly fmt --all<cr>',
}
