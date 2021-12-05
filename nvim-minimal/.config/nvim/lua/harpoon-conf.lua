require("harpoon").setup({
	global_settings = {
		save_on_toggle = false,
		save_on_change = true,
		enter_on_sendcmd = false,
		tmux_autoclose_windows = false,
		excluded_filetypes = { "harpoon" },
	},
})

local map = vim.api.nvim_set_keymap
local options = { noremap = true }

map("n", "<leader>ma", ":lua require('harpoon.mark').add_file()<CR>", options)
map("n", "<leader>mm", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", options)

-- mark maps
map("n", "<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>", options)
map("n", "<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>", options)
map("n", "<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>", options)
map("n", "<leader>4", ":lua require('harpoon.ui').nav_file(4)<CR>", options)
