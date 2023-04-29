local M = {}
local luasnip = require("luasnip")
local neogen = require("neogen")

function M.add_to_hist_and_run(cmd)
	local vim_cmd = "Run " .. cmd
	vim.cmd([[:call histadd("cmd", "]] .. vim_cmd .. [[")]])
	vim.cmd(":" .. vim_cmd)
end

function M.getPythonModulePath(filePath)
	local modulePath = string.gsub(filePath, "/", ".")
	modulePath = string.gsub(modulePath, ".py$", "")
	return modulePath
end

function M.executePythonModule(filePath)
	local modulePath = M.getPythonModulePath(filePath)
	M.add_to_hist_and_run("python -m " .. modulePath)
end

function M.executePythonModuleInteractive(filePath)
	local modulePath = M.getPythonModulePath(filePath)
	M.add_to_hist_and_run("python -im " .. modulePath)
end

-- function M.importPythonModule(filePath)
-- 	local modulePath = M.getPythonModulePath(filePath)
-- 	vim.call("VimuxRunCommand", "from " .. modulePath .. " import *")
-- end

-- function M.VimuxSlime()
-- 	local code = vim.fn.getreg("v")
-- 	vim.call("VimuxRunCommand", code, 0)
-- end

function M.expand_or_jump()
	if luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	elseif neogen.jumpable() then
		neogen.jump_next()
	end
end

function M.jump_prev()
	if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	elseif neogen.jumpable(-1) then
		neogen.jump_prev()
	end
end

function M.load_commands()
	local pwd = vim.env.PWD
	local filename = string.gsub(pwd, "/", "_")
	vim.cmd(":e /tmp/" .. filename)
	vim.cmd([[
		:set filetype=bash
		]])
end

function M.count_or_one()
	if vim.v.count == nil or vim.v.count == 0 then
		return 1
	else
		return vim.v.count
	end
end

function M.execute_from_harpoon()
	local cmd = require("harpoon").get_term_config().cmds[M.count_or_one()]
	if cmd then
		M.add_to_hist_and_run(cmd)
	end
end

function M.get_terminals()
	local final_table = {}
	local bufs = vim.api.nvim_list_bufs()
	local fzf_lua = require'fzf-lua'
	for _, b in ipairs(bufs) do
		local path = vim.api.nvim_buf_get_name(b)
		if vim.startswith(path, "term://") and vim.api.nvim_buf_is_loaded(b) then
			table.insert(final_table, path)
		end
	end
	fzf_lua.fzf_exec(
		final_table,
		{
			actions = {
				['default'] = function(selected, opts)
					vim.cmd(":b " .. selected[1])
				end,
				['ctrl-x'] = function(selected, opts)
					vim.cmd(":bd! " .. selected[1])
				end,
			},
		}
	)
end

function M.restart_cmd()
	local title = vim.b.term_title
	if title == nil then
		return
	end
	local cmd = title:match("term://.*:(.*)")
	local current_id = vim.api.nvim_get_current_buf()
	vim.cmd(":terminal " .. cmd)
	vim.api.nvim_buf_delete(current_id, {force = true})
end
return M
