" Goyo and limelight
nmap <silent><Leader>f :Goyo<CR>
function! s:goyo_enter()
  set noshowcmd
  Limelight 0.7
endfunction

function! s:goyo_leave()
  set showcmd
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

