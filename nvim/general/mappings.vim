" Basic Key Mappings

imap <C-h> <C-w>h
imap <C-j> <C-w>j
imap <C-k> <C-w>k
imap <C-l> <C-w>l
" g Leader key
let mapleader=" "

" Better indenting
vnoremap < <gv
vnoremap > >gv

" greatest remap ever
vnoremap <leader>p "_dP
nnoremap <leader>cn :cn<CR>
nnoremap <leader>cp :cp<CR>

vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
nnoremap <leader>ghw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprevious<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <Leader>pv :NvimTreeToggle<CR>
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
