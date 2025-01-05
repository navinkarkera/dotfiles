local M = {}
local luasnip = require("luasnip")
local neogen = require("neogen")
local last_cmd = nil

function M.add_to_hist_and_run(cmd, runner)
  local cmd_runner = runner or "Run "
  local vim_cmd = cmd_runner .. cmd
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

local function cmd_from_term_title(title)
  title_parts = vim.split(title, ":")
  table.remove(title_parts, 1)
  table.remove(title_parts, 1)
  cmd = vim.iter(title_parts):join(":")
  return cmd
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
          Snacks.terminal.toggle(cmd_from_term_title(selected[1]))
        end,
        ['ctrl-r'] = {
          fn = function(selected, opts)
            local cmd = cmd_from_term_title(selected[1])
            local terminal = Snacks.terminal.get(cmd)
            terminal:close()
            actions.ex_run_cr({ "RunB " .. cmd })
          end,
          exec_silent = true,
          reload = true,
        },
        ['ctrl-x'] = {
          fn = function(selected, opts)
            local cmd = cmd_from_term_title(selected[1])
            local terminal = Snacks.terminal.get(cmd)
            terminal:close()
          end,
          exec_silent = true,
          reload = true,
        },
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

function M.fzf_all_tasks()
  local fzf_lua = require 'fzf-lua'
  local actions = require "fzf-lua.actions"
  fzf_lua.fzf_exec(
    "atuin search --format={command} --reverse",
    {
      prompt="Run> ",
      fzf_opts = { ["--header"] = [[enter:run | ctrl-b:background | ctrl-e:edit]]  },
      actions = {
        ['default'] = function(selected, opts)
          local cmd = selected[1]
          M.add_to_hist_and_run(cmd)
        end,
        ['ctrl-b'] = function(selected, opts)
          local cmd = selected[1]
          M.add_to_hist_and_run(cmd, "RunB ")
        end,
        ['ctrl-e'] = function(selected, opts)
          local cmd = selected[1]
          actions.ex_run({ "Run " .. cmd })
        end,
      },
    }
  )
end

function M.restart_cmd()
  local title = vim.b.term_title
  if title ~= nil then
    local cmd = cmd_from_term_title(title)
    local terminal = Snacks.terminal.get(cmd)
    terminal:close()
    M.add_to_hist_and_run(cmd)
  elseif last_cmd ~= nil then
    M.run_snack_command(last_cmd, false, true)
  end
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
  local start = os.time()
  vim.fn.termopen(cmd, {on_exit=function(job_id, exit_code, event)
    local status = "SUCCESS-0"
    local priority = "default"
    if exit_code ~= 0 then
      status = "FAILED-" .. exit_code
      priority = "high"
    end
    cmd = string.gsub(cmd, '"', '\\"')
    local elapsed_time = os.difftime(os.time(), start)
    vim.system({'notify-send', '--icon', 'neovim', [[[]] .. status .. [[ | Took: ]] .. elapsed_time .. [[] ]], [[CMD: ]] .. cmd .. [[\n]].. vim.fn.getcwd()})
    if elapsed_time > 10 then
    -- if true then
      local hostname = vim.fn.hostname()
      local nfty_cmd = {'curl', '-H', [[Title: ]] .. cmd .. [[ | ]] .. status .. [[ | Took: ]] .. elapsed_time, '-H', [[Priority: ]] .. priority, '-d', [["]] .. vim.fn.getcwd() .. [["]], 'ntfy.sh/nrk_mangalpete_' .. hostname .. '_reminders'}
      vim.system(nfty_cmd)
    end
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
    vim.cmd("resize 20")
    term_run_cmd(cmd)
    vim.api.nvim_buf_delete(buf, { force = true })
  else
    vim.cmd("new")
    vim.cmd("resize 20")
    term_run_cmd(cmd)
    vim.cmd("setfiletype terminal")
  end
  vim.api.nvim_input([[<C-\><C-n>]])
  -- vim.api.nvim_input("G")
  if background then
    vim.api.nvim_input("<C-w>c")
  else
    vim.api.nvim_set_current_win(cur_win)
    vim.api.nvim_win_set_cursor(cur_win, cur_position)
    -- vim.api.nvim_input("<C-w><C-p>")
  end
end

function M.run_snack_command(cmd, background, restart)
  local terminal, created = Snacks.terminal.get(cmd, {interactive = false})
  if created then
    last_cmd = cmd
    local start = os.time()
    vim.api.nvim_create_autocmd("TermClose", {
      once = true,
      buffer = terminal.buf,
      callback = function()
        local status = "SUCCESS-0"
        local priority = "default"
        local exit_code = vim.v.event.status
        if exit_code ~= 0 then
          status = "FAILED-" .. exit_code
          priority = "high"
        end
        cmd = string.gsub(cmd, '"', '\\"')
        local elapsed_time = os.difftime(os.time(), start)
        vim.system({'notify-send', '--icon', 'neovim', [[[]] .. status .. [[ | Took: ]] .. elapsed_time .. [[] ]], [[CMD: ]] .. cmd .. [[\n]].. vim.fn.getcwd()})
        if elapsed_time > 10 then
          -- if true then
          local hostname = vim.fn.hostname()
          local nfty_cmd = {'curl', '-H', [[Title: ]] .. cmd .. [[ | ]] .. status .. [[ | Took: ]] .. elapsed_time, '-H', [[Priority: ]] .. priority, '-d', [["]] .. vim.fn.getcwd() .. [["]], 'ntfy.sh/nrk_mangalpete_' .. hostname .. '_reminders'}
          vim.system(nfty_cmd)
        end
      end,
    })
    if background == true then
      terminal:hide()
    end
  else
    if restart == true then
      terminal:close()
      M.add_to_hist_and_run(cmd)
    else
      terminal:toggle()
    end
  end
end

---@param types string[] Will return the first node that matches one of these types
---@param node TSNode|nil
---@return TSNode|nil
local function find_node_ancestor(types, node)
  if not node then
    return nil
  end

  if vim.tbl_contains(types, node:type()) then
    return node
  end

  local parent = node:parent()

  return find_node_ancestor(types, parent)
end


---When typing "await" add "async" to the function declaration if the function
---isn't async already.
function M.add_async()
  -- This function should be executed when the user types "t" in insert mode,
  -- but "t" is not inserted because it's the trigger.
  vim.api.nvim_feedkeys('t', 'n', true)

  local buffer = vim.fn.bufnr()

  local text_before_cursor = vim.fn.getline('.'):sub(vim.fn.col '.' - 4, vim.fn.col '.' - 1)
  if text_before_cursor ~= 'awai' then
    return
  end

  -- ignore_injections = false makes this snippet work in filetypes where JS is injected
  -- into other languages
  local current_node = vim.treesitter.get_node { ignore_injections = false }
  local function_node = find_node_ancestor(
    { 'arrow_function', 'function_declaration', 'function', 'method_definition' },
    current_node
  )
  if not function_node then
    return
  end

  local function_text = vim.treesitter.get_node_text(function_node, 0)
  if vim.startswith(function_text, 'async') then
    return
  end

  local start_row, start_col = function_node:start()
  vim.api.nvim_buf_set_text(buffer, start_row, start_col, start_row, start_col, { 'async ' })
end

return M
