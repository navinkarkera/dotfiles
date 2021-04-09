" FormatFile() {{{1
" quickly format the file without moving the cursor or window
function! my_utils#FormatFile()
	let b:PlugView=winsaveview()
	exe 'silent normal! gggqG'
	call winrestview(b:PlugView)
	echo 'file formatted'
endfunction
" 1}}} "FormatFile()
