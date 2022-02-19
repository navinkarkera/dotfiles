local telescope = require("telescope")
telescope.load_extension("fzf")
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")

local previewers = require("telescope.previewers")

local new_maker = function(filepath, bufnr, opts)
	opts = opts or {}

	filepath = vim.fn.expand(filepath)
	vim.loop.fs_stat(filepath, function(_, stat)
		if not stat then
			return
		end
		if stat.size > 100000 then
			return
		else
			previewers.buffer_previewer_maker(filepath, bufnr, opts)
		end
	end)
end

telescope.setup({
	defaults = {
		buffer_previewer_maker = new_maker,
		layout_strategy = "horizontal",
		layout_config = {
			width = 0.95,
			preview_width = 0.65,
		},
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<M-p>"] = action_layout.toggle_preview,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
			n = {
				["<M-p>"] = action_layout.toggle_preview,
			},
		},
	},
	pickers = {
		find_files = {
			find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "-H", "-L" },
		},
	},
})

local map = vim.api.nvim_set_keymap
local options = { noremap = true, silent = true }

map("n", "<C-b>", ":lua require('telescope.builtin').buffers()<CR>", options)
map("n", "<leader>ft", ":lua require('telescope.builtin').lsp_document_symbols()<CR>", options)
map("n", "<leader>fg", ":lua require('telescope.builtin').git_files()<CR>", options)
map("n", "<leader>fq", ":lua require('telescope.builtin').quickfix()<CR>", options)
map("n", "<leader>f/", ":lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", options)
map("n", "<leader>pS", ":lua require('telescope.builtin').live_grep()<CR>", options)

map("n", "<c-p>", [[:lua require('telescope.builtin').find_files()<cr>]], options)
map(
	"n",
	"<leader>fc",
	[[:lua require('telescope.builtin').find_files({ prompt_prefix="Config> ", cwd="~/.config" })<cr>]],
	options
)
map(
	"n",
	"<leader>fs",
	[[:lua require('telescope.builtin').find_files({ prompt_prefix="Scripts> ", cwd="~/.local/bin" })<cr>]],
	options
)

-- files by type
-- map("n", "<leader>fp", ":lua fzy.execute('fd -H -e py', fzy.sinks.edit_file)<CR>", options)
-- map("n", "<leader>fj", ":lua fzy.execute('fd -H -e js', fzy.sinks.edit_file)<CR>", options)
-- map("n", "<leader>fr", ":lua fzy.execute('fd -H -e rs', fzy.sinks.edit_file)<CR>", options)
-- map("n", "<leader>fv", ":lua fzy.execute('fd -H -e vue', fzy.sinks.edit_file)<CR>", options)
