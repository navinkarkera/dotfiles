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

augroup NORA
    autocmd FileType html,htmldjango,scss,css,javascript,jsx,typescriptreact,vue setlocal tabstop=2 shiftwidth=2 expandtab
    autocmd FileType markdown setlocal spell wrap
    autocmd FileType markdown let b:switch_custom_definitions =
                \ [
                    \   { '\v^(\s*[*+-] )?\[ \]': '\1[x]',
                    \     '\v^(\s*[*+-] )?\[x\]': '\1[-]',
                    \     '\v^(\s*[*+-] )?\[-\]': '\1[ ]',
                    \   },
                    \   { '\v^(\s*\d+\. )?\[ \]': '\1[x]',
                    \     '\v^(\s*\d+\. )?\[x\]': '\1[-]',
                    \     '\v^(\s*\d+\. )?\[-\]': '\1[ ]',
                    \   },
                    \ ]

    autocmd TextYankPost * silent! lua require 'vim.highlight'.on_yank({timeout = 40})
    autocmd BufWritePre *.py :Black
    autocmd BufWritePost bm-files,bm-dirs !shortcut
    autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
    autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrd %
    autocmd BufWritePost ~/.local/src/dwmblocks/config.h !c ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }
augroup END

function! CleverTab(direction)
  if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
    return "\<Tab>"
  else
    if a:direction > 0
        return "\<C-N>"
    else
        return "\<C-P>"
  endif
endfunction

function! OmniCom()
  if pumvisible()
    return "\<C-N>"
  endif
  if exists('&omnifunc') && &omnifunc != ''
    return "\<C-X>\<C-O>"
  else
    return "\<C-N>"
  endif
endfunction
" inoremap <expr> <silent> <tab> CleverTab(-1)
" inoremap <expr> <silent> <s-tab> CleverTab(1)
" inoremap <expr> <silent> <c-space> OmniCom()
nnoremap <silent> <leader>pv :Fern . -reveal=% -drawer -toggle -width=35<CR>
