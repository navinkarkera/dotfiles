syntax on

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
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Python provider path
let g:python3_host_prog = '/usr/bin/python'

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tweekmonster/gofmt.vim'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim', { 'for': ['javascript', 'jsx', 'html', 'css'] }
Plug 'honza/vim-snippets'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-commentary'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'majutsushi/tagbar'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'vim-test/vim-test'
Plug 'michaeljsmith/vim-indent-object'

Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'vim-airline/vim-airline'
Plug 'flazz/vim-colorschemes'

call plug#end()

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'medium'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection = '0'
let g:gruvbox_italic = '1'
let g:gruvbox_italicize_strings ='1'


" --- vim go (polyglot) settings.
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_auto_sameids = 1

colorscheme gruvbox
set background=dark

if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1
let mapleader = " "

let g:vrfr_rg = 'true'
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }

" Path completion with custom source command
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd --type file --follow --color=always')

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

command! -nargs=0 Prettier :CocCommand prettier.formatFile
inoremap <silent><expr> <C-space> coc#refresh()

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'
" Use enter to accept snippet expansion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

let test#strategy = {
  \ 'nearest': 'neovim',
  \ 'file':    'asyncrun_background',
  \ 'suite':   'asyncrun_background_term',
\}
let test#python#runner = 'pytest'
" Runners available are 'pytest', 'nose', 'nose2', 'djangotest', 'djangonose', 'mamba', and Python's built-in unittest as 'pyunit'

" Show documentation on hover
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

let g:coc_explorer_global_presets = {
\   '.vim': {
\     'root-uri': '~/.vim',
\   },
\   'tab': {
\     'position': 'tab',
\     'quit-on-open': v:true,
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingLeftside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'right-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }

" List all presets
nmap <space>el :CocList explPresets
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>ghw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprevious<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :CocCommand explorer --preset floating<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <C-p> :GFiles<CR>
nnoremap <C-f> :BLines<CR>
nnoremap <C-n> :Buffers<CR>
nnoremap <Leader>pf :Files<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader>+ :vertical resize +15<CR>
nnoremap <Leader>- :vertical resize -10<CR>
nnoremap <Leader>ee oif err != nil {<CR>log.Fatalf("%+v\n", err)<CR>}<CR><esc>kkI<esc>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <F28> :bd<CR>
nnoremap <C-m> ]m
nnoremap <C-s> :w<CR>

vnoremap X "_d
inoremap <C-c> <esc>

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next)
nnoremap <leader>cr :CocRestart
nmap <leader>do <Plug>(coc-codeaction)
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>


" Sweet Sweet FuGITive
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nmap <leader>gs :G<CR>

" Just git it
nmap <leader>cm :vsplit ~/Projects/commit.md<CR>
nmap <leader>gps :Dispatch just add psf<CR>
nmap <leader>gpsa :Dispatch just add amend psf<CR>
nmap <leader>gpr :Dispatch just add pr<CR>
nmap <leader>gpra :Dispatch just add amend pr<CR>

" Airline buffer tab
let g:airline#extensions#tabline#enabled = 1

" Emmet in jsx
let g:user_emmet_install_global = 0

let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\      'default_attributes' : {
\      'label': [{'htmlFor': ' '}],
\      'class': { 'className': ' '},
\    },
\  },
\}

" VimWiki
let g:vimwiki_list = [{'path': '~/owncloud/navinkarkera/books/notes/src/',
                      \ 'syntax': 'markdown', 'ext': '.md', 'index': 'SUMMARY'}]
let g:vimwiki_global_ext = 0
let g:vimwiki_markdown_link_ext = 1

" Tagbar
nnoremap <silent><F10> :TagbarToggle<CR>

" Asycrun and AsyncTask
let g:asyncrun_open = 6
nnoremap <F3> :AsyncStop<CR>
let g:asynctasks_term_pos = 'right'
let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg', 'Cargo.toml', 'pyproject.toml', '.tasks']
let g:asynctasks_template = {}
let g:asynctasks_template.cargo = [
            \ "[project-init]",
            \ "command=cargo update",
            \ "cwd=<root>",
            \ "",
            \ "[project-build]",
            \ "command=cargo build",
            \ "cwd=<root>",
            \ "errorformat=%. %#--> %f:%l:%c",
            \ "",
            \ "[project-run]",
            \ "command=cargo run",
            \ "cwd=<root>",
            \ "output=terminal",
            \ ]

" Co-operate with fugitive
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

" Co-operate with airline
let g:asyncrun_status = ''
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

" Fzf integration for AsyncTask
function! s:fzf_sink(what)
    let p1 = stridx(a:what, '<')
    if p1 >= 0
        let name = strpart(a:what, 0, p1)
        let name = substitute(name, '^\s*\(.\{-}\)\s*$', '\1', '')
        if name != ''
            exec "AsyncTask ". fnameescape(name)
        endif
    endif
endfunction

function! s:fzf_task()
    let rows = asynctasks#source(&columns * 48 / 100)
    let source = []
    for row in rows
        let name = row[0]
        let source += [name . '  ' . row[1] . '  : ' . row[2]]
    endfor
    let opts = { 'source': source, 'sink': function('s:fzf_sink'),
                \ 'options': '+m --nth 1 --inline-info --tac' }
    if exists('g:fzf_layout')
        for key in keys(g:fzf_layout)
            let opts[key] = deepcopy(g:fzf_layout[key])
        endfor
    endif
    call fzf#run(opts)
endfunction

command! -nargs=0 AsyncTaskFzf call s:fzf_task()

" AsyncTask keymaps
nnoremap <silent><F5> :AsyncTask file-run<CR>
nnoremap <silent><F6> :AsyncTask project-run<CR>
nnoremap <silent><F7> :AsyncTask project-build<CR>
nnoremap <silent><F11> :AsyncTaskFzf<CR>

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

" Terminal esc remap
:tnoremap <F1> <C-\><C-n>

" Autocommands
autocmd FileType html,scss,css,javascript,jsx EmmetInstall
autocmd FileType html,scss,css,javascript,jsx,typescriptreact setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType markdown setlocal spell wrap

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()
