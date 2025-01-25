my_funs = require('my-functions')
harpoon_term = require('harpoon.term')
local ts_query = [[
  ; Class
  (
    (
      class_definition name: (identifier) @test-name
      (#match? @test-name "[Tt]est")
    )
  @scope-root)

  ; Function
  (
    (
      function_definition name: (identifier) @test-name
      (#match? @test-name "^[Tt]est")
    )
  @scope-root)
]]

local function run_test(in_harpoon, reload_on_change)
  local tests = my_funs.find_nearest_test("python", ts_query)
  local current_file = vim.fn.expand('%:.')
  if in_harpoon == true then
    harpoon_term.sendCommand(
      my_funs.count_or_one(),
      "unset DJANGO_SETTINGS_MODULE; unset SERVICE_VARIANT; export EDXAPP_TEST_MONGO_HOST=mongodb; python -m pytest --ds=cms.envs.tutor.test --no-header --no-summary -s --disable-warnings -rfex --pdb " .. current_file .. " -k '" .. table.concat(tests, " and ") .. "'"
    )
  else
    my_funs.add_to_hist_and_run("python -m pytest --no-header --no-cov -s --disable-warnings -rfex " .. current_file .. " -k '" .. table.concat(tests, " and ") .. "'", "RunT ", reload_on_change)
  end
end

vim.keymap.set('n', '<leader>pd', "Obreakpoint()<Esc>==", { buffer = true })
vim.keymap.set('n', '<F5>', function() my_funs.executePythonModule(vim.fn.expand("%:.")) end, { buffer = true })
vim.keymap.set('n', ',<F5>', function() my_funs.executePythonModule(vim.fn.expand("%:."), true) end, { buffer = true })

-- Run all tests
vim.keymap.set('n', '<F6>', function()
  my_funs.add_to_hist_and_run("python -m pytest --no-header --no-cov-on-fail --no-summary -s --disable-warnings -rfex", "RunT ")
end, { buffer = true })
vim.keymap.set('n', ',<F6>', function()
  my_funs.add_to_hist_and_run(
    "python -m pytest --no-header --no-summary --no-cov -s --disable-warnings -rfex",
    "RunT ",
    true
  )
end, { buffer = true })
-- Run all tests in harpoon terminal
vim.keymap.set('n', '<leader><F6>', function()
  harpoon_term.sendCommand(
    my_funs.count_or_one(),
    "unset DJANGO_SETTINGS_MODULE; unset SERVICE_VARIANT; export EDXAPP_TEST_MONGO_HOST=mongodb; python -m pytest --ds=cms.envs.tutor.test --no-header -s --disable-warnings -rfex --pdb"
  )
end, { buffer = true })

-- Run all tests in current_file
vim.keymap.set('n', '<F7>', function()
  my_funs.add_to_hist_and_run("python -m pytest --no-header --no-cov-on-fail -s --disable-warnings -rfex " .. vim.fn.expand('%:.'), "RunT ")
end, { buffer = true })
vim.keymap.set('n', ',<F7>', function()
  my_funs.add_to_hist_and_run(
    "python -m pytest --no-header --no-cov-on-fail -s --disable-warnings -rfex " .. vim.fn.expand('%:.'),
    "RunT ",
    true
  )
end, { buffer = true })
-- Run all tests in current_file in harpoon terminal
vim.keymap.set('n', '<leader><F7>', function()
  harpoon_term.sendCommand(
    my_funs.count_or_one(),
    "unset DJANGO_SETTINGS_MODULE; unset SERVICE_VARIANT; export EDXAPP_TEST_MONGO_HOST=mongodb; python -m pytest --ds=cms.envs.tutor.test --no-header --no-summary -s --disable-warnings -rfex --pdb " .. vim.fn.expand('%:.')
  )
end, { buffer = true })

-- Run test function under cursor
vim.keymap.set('n', '<F8>', run_test, { buffer = true })
vim.keymap.set('n', ',<F8>', function() run_test(false, true) end, { buffer = true })
-- Run test function under cursor in harpoon
vim.keymap.set('n', '<leader><F8>', function() run_test(true) end, { buffer = true })
