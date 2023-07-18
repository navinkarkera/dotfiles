local M = {}
local luasnip = require("luasnip")
local neogen = require("neogen")

function M.add_to_hist_and_run(cmd)
  local vim_cmd = "Run " .. cmd
  vim.cmd([[:call histadd("cmd", "]] .. string.gsub(vim_cmd, '"', '\\"') .. [[")]])
  vim.cmd(vim_cmd)
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

function M.fzf_get_terminals()
  local final_table = {}
  local bufs = vim.api.nvim_list_bufs()
  local fzf_lua = require 'fzf-lua'
  local actions = require "fzf-lua.actions"
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
          actions.vimcmd("split | b", selected, opts)
        end,
        ['ctrl-s'] = function(selected, opts)
          actions.vimcmd("split | b", selected, opts)
        end,
        ['ctrl-v'] = function(selected, opts)
          actions.vimcmd("vertical split | b", selected, opts)
        end,
        ['ctrl-t'] = function(selected, opts)
          actions.vimcmd("tab split | b", selected, opts)
        end,
        ['ctrl-r'] = function(selected, opts)
          local cmd = selected[1]:match("term://.*:(.*)")
          actions.ex_run_cr({ "RunB " .. cmd })
        end,
        ['ctrl-x'] = function(selected, opts)
          actions.vimcmd(":bd!", selected, opts)
        end,
      },
    }
  )
end

function M.fzf_make_tasks()
  local fzf_lua = require 'fzf-lua'
  local actions = require "fzf-lua.actions"
  fzf_lua.fzf_exec(
    "make help | tail -n +2 | sed 's/  //'",
    {
      actions = {
        ['default'] = function(selected, opts)
          local cmd = selected[1]:match("%S+")
          M.add_to_hist_and_run("make " .. cmd)
        end,
        ['ctrl-e'] = function(selected, opts)
          local cmd = selected[1]:match("%S+")
          actions.ex_run({ ":Run make " .. cmd })
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
  vim.cmd([[:call histadd("cmd", "Run ]] .. string.gsub(cmd, '"', '\\"') .. [[")]])
  vim.cmd(":terminal " .. cmd)
  vim.api.nvim_input("G")
  vim.api.nvim_buf_delete(current_id, { force = true })
end

function M.find_terminal_buffer_by_cmd(cmd)
  cmd = ":" .. string.gsub(cmd, "%s+", "%%s+") .. "$"
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local buf_name = vim.api.nvim_buf_get_name(buf)
    local is_match = string.find(buf_name, cmd)
    if is_match and vim.api.nvim_buf_is_loaded(buf) then
      return buf
    end
  end
  return nil
end

local function term_run_cmd(cmd)
  vim.fn.termopen(cmd, {on_exit=function(job_id, exit_code, event)
    local status = "SUCCESS-0"
    if exit_code ~= 0 then
      status = "FAILED-" .. exit_code
    end
    cmd = string.gsub(cmd, '"', '\\"')
    os.execute([[notify-send --icon neovim "[]] .. status .. [[]" "CMD: ]] .. cmd .. [[\n]].. vim.fn.getcwd() ..[["]])
  end})
end


function M.run_command(cmd, full_shell, background)
  local cur_win = vim.api.nvim_get_current_win()
  local cur_position = vim.api.nvim_win_get_cursor(cur_win)
  if full_shell then
    cmd = [[zsh -ic "]] .. cmd .. [["]]
  end
  local buf = M.find_terminal_buffer_by_cmd(cmd)
  if buf then
    local win_id = vim.fn.win_findbuf(buf)
    if win_id[1] then
      vim.api.nvim_set_current_win(win_id[1])
    else
      vim.cmd("botright split")
      vim.api.nvim_set_current_buf(buf)
    end
    vim.cmd("new")
    term_run_cmd(cmd)
    vim.api.nvim_buf_delete(buf, { force = true })
  else
    vim.cmd("new")
    term_run_cmd(cmd)
  end
  vim.cmd("norm G")
  if background then
    vim.api.nvim_input("<C-w>c")
  else
    vim.api.nvim_set_current_win(cur_win)
    vim.api.nvim_win_set_cursor(cur_win, cur_position)
    -- vim.api.nvim_input("<C-w><C-p>")
  end
end

return M
