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

    autocmd TextYankPost * silent! lua require 'vim.highlight'.on_yank({timeout = 40})
    autocmd BufWritePre *.py :Black
    autocmd BufWritePost bm-files,bm-dirs !shortcut
    autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
    autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrd %
    autocmd BufWritePost ~/.local/src/dwmblocks/config.h !c ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }
augroup END

colorscheme slate
highlight Pmenu ctermbg=black ctermfg=lightgrey guibg=black guifg=lightgrey
highlight PmenuSel ctermbg=lightgrey ctermfg=black guibg=lightgrey guifg=black

highlight LineNr guibg=grey20 guifg=grey50
highlight CursorLineNr guibg=grey20 guifg=grey40
highlight CursorLine guibg=grey20
highlight ColorColumn guibg=grey20
highlight MatchWord guibg=grey30
highlight FloatBorder guibg=Black

function! CleverTab()
  if pumvisible()
    return "\<C-N>"
  endif
  if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
    return "\<Tab>"
  else
    return "\<C-N>"
  endif
endfunction
inoremap <expr> <silent> <tab> CleverTab()

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
inoremap <expr> <silent> <tab> CleverTab()
inoremap <expr> <silent> <c-space> OmniCom()
