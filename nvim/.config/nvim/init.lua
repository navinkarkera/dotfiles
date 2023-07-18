-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
local map = vim.keymap.set

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)


local builtins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for _, plugin in pairs(builtins) do
  vim.g["loaded_" .. plugin] = 1
end

require('lazy').setup {
  'numToStr/Comment.nvim',
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  'ellisonleao/gruvbox.nvim',
  'nvim-lualine/lualine.nvim',
  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    }
  },
  { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    build = ":TSUpdate",
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim',       opts = {}, tag = "legacy" },
      'folke/neodev.nvim',
    },
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp-signature-help' },
  },
  "rafamadriz/friendly-snippets",
  "honza/vim-snippets",
  "windwp/nvim-ts-autotag",
  "numToStr/Navigator.nvim",
  "ThePrimeagen/harpoon",
  "danymat/neogen",
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
  },
  {
    'ckolkey/ts-node-action',
    dependencies = { 'nvim-treesitter' },
  },
  "kylechui/nvim-surround",
  { 'sindrets/diffview.nvim',  dependencies = 'nvim-lua/plenary.nvim' },
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons"
  },
  { "pechorin/any-jump.vim" },
  { "stevearc/oil.nvim" },
  { import = 'custom.plugins' },
}

--Set highlight on search
vim.o.hlsearch = false
vim.o.swapfile = false

--tab configurations
vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4

--Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set colorscheme
vim.o.background = "light"
vim.o.termguicolors = true
vim.o.cursorline = false

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu'
vim.o.complete = '.,w,b'

-- window direction
vim.o.splitright = true
vim.o.splitbelow = true

require('gruvbox').setup({
  transparent_mode = true,
  dim_inactive = false,
  italic = {
    strings = true,
    comments = true,
    operators = false,
    folds = false,
  },
})
vim.cmd [[colorscheme gruvbox]]

if vim.fn.executable("rg") == 1 then
  vim.o.grepprg = [[rg --vimgrep --no-heading --smart-case --hidden -g '!.git/']]
  vim.o.grepformat = "%f:%l:%c:%m"
else
  vim.o.grepprg = "grep -R -n --exclude-dir=.git --exclude-dir=.cache --exclude-dir=node_modules --exclude-dir=.venv"
end

--Set statusbar
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    component_separators = '|',
    section_separators = '',
    globalstatus = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'vim.fn.fnamemodify(vim.fn.getcwd(), ":t")', 'branch' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  winbar = {
    lualine_a = { { 'filename', path = 1 } },
    lualine_b = { 'diff', 'diagnostics', 'nvim_treesitter#statusline' },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_winbar = {
    lualine_a = { { 'filename', path = 1 } },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  }
}

--Remap space as leader key
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Enable Comment.nvim
require('Comment').setup()

-- Anyjump config
vim.g.any_jump_grouping_enabled                     = 1
vim.g.any_jump_preview_lines_count                  = 10
vim.g.any_jump_references_only_for_current_filetype = 1
vim.g.any_jump_window_width_ratio                   = 0.8
vim.g.any_jump_window_height_ratio                  = 0.8
vim.g.any_jump_window_top_offset                    = 5

--Enable trouble.nvim
require("trouble").setup({
  auto_preview = false,
})
map("n", "<C-q>", "<cmd>TroubleToggle<cr>",
  { silent = true, noremap = true }
)
map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  { silent = true, noremap = true }
)
map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  { silent = true, noremap = true }
)
map("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
  { silent = true, noremap = true }
)
map("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  { silent = true, noremap = true }
)
map("n", "<C-j>", function() require("trouble").next({ skip_groups = true, jump = true }); end,
  { silent = true, noremap = true }
)
map("n", "<C-k>", function() require("trouble").previous({ skip_groups = true, jump = true }); end,
  { silent = true, noremap = true }
)

--python
vim.g.python3_host_prog = '/usr/bin/python3'

--Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Vim functions
vim.cmd([[
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
" Zoom / Restore window.
function! s:ZoomToggle() abort
  if exists('t:zoomed') && t:zoomed
    execute t:zoom_winrestcmd
    let t:zoomed = 0
  else
    let t:zoom_winrestcmd = winrestcmd()
    resize
    vertical resize
    let t:zoomed = 1
  endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <M-a> :ZoomToggle<CR>
]])


-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Autocommands
local my_group = vim.api.nvim_create_augroup('my_group', { clear = true })
local api = vim.api
api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = my_group,
  pattern = '*',
})

api.nvim_create_autocmd("FileType", {
  pattern = { "help", "startuptime", "qf", "lspinfo" },
  command = [[nnoremap <buffer><silent> q :close<CR>]],
  group = my_group,
})
api.nvim_create_autocmd("BufWritePre", {
  command = [[:call TrimWhitespace()]],
  group = my_group,
})
api.nvim_create_autocmd("BufEnter", {
  command = [[set fo-=c fo-=r fo-=o]],
  group = my_group,
})
api.nvim_create_autocmd("FileType", {
  pattern = { "xml", "html", "htmldjango", "xhtml", "css", "scss", "javascript", "javascriptreact", "yaml",
    "typescriptreact", "typescript", "json", "lua" },
  command = [[setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab]],
  group = my_group,
})
api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  command = [[set autowriteall]],
  group = my_group,
})
api.nvim_create_autocmd("TermOpen", {
  command = [[
setlocal nonumber norelativenumber signcolumn=no
]],
  group = my_group,
})

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function gmap(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      map(mode, l, r, opts)
    end

    -- Navigation
    gmap('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    gmap('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    -- Actions
    gmap('n', '<leader>hR', gs.reset_hunk)
    gmap('n', '<leader>hp', gs.preview_hunk)
    gmap('n', '<leader>hb', function() gs.blame_line { full = true } end)
    gmap('n', '<leader>tb', gs.toggle_current_line_blame)
    gmap('n', '<leader>hd', gs.diffthis)
    gmap('n', '<leader>hD', function() gs.diffthis('~') end)
    gmap('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

-- oil.nvim
require('oil').setup()
map('n', '<leader>to', require('oil').open)

local fzf_lua = require("fzf-lua")
fzf_lua.setup({
  'fzf-native',
  winopts = {
    preview = { default = "bat" },
    height = 0.90, -- window height
    width = 0.90,
  },
})
fzf_lua.register_ui_select()

local my_functions = require('my-functions')
--Add leader shortcuts
map('n', '<leader><space>', fzf_lua.buffers)
map('n', '<leader>ff', fzf_lua.git_files)
map('n', '<leader>fb', fzf_lua.git_bcommits)
map('n', '<leader>fh', fzf_lua.help_tags)
map('n', '<leader>fg', fzf_lua.git_status)
map('n', '<leader>fl', fzf_lua.resume)
map('n', '<leader>fq', fzf_lua.quickfix)
map('n', '<leader>fs', fzf_lua.lsp_document_symbols)
map('n', '<leader>fj', fzf_lua.jumps)
map('n', '<leader>fws', fzf_lua.lsp_live_workspace_symbols)
map('n', '<C-]>', function() fzf_lua.command_history({ fzf_opts = { ["--tiebreak"] = "index", ["--query"] = "Run " } }) end)
map('n', '<leader>?', fzf_lua.oldfiles)
map('n', '<C-f>', fzf_lua.live_grep_glob)
map("v", "<C-f>", fzf_lua.grep_visual)
map("n", "<leader>pw", fzf_lua.grep_cword)
map("n", "<leader>tt", my_functions.fzf_get_terminals)
map(
  { "n", "v", "i" },
  "<C-x><C-f>",
  fzf_lua.complete_path,
  { silent = true, desc = "Fuzzy complete path" }
)

vim.api.nvim_create_user_command(
  'ListFilesFromBranch',
  function(opts)
    require 'fzf-lua'.files({
      cmd = "git diff -r --name-only " .. opts.args,
      prompt = opts.args .. "> ",
      previewer = false,
      preview = require 'fzf-lua'.shell.raw_preview_action_cmd(function(items)
        local file = require 'fzf-lua'.path.entry_to_file(items[1])
        return string.format("git diff %s HEAD -- %s | delta", opts.args, file.path)
      end)
    })
  end,
  {
    nargs = 1,
    force = true,
    complete = function()
      local branches = vim.fn.systemlist("git branch --all --sort=-committerdate")
      if vim.v.shell_error == 0 then
        return vim.tbl_map(function(x)
          return x:match("[^%s%*]+"):gsub("^remotes/", "")
        end, branches)
      end
    end,
  })

local base_branch = os.getenv("GIT_PARENT_BRANCH") or "master"
map('n', '<leader>fc', ":ListFilesFromBranch " .. base_branch .. "<CR>")

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "html",
    "css",
    "typescript",
    "javascript",
    "tsx",
    "python",
    "lua",
    "vim",
    "bash",
    "json",
    "org",
    "markdown",
    "markdown_inline",
  },
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  indent = { enable = true },
  autotag = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- Diagnostic keymaps
map('n', '<leader>e', vim.diagnostic.open_float)
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)
map('n', '<leader>q', vim.diagnostic.setloclist)

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = false,
})

-- LSP settings
local function peekOrHover()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if winid then
    local bufnr = vim.api.nvim_win_get_buf(winid)
    local keys = { 'a', 'i', 'o', 'A', 'I', 'O', 'gd', 'gr' }
    for _, k in ipairs(keys) do
      -- Add a prefix key to fire `trace` action,
      -- if Neovim is 0.8.0 before, remap yourself
      vim.keymap.set('n', k, '<CR>' .. k, { noremap = false, buffer = bufnr })
    end
  else
    -- nvimlsp
    vim.lsp.buf.hover()
  end
end

local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr }
  map('n', 'gD', function()
    fzf_lua.lsp_definitions({
      sync = true,
      jump_to_single_result = true,
      jump_to_single_result_action = fzf_lua.actions.file_vsplit,
    })
  end, opts)
  map('n', 'gd', vim.lsp.buf.definition, opts)
  map('n', 'K', peekOrHover, opts)
  map('n', 'gi', vim.lsp.buf.implementation, opts)
  map('n', '<leader>si', vim.lsp.buf.signature_help, opts)
  map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  map('n', '<leader>wl', function()
    vim.inspect(vim.lsp.buf.list_workspace_folders())
  end, opts)
  map('n', '<leader>D', vim.lsp.buf.type_definition, opts)
  map('n', '<leader>rn', vim.lsp.buf.rename, opts)
  map('n', 'gr', "<cmd>TroubleToggle lsp_references<cr>", opts)
  map('n', 'gR', fzf_lua.lsp_references, opts)
  map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  map('n', '<leader>so', fzf_lua.lsp_document_symbols, opts)
  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    -- Use a sharp border with `FloatBorder` highlights
    border = "single",
  }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    -- Use a sharp border with `FloatBorder` highlights
    border = "single"
  }
)
-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

-- Enable the following language servers
local servers = {
  pyright = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
  tsserver = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
  cssls = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
  eslint = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
  html = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
  marksman = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
  ruff_lsp = {
    on_attach = on_attach,
    capabilities = capabilities,
    autostart = false
  },
  gopls = {
    on_attach = on_attach,
    capabilities = capabilities,
    autostart = false,
    settings = {
      gopls = {
        experimentalPostfixCompletions = true,
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        staticcheck = true,
      },
    },
    init_options = {
      usePlaceholders = true,
    }
  },
  lua_ls = {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      }
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup(servers[server_name])
  end,
}
-- luasnip setup
local luasnip = require 'luasnip'
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()
luasnip.filetype_extend("python", { "django" })

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- nvim-cmp setup
local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    autocomplete = false,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete({}),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<C-l>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-h>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, true, true), "n", true)
      elseif cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, true, true), "n", true)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n", true)
      elseif cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'neorg' }
  },
  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- Source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
      })[entry.source.name]
      return vim_item
    end
  },
}

-- harpoon
require("harpoon").setup({
  global_settings = {
    save_on_toggle = false,
    save_on_change = true,
    enter_on_sendcmd = true,
    tmux_autoclose_windows = false,
    excluded_filetypes = { "harpoon", "qf" },
  },
})

map("n", "<leader>ma", require('harpoon.mark').add_file)
map("n", "<leader>mm", require('harpoon.ui').toggle_quick_menu)

-- mark maps
map("n", "<leader>1", function() require('harpoon.ui').nav_file(1) end)
map("n", "<leader>2", function() require('harpoon.ui').nav_file(2) end)
map("n", "<leader>3", function() require('harpoon.ui').nav_file(3) end)
map("n", "<leader>4", function() require('harpoon.ui').nav_file(4) end)
map("n", "<leader>5", function() require('harpoon.ui').nav_file(5) end)
map("n", "<leader>6", function() require('harpoon.ui').nav_file(6) end)
map("n", "<leader>mc", require('harpoon.cmd-ui').toggle_quick_menu)
map("n", [[<M-\>]],
  [[<cmd>botright split | lua require('harpoon.term').gotoTerminal(require('my-functions').count_or_one())<CR>]])
map("n", [[<M-e>]],
  [[<cmd>lua require('harpoon.term').sendCommand(require('my-functions').count_or_one(), require('my-functions').count_or_one())<CR>]])
map("v", [[<M-e>]],
  [["vy<cmd>lua require('harpoon.term').sendCommand(require('my-functions').count_or_one(), vim.fn.getreg("v"))<CR> ]])
map("n", ",l", [[<cmd>lua require('harpoon.term').sendCommand(require('my-functions').count_or_one(), '!!')<CR>]])
map("n", "<M-space>", my_functions.execute_from_harpoon)

-- Navigator
local Navigator = require("Navigator")
Navigator.setup({})
map("n", "<m-h>", Navigator.left)
map("n", "<m-k>", Navigator.up)
map("n", "<m-l>", Navigator.right)
map("n", "<m-j>", Navigator.down)
map("n", "<m-^>", Navigator.previous)
-- terminal keymaps
map("t", "<m-h>", Navigator.left)
map("t", "<m-k>", Navigator.up)
map("t", "<m-l>", Navigator.right)
map("t", "<m-j>", Navigator.down)
map("t", "<m-^>", Navigator.previous)


-- refactoring.nvim
require("refactoring").setup {
  -- overriding printf statement for python
  print_var_statements = {
    python = {
      'print(f"""======================================= %s {%s}""")',
    },
  },
}
-- prompt for a refactor to apply when the remap is triggered
map(
  "v",
  "<leader>rr",
  ":lua require('refactoring').select_refactor()<CR>",
  { noremap = true, silent = true, expr = false }
)
-- You can also use below = true here to to change the position of the printf
-- statement (or set two remaps for either one). This remap must be made in normal mode.
map(
  "n",
  "<leader>rp",
  function()
    require('refactoring').debug.printf({ below = false })
  end
)


-- Remap in normal mode and passing { normal = true } will automatically find the variable under the cursor and print it
map(
  "n",
  "<leader>rv",
  ":lua require('refactoring').debug.print_var({ normal = true })<CR>",
  { noremap = true }
)

-- Print var: this remap should be made in visual mode
map(
  "v",
  "<leader>rv",
  ":lua require('refactoring').debug.print_var({})<CR>",
  { noremap = true }
)

-- Cleanup function: this remap should be made in normal mode
map(
  "n",
  "<leader>rc",
  function()
    require('refactoring').debug.cleanup({})
  end
)

-- neogen conf
require("neogen").setup({})
map("n", "<Leader>nf", require('neogen').generate)

local function git_files_cwd_aware(opts)
  opts = opts or {}
  -- git_root() will warn us if we're not inside a git repo
  -- so we don't have to add another warning here, if
  -- you want to avoid the error message change it to:
  -- local git_root = fzf_lua.path.git_root(opts, true)
  local git_root = fzf_lua.path.git_root(opts)
  if not git_root then return end
  local relative = fzf_lua.path.relative(vim.loop.cwd(), git_root)
  opts.fzf_opts = { ['--query'] = git_root ~= relative and relative or nil }
  return fzf_lua.git_files(opts)
end
map('n', '<leader>pv', function() git_files_cwd_aware({ cwd = "%:h" }) end)
map('n', '<C-p>', fzf_lua.files)

-- ts-node-action
require('ts-node-action').setup({})
map({ "n" }, "gS", require("ts-node-action").node_action, { desc = "Trigger Node Action" })

-- nvim-surround
require("nvim-surround").setup({})

-- terminal setup
vim.api.nvim_create_user_command("Run", function(opts) my_functions.run_command(opts.args, false, false) end,
  { nargs = 1, complete = "shellcmd" })
vim.api.nvim_create_user_command("RunB", function(opts) my_functions.run_command(opts.args, false, true) end,
  { nargs = 1, complete = "shellcmd" })
vim.api.nvim_create_user_command("RunF", function(opts) my_functions.run_command(opts.args, true, false) end,
  { nargs = 1, complete = "shellcmd" })
vim.api.nvim_create_user_command("RunFB", function(opts) my_functions.run_command(opts.args, true, true) end,
  { nargs = 1, complete = "shellcmd" })
map("n", "<M-CR>", ":Run ")
map("v", "<M-CR>", [["vy:Run <C-R>v]])
map("n", "<M-BS>", ":RunB ")
map("v", "<M-BS>", [["vy:RunB <C-R>v]])

map("n", "<M-'>", ":RunF ")
map("v", "<M-'>", [["vy:RunF <C-R>v]])
map("n", "<M-[>", ":RunFB ")
map("v", "<M-[>", [["vy:RunFB <C-R>v]])
map("n", "<F2>", ":Run<Up><CR>")
map("n", "<F3>", my_functions.restart_cmd)
map("n", "<leader>mt", my_functions.fzf_make_tasks)

vim.api.nvim_create_user_command("Grep", "silent grep! <q-args> | TroubleToggle quickfix", { nargs = 1 })
vim.api.nvim_create_user_command(
  "GBrowse",
  [[:silent !git browse "" %:~:. <line1> <line2>]],
  { nargs = 0, range = true }
)
-- custom keymaps
map("n", "<F4>", ":bd<CR>")
map('n', '<C-s>', ":w<CR>")
map("i", "<C-s>", "<C-c>:w<CR>")
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("v", "<", "<gv")
map("v", ">", ">gv")
map("n", "s", "ciw")
map("n", "<m-p>", ':e <C-R>=expand("%:.:h")<CR>/')
map("n", "]p", [[/\(\/[^\\]\+\)\+\(\.\w\+\)\?<CR>]])
map("v", "<C-r>", '"hy:%s/<C-r>h//gc<left><left><left>')
map("v", "cy", '"+y')
map("n", "cp", '"+p')
map("n", "<leader>cp", ':silent !echo %:~:. | xsel --clipboard<CR>')
map("v", "<leader>prs", [[:w !curl --data-binary @- https://paste.rs/ | xsel --clipboard<CR>]])

map("i", "<C-l>", "<Left>")
map("i", "<C-k>", "<Up>")
map("i", "<C-h>", "<Right>")
map("i", "<C-j>", "<Down>")

-- undo breakpoints
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")
map("i", "[", "[<c-g>u")
map("i", "(", "(<c-g>u")

-- vim: ts=2 sts=2 sw=2 et
