" Better indenting
vnoremap < <gv
vnoremap > >gv

nnoremap <C-j> :cn<CR>
nnoremap <C-k> :cp<CR>

vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprevious<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap gQ :<C-U>call my_utils#FormatFile()<CR>
nnoremap <Leader>pv :Explore<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader>+ :vertical resize +15<CR>
nnoremap <Leader>- :vertical resize -10<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <F28> :bd<CR>
nnoremap <C-m> ]m
nnoremap <C-s> :w<CR>

" Terminal esc remap
:tnoremap <F1> <C-\><C-n>
