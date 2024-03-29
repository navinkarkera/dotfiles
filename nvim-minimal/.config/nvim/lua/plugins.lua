---@diagnostic disable: undefined-global
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
	execute("packadd packer.nvim")
end

return require("packer").startup(function()
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use({
		"lewis6991/impatient.nvim",
	})

	-- lsp plugings
	use({
		"L3MON4D3/LuaSnip",
		requires = { "rafamadriz/friendly-snippets" },
	})
	use({
		"hrsh7th/nvim-cmp",
		config = function()
			require("cmp-conf")
		end,
		requires = {
			{ "saadparwaiz1/cmp_luasnip" },
		},
	})
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("lsp-config")
		end,
		requires = {
			{ "hrsh7th/cmp-nvim-lsp" },
		},
	})
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("null")
		end,
		requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	})

	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" }, { "nvim-telescope/telescope-fzf-native.nvim", run = "make" } },
		config = function()
			require("fuzzy")
		end,
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("treesitter-config")
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	})
	use({
		"danymat/neogen",
		after = "nvim-lspconfig",
		config = function()
			require("neogen-conf")
		end,
		requires = "nvim-treesitter/nvim-treesitter",
	})
	use({ "tpope/vim-fugitive", opt = true, cmd = { "Git", "G" } })
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use({ "tpope/vim-surround", event = "BufEnter" })
	use({ "andymass/vim-matchup", event = "BufEnter" })
	use({
		"mattn/emmet-vim",
		ft = {
			"html",
			"javascript",
			"vue",
			"javascriptreact",
			"typescriptreact",
			"jsx",
			"tsx",
			"xml",
			"htmldjango",
		},
	})
	use({
		"preservim/vimux",
		event = "VimEnter",
		config = function()
			require("vimux-conf")
		end,
	})
	use({
		"numToStr/Navigator.nvim",
		event = "VimEnter",
		config = function()
			require("nav-conf")
		end,
	})
	use({
		"mickael-menu/zk-nvim",
		config = function()
			require("notes-conf")
		end,
	})
	use({
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		config = function()
			require("bqf-conf")
		end,
	})
	use({
		"ThePrimeagen/harpoon",
		config = function()
			require("harpoon-conf")
		end,
	})
	use({
		"tamago324/lir.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("file-manager-conf")
		end,
	})
	use({
		"mcchrish/zenbones.nvim",
		requires = "rktjmp/lush.nvim",
		config = function()
			vim.g.vimbones_solid_float_border = true
			vim.cmd([[colorscheme vimbones]])
		end,
	})
	use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			require("refactoring").setup({
				-- overriding printf statement for python
				print_var_statements = {
					python = {
						'print(f"""%s {%s}""")',
					},
				},
			})
			-- prompt for a refactor to apply when the remap is triggered
			vim.api.nvim_set_keymap(
				"v",
				"<leader>rr",
				":lua require('refactoring').select_refactor()<CR>",
				{ noremap = true, silent = true, expr = false }
			)
			-- You can also use below = true here to to change the position of the printf
			-- statement (or set two remaps for either one). This remap must be made in normal mode.
			vim.api.nvim_set_keymap(
				"n",
				"<leader>rp",
				":lua require('refactoring').debug.printf({below = false})<CR>",
				{ noremap = true }
			)

			-- Print var: this remap should be made in visual mode
			vim.api.nvim_set_keymap(
				"v",
				"<leader>rv",
				":lua require('refactoring').debug.print_var({})<CR>",
				{ noremap = true }
			)

			-- Cleanup function: this remap should be made in normal mode
			vim.api.nvim_set_keymap(
				"n",
				"<leader>rc",
				":lua require('refactoring').debug.cleanup({})<CR>",
				{ noremap = true }
			)
		end,
	})
end)
