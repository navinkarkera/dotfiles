local o = vim.o
local wo = vim.wo
local bo = vim.bo
local cmd = vim.cmd
local g = vim.g
M = {}
local map = vim.api.nvim_set_keymap

cmd([[
filetype plugin indent on
syntax enable
highlight ColorColumn ctermbg=0 guibg=grey
]])

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
o.path = o.path .. ',**'
o.wildmenu = true
o.wildmode = "longest:full,full"
o.wildignore = '*.o,*.a,__pycache__,node_modules'
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
o.completeopt = "menuone,noinsert,noselect"
o.complete = ".,w,b,u,i"
o.virtualedit = "block"
o.backspace = "indent,eol,start"

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
    o.grepprg = "grep -R -n --exclude-dir=.git,.cache,node_modules"
end

-- autocmds

function M.create_augroup(autocmds, name)
    cmd('augroup ' .. name)
    cmd('autocmd!')
    for _, autocmd in ipairs(autocmds) do
        cmd('autocmd ' .. table.concat(autocmd, ' '))
    end
    cmd('augroup END')
end

M.create_augroup({
    { 'BufRead,BufNewFile', '/tmp/nail-*', 'setlocal', 'ft=mail' },
    { 'BufRead,BufNewFile', '*s-nail-*', 'setlocal', 'ft=mail' },
}, 'ftmail')

M.create_augroup({
    { 'FileType', 'html,htmldjango,scss,css,javascript,jsx,typescriptreact,vue', 'setlocal', 'tabstop=2 shiftwidth=2 expandtab' },
    { 'FileType', 'markdown', 'setlocal', 'spell wrap' },

    { 'TextYankPost', '*', 'silent!', "lua require'vim.highlight'.on_yank({timeout = 40})" },
    { 'BufEnter,BufWinEnter,TabEnter', '*.rs', ":lua require'lsp_extensions'.inlay_hints{}" },
    { 'BufWritePre', '*.py', 'execute', ':Black' },
-- Run xrdb whenever Xdefaults or Xresources are updated.
    { 'BufWritePost', 'bm-files,bm-dirs', '!shortcuts' },
    { 'BufRead,BufNewFile', 'Xresources,Xdefaults,xresources,xdefaults', 'set', 'filetype=xdefaults' },
    { 'BufWritePost', 'Xresources,Xdefaults,xresources,xdefaults', '!xrdb %' },
    { 'BufWritePost', '~/.local/src/dwmblocks/config.h', '!cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }' },
    { 'VimEnter', '*', 'if argc() == 0 | Explore! | endif' }
}, 'NORA')


local options = { noremap = true }

map('v', '<', '<gv', options)
map('v', '>', '>gv', options)

map('n', '<C-p>', ':find ', options)
map('n', '<leader>ps', ':grep ""<Left>', options)
map('n', '<C-j>', ':cn<cr>', options)
map('n', '<C-k>', ':cp<cr>', options)
map('n', '<leader>co', ':copen<cr>', options)
map('n', '<leader>cc', ':cclose<cr>', options)

map('v', '<C-r>', '"hy:%s/<C-r>h//gc<left><left><left>', options)
map('n', '<C-l>', ':bnext<cr>', options)
map('n', '<C-h>', ':bprevious<cr>', options)
map('n', '<leader>h', ':wincmd h<cr>', options)
map('n', '<leader>j', ':wincmd j<cr>', options)
map('n', '<leader>k', ':wincmd k<cr>', options)
map('n', '<leader>l', ':wincmd l<cr>', options)
map('n', '<leader>u', ':UndotreeToggle<cr>', options)
map('n', 'gQ', ':<C-U>call my_utils#FormatFile()<CR>', options)
map('n', '<leader>pv', ':Explore<cr>', options)
map('n', '<leader><cr>', ':so ~/.config/nvim/init.lua<CR>', options)
map('n', '<leader>+', ':vertical resize +15<CR>', options)
map('n', '<leader>-', ':vertical resize -10<CR>', options)
map('v', 'J', ":m '>+1<CR>gv=gv", options)
map('v', 'K', ":m '<-2<CR>gv=gv", options)
map('n', '<F28>', ":bd<CR>", options)
map('n', '<C-s>', ":w<CR>", options)

map('n', '<leader>gs' , ':G<CR>', options)
map('n', '<leader>gps', ':G ps<CR>', options)
map('n', '<leader>gpl', ':G pl<CR>', options)
map('n', '<leader>gfu', ':G fu<CR>', options)
map('n', '<leader>gl', ':diffget //3<CR>', options)
map('n', '<leader>ga', ':diffget //2<CR>', options)

map('t', '<F1>', '<C-\\><C-n>', options)


-- plugins setup
require("plugins")
require("treesitter-config")
require("completion-conf")

cmd("colorscheme tender")
require("statusline")
require 'colorizer'.setup()
