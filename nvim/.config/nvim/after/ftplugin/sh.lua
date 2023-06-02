-- Keybindings
vim.keymap.set("n", "<F5>", function() require("my-functions").add_to_hist_and_run([[sh ]] .. vim.fn.bufname("%")) end)
