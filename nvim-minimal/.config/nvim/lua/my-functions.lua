local M = {}
local Terminal  = require('toggleterm.terminal').Terminal

function M.getPythonModulePath(filePath)
    local modulePath = string.gsub(filePath, "/", ".")
    modulePath = string.gsub(modulePath, ".py$", "")
    return modulePath
end

function M.executePythonModule(filePath)
    local modulePath = M.getPythonModulePath(filePath)
    vim.cmd("terminal python -m " .. modulePath)
end

local pythonRepl = Terminal:new({
    cmd = "python",
    hidden = true,
    on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<F3>", "<cmd>close<CR>", {noremap = true, silent = true})
    end,
})

function M.python_repl_toggle()
    pythonRepl:toggle()
end

function M.send_to_python_repl()
    local cur_line = vim.api.nvim_get_current_line()
    pythonRepl:open()
    pythonRepl:send(cur_line, false)
end

return M
