local o = vim.o
local wo = vim.wo
local bo = vim.bo
local cmd = vim.cmd
local g = vim.g
M = {}
local map = vim.api.nvim_set_keymap

-- disable unused inbuild plugins
g.loaded_matchparen = true
g.loaded_matchit = true
g.loaded_logiPat = true
g.loaded_rrhelper = true
g.loaded_tarPlugin = true
g.loaded_gzip = true
g.loaded_zipPlugin = true
g.loaded_2html_plugin = true
g.loaded_shada_plugin = true
g.loaded_spellfile_plugin = true
g.loaded_netrw = true
g.loaded_netrwPlugin = true
g.loaded_netrwSettings = true
g.loaded_netrwFileHandlers = true
g.loaded_tutor_mode_plugin = true
g.loaded_remote_plugins = true
g.loaded_fzf = true
g.loaded_lf = true
-- g.loaded_man               = true

-- global options
o.autoindent = true
o.autoread = true
o.backspace = "indent,eol,start"
o.backup = false
o.belloff = "all"
o.clipboard = "unnamed,unnamedplus"
o.cmdheight = 1
o.complete = ".,w,b,u,i"
o.completeopt = "menu"
o.concealcursor = "nc"
o.cursorline = true
o.dir = "/tmp"
o.errorbells = false
o.expandtab = true
o.hidden = true
o.hlsearch = false
o.ignorecase = true
o.inccommand = "nosplit"
o.incsearch = true
o.laststatus = 2
o.lazyredraw = true
o.matchpairs = o.matchpairs .. ",<:>"
o.mouse = "a"
o.path = ".,**"
o.pumheight = 20
o.scrolloff = 4
o.shiftwidth = 4
o.shortmess = o.shortmess .. "c"
o.showmode = false
o.showmode = false
o.smartcase = true
o.smartcase = true
o.smartindent = true
o.softtabstop = 4
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.switchbuf = "usetab"
o.synmaxcol = 200
o.tabstop = 4
o.termguicolors = true
o.undodir = vim.env["HOME"] .. "/.local/share/vim/undodir"
o.undofile = true
o.updatetime = 50
o.virtualedit = "block"
o.wildignore = "*.o,*.a,*.pyc,__pycache__,node_modules"
o.wildmenu = true
o.wildmode = "longest:full,full"
o.statusline = "%f  %y%m%r%h%w%=[%l,%v]      [%L,%p%%] %n"
o.background = "light"

-- window-local options
wo.colorcolumn = "100"
wo.number = true
wo.relativenumber = true
wo.signcolumn = "number"
wo.wrap = false

g.netrw_banner = 0
g.netrw_liststyle = 0
g.netrw_list_hide = ".git"
g.black_virtualenv = vim.env["HOME"] .. "/.local/pipx/venvs/black"
g.python3_host_prog = "/usr/bin/python"
g.VimuxExpandCommand = 1
g.VimuxHeight = 40

-- map the leader key
map("n", "<Space>", "", {})
vim.g.mapleader = " " -- 'vim.g' sets global variables

if vim.fn.executable("rg") == 1 then
	o.grepprg = [[rg --vimgrep --no-heading --smart-case --hidden -g '!.git/']]
	o.grepformat = "%f:%l:%c:%m"
else
	o.grepprg = "grep -R -n --exclude-dir=.git --exclude-dir=.cache --exclude-dir=node_modules --exclude-dir=.venv"
end

local options = { noremap = true }

map("v", "<", "<gv", options)
map("v", ">", ">gv", options)

map("n", "<C-p>", ":find ", options)
map("n", "<C-b>", ":ls t<cr>:b ", options)
map("n", "<leader>ps", ':silent grep ""<Left>', options)
map("v", "<C-f>", '"hy:silent grep "<C-r>h"<CR>', options)
map("n", "<leader>pw", ':silent grep <C-R>=expand("<cword>")<CR><CR>', options)
map("n", "<leader>phw", ':h <C-R>=expand("<cword>")<CR><CR>', options)
map("n", "<C-j>", ":cn<cr>zz", options)
map("n", "<C-k>", ":cp<cr>zz", options)

map("v", "<C-r>", '"hy:%s/<C-r>h//gc<left><left><left>', options)
map("n", "<C-l>", ":bnext<cr>", options)
map("n", "<C-h>", ":bprevious<cr>", options)
map("n", "<leader><cr>", ":so ~/.config/nvim/init.lua<CR>", options)
map("n", "<leader>+", ":vertical resize +15<CR>", options)
map("n", "<leader>-", ":vertical resize -10<CR>", options)
map("v", "J", ":m '>+1<CR>gv=gv", options)
map("v", "K", ":m '<-2<CR>gv=gv", options)
map("n", "<F4>", ":bd<CR>", options)
map("n", "<C-s>", ":w<CR>", options)
map("n", "<leader>n", ":e <C-r>=expand('%:h')<CR>/", options)

map("n", "<leader>gs", ":G<CR>", options)
map("n", "<leader>gps", ":G ps<CR>", options)
map("n", "<leader>gpl", ":G pl<CR>", options)
map("n", "<leader>gfu", ":G fu<CR>", options)
map("n", "<leader>gl", ":diffget //3<CR>", options)
map("n", "<leader>ga", ":diffget //2<CR>", options)

-- special remaps
map("n", "n", "nzz", options)
map("n", "N", "Nzz", options)
map("n", "J", "mzJ`z", options)

map("n", "Y", "y$", options)
map("x", "Y", "y$", options)

-- undo breakpoints
map("i", ",", ",<c-g>u", options)
map("i", ".", ".<c-g>u", options)
map("i", "!", "!<c-g>u", options)
map("i", "?", "?<c-g>u", options)
map("i", "[", "[<c-g>u", options)
map("i", "(", "(<c-g>u", options)

-- relative jumplist
map("n", "k", [[(v:count > 5 ? "m'". v:count : "") . "k"]], { expr = true, noremap = true, silent = true })
map("n", "j", [[(v:count > 5 ? "m'". v:count : "") . "j"]], { expr = true, noremap = true, silent = true })

map("n", "<m-p>", ':e <C-R>=expand("%:.:h")<CR>/', options)
map("n", "s", "ciw", options)
map("i", "kj", "<C-[>", options)
map("i", "<C-l>", "<C-x><C-l>", options)

map("t", "kj", "<C-\\><C-n>", options)

-- mark maps
map("n", "<leader>1", "`Q", options)
map("n", "<leader>2", "`W", options)
map("n", "<leader>3", "`E", options)
map("n", "<leader>4", "`R", options)
map("n", ",1", "mQ", options)
map("n", ",2", "mW", options)
map("n", ",3", "mE", options)
map("n", ",4", "mR", options)

-- plugins setup
require("plugins")
cmd("colorscheme paper")
