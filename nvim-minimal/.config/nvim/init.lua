local o = vim.o
local wo = vim.wo
local bo = vim.bo
local cmd = vim.cmd
local g = vim.g
M = {}
local map = vim.api.nvim_set_keymap

-- disable unused inbuild plugins
g.loaded_matchparen        = true
g.loaded_matchit           = true
g.loaded_logiPat           = true
g.loaded_rrhelper          = true
g.loaded_tarPlugin         = true
g.loaded_gzip              = true
g.loaded_zipPlugin         = true
g.loaded_2html_plugin      = true
g.loaded_shada_plugin      = true
g.loaded_spellfile_plugin  = true
g.loaded_netrw             = true
g.loaded_netrwPlugin       = true
g.loaded_tutor_mode_plugin = true
g.loaded_remote_plugins    = true
g.loaded_fzf               = true
g.loaded_lf                = true
-- g.loaded_man               = true

-- global options
o.swapfile = false
o.backup = false
o.undodir = vim.env["HOME"] .. '/.local/share/vim/undodir'
o.undofile = true
o.dir = '/tmp'
o.smartcase = true
o.laststatus = 2
o.hlsearch = false
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.scrolloff = 4
o.mouse = 'a'
o.hidden = true
o.errorbells = false
o.termguicolors = true
o.path = '.,**'
o.wildmenu = true
o.wildmode = "longest:full,full"
o.wildignore = '*.o,*.a,*.pyc,__pycache__,node_modules'
o.showmode = false
o.inccommand = "nosplit"
o.clipboard = "unnamed,unnamedplus"
o.cmdheight = 2
o.updatetime = 50
o.shortmess = o.shortmess .. 'c'
o.autoread = true
o.splitright = true
o.splitbelow = true
o.belloff = "all"
o.showmode = false
o.concealcursor = "nc"
o.completeopt = "menu"
o.complete = ".,w,b,u,i"
o.virtualedit = "block"
o.backspace = "indent,eol,start"
o.lazyredraw = true
o.synmaxcol = 200
o.switchbuf = "usetab"

-- window-local options
wo.number = true
wo.relativenumber = true
wo.wrap = false
wo.colorcolumn = '100'
wo.signcolumn = "number"

-- buffer-local options
o.expandtab = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.smartindent = true
o.autoindent = true
o.matchpairs = o.matchpairs .. ',<:>'
o.cursorline = true

g.netrw_banner = 0
g.netrw_liststyle = 0
g.netrw_list_hide= '.git'
g.black_virtualenv = vim.env["HOME"] .. '/.local/pipx/venvs/black'
g.python3_host_prog = "/usr/bin/python"

-- map the leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ' '  -- 'vim.g' sets global variables


if vim.fn.executable('rg') == 1 then
    o.grepprg = 'rg --vimgrep --no-heading --smart-case'
    o.grepformat = "%f:%l:%c:%m"
else
    o.grepprg = "grep -R -n --exclude-dir=.git --exclude-dir=.cache --exclude-dir=node_modules --exclude-dir=.venv"
end


local options = { noremap = true }

map('v', '<', '<gv', options)
map('v', '>', '>gv', options)

map('n', '<C-p>', ':find ', options)
map('n', '<C-b>', ':ls t<cr>:b ', options)
map('n', '<leader>ps', ':silent grep ""<Left>', options)
map('v', '<C-f>', '"hy:silent grep "<C-r>h"<CR>', options)
map('n', '<leader>pw', ':silent grep <C-R>=expand("<cword>")<CR><CR>', options)
map('n', '<leader>phw', ':h <C-R>=expand("<cword>")<CR><CR>', options)
map('n', '<C-j>', ':cn<cr>zz', options)
map('n', '<C-k>', ':cp<cr>zz', options)

map('v', '<C-r>', '"hy:%s/<C-r>h//gc<left><left><left>', options)
map('n', '<C-l>', ':bnext<cr>', options)
map('n', '<C-h>', ':bprevious<cr>', options)
map('n', '<leader>h', ':wincmd h<cr>', options)
map('n', '<leader>j', ':wincmd j<cr>', options)
map('n', '<leader>k', ':wincmd k<cr>', options)
map('n', '<leader>l', ':wincmd l<cr>', options)
map('n', '<leader>u', ':UndotreeToggle<cr>', options)
map('n', '<leader><cr>', ':so ~/.config/nvim/init.lua<CR>', options)
map('n', '<leader>+', ':vertical resize +15<CR>', options)
map('n', '<leader>-', ':vertical resize -10<CR>', options)
map('v', 'J', ":m '>+1<CR>gv=gv", options)
map('v', 'K', ":m '<-2<CR>gv=gv", options)
map('n', '<F4>', ":bd<CR>", options)
map('n', '<C-s>', ":w<CR>", options)

map('n', '<leader>gs' , ':G<CR>', options)
map('n', '<leader>gps', ':G ps<CR>', options)
map('n', '<leader>gpl', ':G pl<CR>', options)
map('n', '<leader>gfu', ':G fu<CR>', options)
map('n', '<leader>gl', ':diffget //3<CR>', options)
map('n', '<leader>ga', ':diffget //2<CR>', options)
map('n', '<leader>pv' , ':NvimTreeToggle<CR>', options)

-- special remaps
map('n', 'n', 'nzz', options)
map('n', 'N', 'Nzz', options)
map('n', 'J', 'mzJ`z', options)

map('n', 'Y', 'y$', options)
map('x', 'Y', 'y$', options)

-- undo breakpoints
map('i', ',', ',<c-g>u', options)
map('i', '.', '.<c-g>u', options)
map('i', '!', '!<c-g>u', options)
map('i', '?', '?<c-g>u', options)
map('i', '[', '[<c-g>u', options)
map('i', '(', '(<c-g>u', options)

-- relative jumplist
map('n', 'k', [[(v:count > 5 ? "m'". v:count : "") . "k"]], { expr = true, noremap = true, silent = true })
map('n', 'j', [[(v:count > 5 ? "m'". v:count : "") . "j"]], { expr = true, noremap = true, silent = true })

map('n', '<m-p>', ':e <C-R>=expand("%:.:h")<CR>/', options)
map('n', 's', 'ciw', options)
map('i', 'kj', '<C-[>', options)

map('t', 'kj', '<C-\\><C-n>', options)


-- plugins setup
require("plugins")
