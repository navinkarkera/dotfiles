local M = {}
local luasnip = require("luasnip")
local neogen = require("neogen")

function M.getPythonModulePath(filePath)
	local modulePath = string.gsub(filePath, "/", ".")
	modulePath = string.gsub(modulePath, ".py$", "")
	return modulePath
end

function M.executePythonModule(filePath)
	local modulePath = M.getPythonModulePath(filePath)
	vim.call("VimuxRunCommand", "activate; python -m " .. modulePath)
end

function M.executePythonModuleInteractive(filePath)
	local modulePath = M.getPythonModulePath(filePath)
	vim.call("VimuxRunCommand", "activate; python -im " .. modulePath)
end

function M.VimuxSlime()
	local code = vim.fn.getreg("v")
	vim.call("VimuxRunCommand", code, 0)
end

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

return M
