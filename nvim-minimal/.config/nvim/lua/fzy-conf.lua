fzy = require("fzy")

fzy.setup()
local map = vim.api.nvim_set_keymap
local options = { noremap = true, silent = true }

map("n", "<C-b>", ":lua fzy.actions.buffers()<CR>", options)
map("n", "<leader>ft", ":lua fzy.try(fzy.actions.lsp_tags, fzy.actions.buf_tags)<CR>", options)
map("n", "<leader>fg", ":lua fzy.execute('git ls-files', fzy.sinks.edit_file)<CR>", options)
map("n", "<leader>fq", ":lua fzy.actions.quickfix()<CR>", options)
map("n", "<leader>f/", ":lua fzy.actions.buf_lines()<CR>", options)

map("n", "<c-p>", [[:lua fzy.execute('fd -L -t f -H -E ".git" .', fzy.sinks.edit_file)<cr>]], options)
map(
	"n",
	"<m-p>",
	[[:lua fzy.execute('fd -L -t f -H -E ".git" . <C-R>=expand("%:.:h")<CR>/', fzy.sinks.edit_file)<cr>]],
	options
)
map("n", "<leader>fc", [[:lua fzy.execute('fd -L -t f -H -E ".git" . ~/.config/', fzy.sinks.edit_file)<cr>]], options)
map(
	"n",
	"<leader>fs",
	[[:lua fzy.execute('fd -L -t f -H -E ".git" . ~/.local/bin/', fzy.sinks.edit_file)<cr>]],
	options
)

-- files by type
map("n", "<leader>fp", ":lua fzy.execute('fd -H -e py', fzy.sinks.edit_file)<CR>", options)
map("n", "<leader>fj", ":lua fzy.execute('fd -H -e js', fzy.sinks.edit_file)<CR>", options)
map("n", "<leader>fr", ":lua fzy.execute('fd -H -e rs', fzy.sinks.edit_file)<CR>", options)
map("n", "<leader>fv", ":lua fzy.execute('fd -H -e vue', fzy.sinks.edit_file)<CR>", options)
