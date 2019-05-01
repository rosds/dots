;; set keymap in normal mode
(fn nmap [key function ...]
  (vim.keymap.set :n key function ...))

{: nmap}
