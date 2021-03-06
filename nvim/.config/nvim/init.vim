set iskeyword+=-                      	" treat dash separated words as a word text object"
set formatoptions-=cro                  " Stop newline continution of comments

syntax enable

set encoding=utf-8
set ruler
set mouse=a
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.local/share/vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set path+=**
set wildmenu
set wildmode=longest:full,full
set noshowmode
" neovim only
set inccommand=nosplit
set clipboard+=unnamedplus

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=100
set signcolumn=number
highlight ColorColumn ctermbg=0 guibg=grey

set nocp
filetype plugin indent on

if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    set grepformat^=%f:%l:%c:%m
else
    set grepprg=grep\ -RI\ -n\ --exclude-dir\ .git\ --exclude-dir\ .venv\ --exclude-dir\ */node_modules/*
endif

" g Leader key
let mapleader=" "
let g:netrw_banner = 0
let g:netrw_liststyle = 0
let g:netrw_list_hide= '.git'

lua require("navin")

" Python provider path
let g:python3_host_prog = '/usr/bin/python'

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

augroup NORA
    autocmd!
    " Autocommands
    autocmd FileType html,htmldjango,scss,css,javascript,jsx,typescriptreact,vue setlocal tabstop=2 shiftwidth=2 expandtab
    autocmd FileType markdown setlocal spell wrap

    autocmd BufWritePost plugins.lua PackerCompile
    autocmd BufEnter * lua require'completion'.on_attach()
    autocmd BufWritePre * :call TrimWhitespace()
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
    autocmd BufWritePre *.py execute ':Black'
" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost bm-files,bm-dirs !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
	autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %
" Recompile dwmblocks on config edit.
	autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }
augroup END

augroup ProjectDrawer
    autocmd!
    autocmd VimEnter * if argc() == 0 | Explore! | endif
augroup END
