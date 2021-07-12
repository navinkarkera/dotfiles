if executable("black")
    setlocal formatprg=black\ -q\ -
    setlocal formatexpr=
endif

nnoremap <leader>pd Obreakpoint()<Esc>
nnoremap <F5> :sp<bar>lua require("my-functions").executePythonModule('<C-R>=expand("%")<CR>')<CR>
nnoremap <F7> :sp<bar>terminal pytest -vvs %<CR>
nnoremap <F8> :sp<bar>terminal pytest -vvsk <C-R>=expand("<cword>")<CR><CR>
