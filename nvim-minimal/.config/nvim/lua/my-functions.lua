local M = {}

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
	code = vim.fn.getreg("v")
	vim.call("VimuxRunCommand", code, 0)
end

return M
