nnoremap <leader>pd Obreakpoint()<Esc>==
nnoremap <silent> <buffer> <F5> :lua require("my-functions").executePythonModule('<C-R>=expand("%:.")<CR>')<CR>

" Run all tests
nnoremap <silent> <buffer> <F6> :lua require("my-functions").add_to_hist_and_run("python -m pytest -vvs")<CR>

" Run current test file
nnoremap <silent> <buffer> <F7> :lua require("my-functions").add_to_hist_and_run("python -m pytest -vvs <C-R>=expand('%:.')<CR>")<CR>

" Run test function under cursor
nnoremap <silent> <buffer> <F8> :norm w[mw<CR> :lua require("my-functions").add_to_hist_and_run("python -m pytest -vvs <C-R>=expand('%:.')<CR> -k <C-R>=expand('<cword>')<CR>")<CR>

" run module interactive
nnoremap <silent> <buffer> <leader>, :lua require("my-functions").executePythonModuleInteractive('<C-R>=expand("%:.")<CR>')<CR>
