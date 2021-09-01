if executable("black")
    setlocal formatprg=black\ -q\ -
    setlocal formatexpr=
endif

if executable("flake8")
    setlocal makeprg=flake8
endif

nnoremap <leader>pd Obreakpoint()<Esc>
nnoremap <silent> <buffer> <F3> :lua require("my-functions").python_repl_toggle()<CR>
nnoremap <silent> <buffer> <F5> :sp<bar>lua require("my-functions").executePythonModule('<C-R>=expand("%:.")<CR>')<CR>
nnoremap <silent> <buffer> <F6> :sp<bar>terminal python -m pytest -vvs<CR>
nnoremap <silent> <buffer> <F7> :sp<bar>terminal python -m pytest -vvs %:.<CR>
nnoremap <silent> <buffer> <F8> :norm w[mw<CR> :sp<bar>terminal python -m pytest -vvsk <C-R>=expand("<cword>")<CR><CR>
nnoremap <silent> <buffer> <leader><CR> :lua require("my-functions").send_to_python_repl()<CR>
vnoremap <silent> <buffer> <leader><CR> "hy:lua require("my-functions").send_selected_to_python_repl()<CR>
