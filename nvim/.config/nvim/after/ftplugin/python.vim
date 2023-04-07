nnoremap <leader>pd Obreakpoint()<Esc>==
nnoremap <silent> <buffer> <F3> :lua require('harpoon.term').sendCommand(require('my-functions').count_or_one(), "python")<CR>
nnoremap <silent> <buffer> <F5> :lua require("my-functions").executePythonModule('<C-R>=expand("%:.")<CR>')<CR>

" Run all tests
nnoremap <silent> <buffer> <F6> :lua require('harpoon.term').sendCommand(require('my-functions').count_or_one(), "python -m pytest -vvs")<CR>

" Run current test file
nnoremap <silent> <buffer> <F7> :lua require('harpoon.term').sendCommand(require('my-functions').count_or_one(), "python -m pytest -vvs <C-R>=expand('%:.')<CR>")<CR>

" Run test function under cursor
nnoremap <silent> <buffer> <F8> :norm mww[mw<CR> :lua require('harpoon.term').sendCommand(require('my-functions').count_or_one(), "python -m pytest -vvs <C-R>=expand('%:.')<CR> -k <C-R>=expand('<cword>')<CR>")<CR>`w

" run module interactive
nnoremap <silent> <buffer> <leader>, :lua require("my-functions").executePythonModuleInteractive('<C-R>=expand("%:.")<CR>')<CR>
nnoremap <silent> <buffer> <leader>im :lua require("my-functions").importPythonModule('<C-R>=expand("%:.")<CR>')<CR>
