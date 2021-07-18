fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

nnoremap <silent> <leader>c :call ToggleQuickFix()<cr>

augroup WhiteSpace
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

augroup FTMAIL
    autocmd!
    autocmd BufRead,BufNewFile /tmp/nail-* setlocal ft=mail
    autocmd BufRead,BufNewFile *s-nail-* setlocal ft=mail
augroup END

augroup NORA
    autocmd FileType html,htmldjango,scss,css,javascript,jsx,typescriptreact,vue setlocal tabstop=2 shiftwidth=2 expandtab
    autocmd FileType markdown setlocal spell wrap

    autocmd TextYankPost * silent! lua require 'vim.highlight'.on_yank({timeout = 40})
    autocmd BufWritePre *.py :Black
    autocmd BufWritePost bm-files,bm-dirs !shortcut
    autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
    autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrd %
    autocmd BufWritePost ~/.local/src/dwmblocks/config.h !c ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }
augroup END
