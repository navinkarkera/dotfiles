my_funs = require('my-functions')
harpoon_term = require('harpoon.term')
local ts_query = [[
  ((expression_statement
    (call_expression
      function: (identifier) @method-name
      (#match? @method-name "^(describe|test|it)")
      arguments: (arguments [
        ((string) @test-name)
        ((template_string) @test-name)
      ]
    )))
  @scope-root)
]]

local function parse_testname(name)
  return name:gsub("^[\"'`]", ""):gsub("[\"'`]$", "")
end

local function run_test(reload_on_change)
  local tests = my_funs.find_nearest_test("javascript", ts_query, parse_testname)
  local current_file = vim.fn.expand('%:.')
  if reload_on_change == true then
    current_file = "--watch " .. current_file
  end
  my_funs.add_to_hist_and_run("npm run test -- --coverage=false " .. current_file .. " -t=\"" .. table.concat(tests, " ") .. "\"")
end

vim.keymap.set('i', 't', require'my-functions'.add_async, { buffer = true })

-- Run all tests
vim.keymap.set('n', '<F6>', function()
  my_funs.add_to_hist_and_run("npm run test")
end, { buffer = true })

-- Run all tests in current_file
vim.keymap.set('n', '<F7>', function()
  my_funs.add_to_hist_and_run("npm run test -- " .. vim.fn.expand('%:.'))
end, { buffer = true })
vim.keymap.set('n', ',<F7>', function()
  my_funs.add_to_hist_and_run("npm run test -- --watch " .. vim.fn.expand('%:.'))
end, { buffer = true })

-- Run test function under cursor
vim.keymap.set('n', '<F8>', run_test, { buffer = true })
vim.keymap.set('n', ',<F8>', function() run_test(true) end, { buffer = true })
