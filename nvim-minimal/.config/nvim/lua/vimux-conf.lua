local map = vim.api.nvim_set_keymap
local options = { noremap = true }

map('n', '<leader>vp' , ':VimuxPromptCommand<CR>', options)
map('n', '<leader>vl' , ':VimuxRunLastCommand<CR>', options)
map('n', '<leader>vi' , ':VimuxInspectRunner<CR>', options)
map('n', '<leader>vq' , ':VimuxCloseRunner<CR>', options)
map('n', '<leader>vx' , ':VimuxInterruptRunner<CR>', options)
map('n', '<leader>vz' , ':VimuxZoomRunner<CR>', options)
map('n', '<leader>v<C-l>' , ':VimuxClearTerminalScreen<CR>', options)

map('v', '<leader>vs' , [["vy<cmd>lua require('my-functions').VimuxSlime()<CR>]], options)
map('n', '<leader>vs' , [[^v$<leader>vs<CR>]], {})
map('n', '<M-CR>' , ":call VimuxSendKeys('Enter')<CR>", options)
