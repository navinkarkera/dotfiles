-- Keybindings
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("n", "<F5>", [[:call VimuxRunCommand("bash " . bufname("%"), 1)<CR>]], opts)
