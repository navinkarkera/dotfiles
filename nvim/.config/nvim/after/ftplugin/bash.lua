-- Keybindings
vim.keymap.set("n", "<F5>", [[:call VimuxRunCommand("bash " . bufname("%"), 1)<CR>]])
