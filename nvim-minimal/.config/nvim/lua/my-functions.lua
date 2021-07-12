local M = {}

function M.getPythonModulePath(filePath)
    local modulePath = string.gsub(filePath, "/", ".")
    modulePath = string.gsub(modulePath, ".py$", "")
    return modulePath
end

function M.executePythonModule(filePath)
    local modulePath = M.getPythonModulePath(filePath)
    vim.cmd("terminal python -m " .. modulePath)
end

return M
