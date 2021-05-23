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
set undodir=~/.vim/undodir
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

" auto-install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif



call plug#begin('~/.vim/plugged')

" Neovim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'lifepillar/vim-mucomplete'
Plug 'ray-x/lsp_signature.nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'


Plug 'psf/black', { 'branch': 'stable' }
Plug 'tpope/vim-fugitive', { 'on': ['G', 'GStatus'] }
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim', { 'for': ['javascript', 'jsx', 'html', 'css'] }
Plug 'vimwiki/vimwiki'
Plug 'skywind3000/asynctasks.vim', { 'on': ['AsyncRun', 'AsyncStop', 'AsyncTask', 'AsyncTaskList'] }
Plug 'skywind3000/asyncrun.vim', { 'on': ['AsyncRun', 'AsyncStop', 'AsyncTask', 'AsyncTaskList'] }
Plug 'GustavoKatel/telescope-asynctasks.nvim', { 'on': ['AsyncRun', 'AsyncStop', 'AsyncTask', 'AsyncTaskList'] }

Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': ['Goyo', 'LimeLight'] }

Plug 'vim-test/vim-test', { 'for': ['python', 'python3'] }
Plug 'dbeniamine/cheat.sh-vim'

" snippets
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'

Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'mhartington/oceanic-next'
Plug 'ayu-theme/ayu-vim'
Plug 'arcticicestudio/nord-vim'

call plug#end()


if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    set grepformat^=%f:%l:%c:%m
else
    set grepprg=grep\ -RI\ -n\ --exclude-dir\ .git\ --exclude-dir\ .venv\ --exclude-dir\ */node_modules/*
endif

" g Leader key
let mapleader=" "

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
    autocmd FileType html,scss,css,javascript,jsx EmmetInstall
    autocmd FileType html,htmldjango,scss,css,javascript,jsx,typescriptreact,vue setlocal tabstop=2 shiftwidth=2 expandtab
    autocmd FileType markdown setlocal spell wrap

    autocmd BufWritePre * :call TrimWhitespace()
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
    autocmd BufWritePre *.py execute ':Black'
    autocmd FileType TelescopePrompt :call mucomplete#auto#disable()
    autocmd BufEnter,BufWinEnter,TabEnter * :call mucomplete#auto#enable()
augroup END

augroup ProjectDrawer
    autocmd!
    autocmd VimEnter * if argc() == 0 | Explore! | endif
augroup END
