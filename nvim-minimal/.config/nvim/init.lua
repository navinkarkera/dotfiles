require("impatient")
-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

-- Default options are not included
--- See: https://neovim.io/doc/user/vim_diff.html
--- [2] Defaults - *nvim-defaults*

-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
local cmd = vim.cmd -- Execute Vim commands
local g = vim.g -- Global variables
local opt = vim.opt -- Set options (global/buffer/windows-scoped)
--local fn = vim.fn       				    -- Call Vim functions
local api = vim.api

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = "a" -- Enable mouse support
opt.clipboard = "unnamed" -- Copy/paste to system clipboard
opt.swapfile = false -- Don't use swapfile
opt.completeopt = "menu" -- Autocomplete options
opt.complete = ".,w,b,u"
opt.backspace = "indent,eol,start"
opt.backup = false
opt.belloff = "all"

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true -- Show line number
opt.relativenumber = true -- show relativenumber
opt.showmatch = true -- Highlight matching parenthesis
opt.foldmethod = "marker" -- Enable folding (default 'foldmarker')
opt.colorcolumn = "80" -- Line lenght marker at 80 columns
opt.splitright = true -- Vertical split to the right
opt.splitbelow = true -- Orizontal split to the bottom
opt.ignorecase = true -- Ignore case letters when search
opt.smartcase = true -- Ignore lowercase for the whole pattern
opt.linebreak = true -- Wrap on word boundary
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.cmdheight = 1
opt.signcolumn = "yes"
opt.statusline = "%f  %y%m%r%h%w%=[%l,%v]      [%L,%p%%] %n"
opt.laststatus = 3

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 4 -- Shift 4 spaces when tab
opt.tabstop = 4 -- 1 tab == 4 spaces
opt.smartindent = true -- Autoindent new lines
opt.autoindent = true
opt.autoread = true

-----------------------------------------------------------
-- Undo options
-----------------------------------------------------------
opt.undodir = vim.env["HOME"] .. "/.local/share/vim/undodir"
opt.undofile = true

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true -- Enable background buffers
opt.history = 100 -- Remember N lines in history
opt.lazyredraw = true -- Faster scrolling
opt.synmaxcol = 240 -- Max column for syntax highlight
opt.updatetime = 50 -- ms to wait for trigger 'document_highlight'

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------

if vim.fn.executable("fd") == 1 then
	local fd_table = vim.fn.systemlist("fd -t d")
	opt.path = ".," .. table.concat(fd_table, ",")
else
	opt.path = ".,**"
end

if vim.fn.executable("rg") == 1 then
	opt.grepprg = [[rg --vimgrep --no-heading --smart-case --hidden -g '!.git/']]
	opt.grepformat = "%f:%l:%c:%m"
else
	opt.grepprg = "grep -R -n --exclude-dir=.git --exclude-dir=.cache --exclude-dir=node_modules --exclude-dir=.venv"
end

-- Disable nvim intro
opt.shortmess:append("sI")

-- Disable builtins plugins
local disabled_built_ins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit",
}

for _, plugin in pairs(disabled_built_ins) do
	g["loaded_" .. plugin] = 1
end

-----------------------------------------------------------
-- Autocommands
-----------------------------------------------------------
local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
local myGroup = api.nvim_create_augroup("MyGroup", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
	command = "silent! lua vim.highlight.on_yank()",
	group = yankGrp,
})
api.nvim_create_autocmd("FileType", {
	pattern = { "help", "startuptime", "qf", "lspinfo" },
	command = [[nnoremap <buffer><silent> q :close<CR>]],
	group = myGroup,
})
api.nvim_create_autocmd("BufWritePre", {
	command = [[:call TrimWhitespace()]],
	group = myGroup,
})
api.nvim_create_autocmd("BufEnter", {
	command = [[set fo-=c fo-=r fo-=o]],
	group = myGroup,
})
api.nvim_create_autocmd("FileType", {
	pattern = { "xml", "html", "xhtml", "css", "scss", "javascript", "yaml", "typescriptreact", "typescript" },
	command = [[setlocal shiftwidth=2 tabstop=2]],
	group = myGroup,
})
-- Remove whitespace on save
cmd([[
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

inoremap <silent> <C-l> <cmd>lua require('my-functions').expand_or_jump()<Cr>
inoremap <silent> <C-h> <cmd>lua require('my-functions').jump_prev()<Cr>

snoremap <silent> <C-l> <cmd>lua require('my-functions').expand_or_jump()<Cr>
snoremap <silent> <C-h> <cmd>lua require('my-functions').jump_prev()<Cr>
]])

-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Change leader to a comma
vim.g.mapleader = " "

map("n", "<leader>c", ":call ToggleQuickFix()<CR>")
map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<C-p>", ":find ")
map("n", "<C-b>", ":ls t<cr>:b ")
map("n", "<leader>ps", ':silent grep ""<Left>')
map("v", "<C-f>", '"hy:silent grep "<C-r>h"<CR>')
map("n", "<leader>pw", ':silent grep <C-R>=expand("<cword>")<CR><CR>')
map("n", "<leader>phw", ':h <C-R>=expand("<cword>")<CR><CR>')
map("n", "<C-j>", ":cn<cr>zz")
map("n", "<C-k>", ":cp<cr>zz")

map("v", "<C-r>", '"hy:%s/<C-r>h//gc<left><left><left>')
map("n", "<leader><cr>", ":so ~/.config/nvim/init.lua<CR>")
map("n", "<leader>+", ":vertical resize +15<CR>")
map("n", "<leader>-", ":vertical resize -10<CR>")
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "<F4>", ":bd<CR>")
map("n", "<C-s>", ":w<CR>")
map("i", "<C-s>", "<C-c>:w<CR>")
map("n", "<leader>n", ":e <C-r>=expand('%:h')<CR>/")

map("n", "<leader>gs", ":G<CR>")
map("n", "<leader>gps", ":G ps<CR>")
map("n", "<leader>gpl", ":G pl<CR>")
map("n", "<leader>gfu", ":G fu<CR>")
map("n", "<leader>gl", ":diffget //3<CR>")
map("n", "<leader>ga", ":diffget //2<CR>")

-- special remaps
map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "J", "mzJ`z")

map("x", ".", ":normal . <CR>", { noremap = true, silent = true })

-- undo breakpoints
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")
map("i", "[", "[<c-g>u")
map("i", "(", "(<c-g>u")

-- relative jumplist
map("n", "k", [[(v:count > 5 ? "m'". v:count : "") . "k"]], { expr = true, noremap = true, silent = true })
map("n", "j", [[(v:count > 5 ? "m'". v:count : "") . "j"]], { expr = true, noremap = true, silent = true })

map("n", "<m-p>", ':e <C-R>=expand("%:.:h")<CR>/')
map("n", "s", "ciw")
map("i", "kj", "<C-[>")
map("i", "<C-l>", "<C-x><C-l>")

map("t", "kj", "<C-\\><C-n>")


-- special commands
vim.api.nvim_create_user_command('LoadCommands', function()
    require("my-functions").load_commands()
end, {})

-- plugins setup
require("plugins")
