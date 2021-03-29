local utils = require('utils')

local cmd = vim.cmd
local indent = 4

cmd 'syntax enable'
cmd 'filetype plugin indent on'
cmd 'set iskeyword+=-'
cmd 'set shortmess+=c'
cmd 'set path+=**'
utils.opt('b', 'expandtab', true)
utils.opt('b', 'shiftwidth', indent)
utils.opt('b', 'smartindent', true)
utils.opt('b', 'tabstop', indent)
utils.opt('b', 'softtabstop', indent)

utils.opt('w', 'number', true)
utils.opt('w', 'wrap', false)
utils.opt('w', 'relativenumber', true)
utils.opt('w', 'colorcolumn', '100')
utils.opt('w', 'signcolumn', 'yes')
cmd 'highlight ColorColumn ctermbg=0 guibg=lightgrey'

utils.opt('o', 'hidden', true)
utils.opt('o', 'ignorecase', true)
utils.opt('o', 'scrolloff', 6)
utils.opt('o', 'shiftround', true)
utils.opt('o', 'smartcase', true)
utils.opt('o', 'splitbelow', true)
utils.opt('o', 'splitright', true)
utils.opt('o', 'wildmenu', true)
utils.opt('o', 'wildmode', 'longest:full,full')
utils.opt('o', 'clipboard','unnamed,unnamedplus')
utils.opt('o', 'inccommand','nosplit')
utils.opt('o', 'fileencoding','utf-8')
utils.opt('o', 'cmdheight', 2)
utils.opt('o', 'mouse', 'a')
utils.opt('o', 'showmode', false)
utils.opt('o', 'hlsearch', false)
utils.opt('o', 'undodir', '~/.vim/undodir')
utils.opt('o', 'undofile', true)
utils.opt('o', 'incsearch', true)
utils.opt('o', 'termguicolors', true)
utils.opt('o', 'updatetime', 50)

-- Highlight on yank
utils.create_augroup({
    'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}',
    'autocmd FileType html,scss,css,javascript,jsx EmmetInstall',
    'autocmd FileType html,scss,css,javascript,jsx,typescriptreact setlocal tabstop=2 shiftwidth=2 expandtab',
    'autocmd FileType markdown setlocal spell wrap',
    'autocmd BufWritePre * :call TrimWhitespace()',
    "autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}",
    "autocmd BufWritePre *.py execute ':Black'"
}, 'NORA_CMDS')
