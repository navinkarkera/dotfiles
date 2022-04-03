local null_ls = require("null-ls")

local on_attach = function(client, bufnr)
	-- Mappings.
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<m-a>", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

null_ls.setup({
	on_attach = on_attach,
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier.with({
			filetypes = { "html", "json", "yaml", "markdown" },
		}),
		null_ls.builtins.diagnostics.shellcheck.with({
			diagnostics_format = "[#{c}] #{m} (#{s})",
		}),
		null_ls.builtins.formatting.black.with({ extra_args = { "-l", "120", "--fast" } }),
		null_ls.builtins.diagnostics.eslint_d.with({
			condition = function(utils)
				return utils.root_has_file(".eslintrc.json")
			end,
		}),
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.eslint_d.with({
			condition = function(utils)
				return utils.root_has_file(".eslintrc.json")
			end,
		}),

		-- actions
		null_ls.builtins.code_actions.shellcheck,
	},
})
