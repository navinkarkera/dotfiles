-- Keybindings
vim.keymap.set("n", "<F5>", require("my-functions").add_to_hist_and_run([[bash ]] .. vim.fn.bufname("%")))
