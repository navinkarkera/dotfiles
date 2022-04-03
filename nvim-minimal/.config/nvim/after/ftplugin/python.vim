nnoremap <leader>pd Obreakpoint()<Esc>
nnoremap <silent> <buffer> <F3> :VimuxRunCommand("activate; python")<CR>
nnoremap <silent> <buffer> <F5> :lua require("my-functions").executePythonModule('<C-R>=expand("%:.")<CR>')<CR>

" Run all tests
nnoremap <silent> <buffer> <F6> :VimuxRunCommand("activate; python -m pytest -vvs")<CR>

" Run current test file
nnoremap <silent> <buffer> <F7> :VimuxRunCommand("activate; python -m pytest -vvs <C-R>=expand('%:.')<CR>")<CR>

" Run test function under cursor
nnoremap <silent> <buffer> <F8> :norm w[mw<CR> :VimuxRunCommand("activate; python -m pytest -vvsk <C-R>=expand('<cword>')<CR>")<CR>

" run module interactive
nnoremap <silent> <buffer> <leader>, :lua require("my-functions").executePythonModuleInteractive('<C-R>=expand("%:.")<CR>')<CR>
