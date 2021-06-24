if executable("black")
    setlocal formatprg=black\ -q\ -
    setlocal formatexpr=
endif

nnoremap <leader>pd Obreakpoint()<Esc>
