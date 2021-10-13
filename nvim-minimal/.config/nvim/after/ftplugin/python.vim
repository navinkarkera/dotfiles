if executable("flake8")
    setlocal makeprg=flake8
endif

nnoremap <leader>pd Obreakpoint()<Esc>
nnoremap <silent> <buffer> <F3> :VimuxRunCommand("[[ -d .venv ]] && source .venv/bin/activate; python")<CR>
nnoremap <silent> <buffer> <F5> :sp<bar>lua require("my-functions").executePythonModule('<C-R>=expand("%:.")<CR>')<CR>
nnoremap <silent> <buffer> <F6> :sp<bar>terminal python -m pytest -vvs<CR>
nnoremap <silent> <buffer> <F7> :sp<bar>terminal python -m pytest -vvs %:.<CR>
nnoremap <silent> <buffer> <F8> :norm w[mw<CR> :sp<bar>terminal python -m pytest -vvsk <C-R>=expand("<cword>")<CR><CR>
