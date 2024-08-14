" Run all tests
nnoremap <silent> <buffer> <F6> :lua require("my-functions").add_to_hist_and_run("npm run test")<CR>
" Run all tests in harpoon terminal
nnoremap <silent> <buffer> <leader><F6> :lua require("harpoon.term").sendCommand(require('my-functions').count_or_one(), "npm run test")<CR>

" Run current test file
nnoremap <silent> <buffer> <F7> :lua require("my-functions").add_to_hist_and_run("npm run test -- <C-R>=expand('%:.')<CR>")<CR>
" Run current test in file
nnoremap <silent> <buffer> <F8> :norm w[mF'"vyi'<CR> :lua require("my-functions").add_to_hist_and_run("npm run test -- <C-R>=expand('%:.')<CR> -t '<C-R>v'")<CR>
" Run current test file in harpoon terminal
nnoremap <silent> <buffer> <leader><F7> :lua require("harpoon.term").sendCommand(require('my-functions').count_or_one(),"npm run test -- <C-R>=expand('%:.')<CR>")<CR>

