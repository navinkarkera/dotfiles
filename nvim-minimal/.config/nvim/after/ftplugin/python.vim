if executable("black")
    setlocal formatprg=black\ -q\ -
    setlocal formatexpr=
endif

nnoremap <leader>pd Obreakpoint()<Esc>
nnoremap <F5> :sp<bar>terminal python %<CR>
nnoremap <F6> :sp<bar>terminal pytest -vvs %<CR>
