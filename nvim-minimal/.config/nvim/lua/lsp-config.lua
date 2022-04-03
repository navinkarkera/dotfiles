local nvim_lsp = require("lspconfig")
local fn = vim.fn
local api = vim.api
local lsp = vim.lsp
local opts = { noremap = true, silent = true }
local border_opts = { border = 'single', focusable = false, scope = 'line' }

-- diagnostics
vim.diagnostic.config({ virtual_text = false, float = border_opts })

fn.sign_define('DiagnosticSignError', { text = '✗', texthl = 'DiagnosticSignError' })
fn.sign_define('DiagnosticSignWarn', { text = '!', texthl = 'DiagnosticSignWarn' })
fn.sign_define('DiagnosticSignInformation', { text = 'I', texthl = 'DiagnosticSignInfo' })
fn.sign_define('DiagnosticSignHint', { text = 'H', texthl = 'DiagnosticSignHint' })

-- handlers
lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help, border_opts)
lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, border_opts)

api.nvim_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
api.nvim_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
api.nvim_set_keymap("n", "<space>da", "<cmd>lua vim.diagnostic.setqflist()<CR>", opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	api.nvim_buf_set_keymap(bufnr, "n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	api.nvim_buf_set_keymap(bufnr, "n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<space>wl",
		"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
		opts
	)
	api.nvim_buf_set_keymap(bufnr, "n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	api.nvim_buf_set_keymap(bufnr, "n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	api.nvim_buf_set_keymap(bufnr, "n", "<m-a>", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	api.nvim_buf_set_keymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

    if client.resolved_capabilities.signature_help then
        vim.cmd('autocmd CursorHoldI <buffer> lua vim.lsp.buf.signature_help()')
    end

	client.resolved_capabilities.document_formatting = false
	client.resolved_capabilities.document_range_formatting = false
end
-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "tsserver", "html" }
for _, server_name in ipairs(servers) do
	nvim_lsp[server_name].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
	})
end

local sumneko_root_path = "/usr/lib/lua-language-server"
local sumneko_binary = "/usr/bin/lua-language-server"

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require("lspconfig").sumneko_lua.setup({
	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})
