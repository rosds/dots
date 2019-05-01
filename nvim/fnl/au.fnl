(fn bufname [] (vim.fn.bufname))
(fn path-to-name [path] (vim.fn.substitute path "[/.]" "_" "g"))

(fn dot [f g] (fn [...] (f (g ...))))
(fn group-name [] ((dot path-to-name bufname)))

(fn create_autocmd [events autocmd] (vim.api.nvim_create_autocmd events autocmd))

{:bufname bufname}
