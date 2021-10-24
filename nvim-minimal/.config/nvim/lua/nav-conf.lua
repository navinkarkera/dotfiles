-- Configuration
require('Navigator').setup()

-- Keybindings
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', "<m-h>", "<CMD>lua require('Navigator').left()<CR>", opts)
map('n', "<m-k>", "<CMD>lua require('Navigator').up()<CR>", opts)
map('n', "<m-l>", "<CMD>lua require('Navigator').right()<CR>", opts)
map('n', "<m-j>", "<CMD>lua require('Navigator').down()<CR>", opts)
map('n', "<m-^>", "<CMD>lua require('Navigator').previous()<CR>", opts)
