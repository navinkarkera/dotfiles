-- Set <space> as the leader key: lazy.spawn(terminal),
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

require('lazy').setup({
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    "olimorris/onedarkpro.nvim",
    -- priority = 1000, -- Ensure it loads first
  },
  {
    "rose-pine/neovim",
    priority = 1000, -- Ensure it loads first
  },
  'nvim-lualine/lualine.nvim',
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects', 'nvim-treesitter/nvim-treesitter-refactor' },
    build = ":TSUpdate",
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
    },
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'lukas-reineke/cmp-rg',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      {
        'quangnguyen30192/cmp-nvim-tags',
        ft = {
          'python',
        }
      }
    },
  },
  "rafamadriz/friendly-snippets",
  "honza/vim-snippets",
  "windwp/nvim-ts-autotag",
  "ThePrimeagen/harpoon",
  "danymat/neogen",
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
  },
  "kylechui/nvim-surround",
  { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  { "pechorin/any-jump.vim" },
  {
    "ramojus/mellifluous.nvim",
    -- version = "v0.*", -- uncomment for stable config (some features might be missed if/when v1 comes out)
    config = function()
      require("mellifluous").setup({
        dim_inactive = true,
        colorset = "mellifluous",
      }) -- optional, see configuration section.
      vim.cmd("colorscheme mellifluous")
    end,
  },
  { import = 'custom.plugins' },
}, {
  rocks = {
    hererocks = true,  -- recommended if you do not have global installation of Lua 5.1.
  },
})

-- conceal
vim.o.conceallevel = 2

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
vim.o.background = "dark"
vim.o.termguicolors = true
vim.o.cursorline = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu'
vim.o.complete = '.,w,b'

-- window direction
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.splitkeep = "screen"

-- vim.g.gruvbox_baby_transparent_mode = 1
-- require("modus-themes").setup({
-- 	-- Theme comes in two styles `modus_operandi` and `modus_vivendi`
-- 	-- `auto` will automatically set style based on background set with vim.o.background
-- 	style = "auto",
-- 	variant = "tinted", -- Theme comes in four variants `default`, `tinted`, `deuteranopia`, and `tritanopia`
-- 	dim_inactive = false, -- "non-current" windows are dimmed
-- 	styles = {
-- 		-- Style to be applied to different syntax groups
-- 		-- Value is any valid attr-list value for `:help nvim_set_hl`
-- 		comments = { italic = true },
-- 		keywords = { italic = true },
-- 		functions = {},
-- 		variables = {},
-- 	},
-- })
-- require("onedarkpro").setup({
--   styles = {
--     types = "NONE",
--     methods = "NONE",
--     numbers = "NONE",
--     strings = "NONE",
--     comments = "italic",
--     keywords = "bold,italic",
--     constants = "NONE",
--     functions = "NONE",
--     operators = "NONE",
--     variables = "NONE",
--     parameters = "NONE",
--     conditionals = "italic",
--     virtual_text = "NONE",
--   },
--   options = {
--     highlight_inactive_windows = true,
--   },
-- })

-- require("rose-pine").setup({
--   variant = "auto", -- auto, main, moon, or dawn
--   dark_variant = "main", -- main, moon, or dawn
--   dim_inactive_windows = true,
--   extend_background_behind_borders = true,
--
--   enable = {
--     terminal = true,
--     legacy_highlights = false, -- Improve compatibility for previous versions of Neovim
--     migrations = true, -- Handle deprecated options automatically
--   },
--
--   disable_italics = true,
--   highlight_groups = {
--     Comment = { italic = true },
--     String = { italic = true },
--   }
-- })

-- vim.cmd.colorscheme "sorbet"

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
    theme = 'auto',
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

-- Anyjump config
vim.g.any_jump_grouping_enabled                     = 1
vim.g.any_jump_preview_lines_count                  = 10
vim.g.any_jump_references_only_for_current_filetype = 1
vim.g.any_jump_window_width_ratio                   = 0.8
vim.g.any_jump_window_height_ratio                  = 0.8
vim.g.any_jump_window_top_offset                    = 5

map("n", "<C-q>", ":call ToggleQuickFix()<CR>",
  { silent = true, noremap = true }
)
map("n", "<C-j>", ":cn<CR>zz",
  { silent = true, noremap = true }
)
map("n", "<C-k>", ":cp<CR>zz",
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
  callback = function() vim.highlight.on_yank() end,
  group = highlight_group,
  pattern = '*',
})

-- Autocommands
local my_group = vim.api.nvim_create_augroup('my_group', { clear = true })
local api = vim.api
api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end,
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
      vim.schedule(function() gs.nav_hunk('next') end)
      return '<Ignore>'
    end, { expr = true })

    gmap('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.nav_hunk('prev') end)
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

local fzf_lua = require("fzf-lua")
fzf_lua.setup({
  'fzf-native',
  keymap = {
    fzf = {
      ['CTRL-Q'] = 'select-all+accept',
    },
  },
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
map('n', '<leader>ft', fzf_lua.treesitter)
map('n', '<leader>fws', fzf_lua.lsp_live_workspace_symbols)
map('n', '<C-]>',
  function()
    fzf_lua.command_history({ fzf_opts = { ["--tiebreak"] = "index", ["--query"] = "Run " } })
  end)
map('n', '<leader>?', fzf_lua.oldfiles)
map('n', '<C-f>', fzf_lua.live_grep_glob)
map("v", "<C-f>", fzf_lua.grep_visual)
map("n", "<leader>pw", fzf_lua.grep_cword)
map("n", "<leader>tt", my_functions.fzf_get_terminals)
map("n", "<leader>z=", fzf_lua.spell_suggest)
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
      cmd = "git-diff-with-lines " .. opts.args,
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
  }
)

local base_branch = vim.fn.system({'git', 'rev-parse', '--abbrev-ref', 'origin/HEAD'})
base_branch = vim.trim(base_branch)
map('n', '<leader>fc', ":ListFilesFromBranch " .. base_branch .. "<CR>")
map('n', '<leader>dc', ":DiffviewOpen " .. base_branch .. "<CR>")

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "html",
    "htmldjango",
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
    "ron",
    "markdown",
    "markdown_inline",
    "yaml",
    "templ",
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
  refactor = {
    smart_rename = {
      enable = true,
      -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
      keymaps = {
        smart_rename = "grr",
      },
    },
    navigation = {
      enable = true,
      -- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
      keymaps = {
        goto_definition_lsp_fallback = "gd",
        list_definitions = false,
        list_definitions_toc = "gO",
        goto_next_usage = "<a-*>",
        goto_previous_usage = "<a-#>",
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

local linter_on_attach = function(_, bufnr)
  local opts = { buffer = bufnr }
  map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
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
  map('n', 'gr', vim.lsp.buf.references, opts)
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
  basedpyright = {
    on_attach = on_attach,
    capabilities = capabilities,
    autostart = false,
    settings = {
      basedpyright = {
        typeCheckingMode = "standard",
      },
    }
  },
  ts_ls = {
    on_attach = on_attach,
    capabilities = capabilities,
    autostart = false,
    init_options = {
      hostInfo = "neovim",
      preferences = {
        includeCompletionsForModuleExports = true,
        includeCompletionsForImportStatements = true,
        importModuleSpecifierPreference = "relative",
      },
    }
  },
  cssls = {
    on_attach = on_attach,
    capabilities = capabilities,
    autostart = false,
  },
  eslint = {
    on_attach = on_attach,
    capabilities = capabilities,
    autostart = false,
  },
  html = {
    on_attach = on_attach,
    capabilities = capabilities,
    autostart = true,
    filetypes = { "html", "templ", "htmldjango" },
  },
  marksman = {
    on_attach = on_attach,
    capabilities = capabilities,
    autostart = true,
  },
  ruff = {
    on_attach = linter_on_attach,
    autostart = true
  },
  quick_lint_js = {
    on_attach = linter_on_attach,
    autostart = true
  },
  gopls = {
    on_attach = on_attach,
    capabilities = capabilities,
    autostart = true,
    settings = {
      gopls = {
        experimentalPostfixCompletions = true,
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        staticcheck = true,
        templateExtensions = { "templ" },
      },
    },
    init_options = {
      usePlaceholders = true,
    }
  },
  templ = {
    on_attach = on_attach,
    capabilities = capabilities,
    autostart = true,
  },
  tailwindcss = {
    on_attach = on_attach,
    capabilities = capabilities,
    autostart = true,
    filetypes = { "templ", "astro", "javascript", "typescript", "react" },
    settings = {
      tailwindCSS = {
        includeLanguages = {
          templ = "html",
        },
      },
    },
  }
}


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
    ['<C-x><C-r>'] = cmp.mapping(
      cmp.mapping.complete({
        config = {
          sources = cmp.config.sources({
            { name = 'rg' },
          }),
        },
      }),
      { 'i' }
    ),
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
      if luasnip.locally_jumpable(-1) then
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
  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'tags' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    {{ name = 'rg' }},
  }),
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
        rg = "[RG]"
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
  [[<cmd>botright split | resize 20 | lua require('harpoon.term').gotoTerminal(require('my-functions').count_or_one())<CR>]])
map("n", [[<M-e>]],
  [[<cmd>lua require('harpoon.term').sendCommand(require('my-functions').count_or_one(), require('my-functions').count_or_one())<CR>]])
map("v", [[<M-e>]],
  [["vy<cmd>lua require('harpoon.term').sendCommand(require('my-functions').count_or_one(), vim.fn.getreg("v"))<CR> ]])
map("n", ",l", [[<cmd>lua require('harpoon.term').sendCommand(require('my-functions').count_or_one(), '!!')<CR>]])
map("n", "<M-space>", my_functions.execute_from_harpoon)

-- refactoring.nvim
require("refactoring").setup {
  -- overriding printf statement for python
  print_var_statements = {
    python = {
      'print(f"""======================================= %s {%s}""")',
    },
    javascript = {
      'console.log("%s ", %s);',
    },
    javascriptreact = {
      'console.log("%s ", %s);',
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

map('n', '<leader>pv', function() fzf_lua.files({ cwd = "%:h" }) end)
map('n', '<C-p>', fzf_lua.files)

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
map("n", "<M-]>", my_functions.fzf_all_tasks)
map("n", "<M-r>", my_functions.restart_cmd)
map("n", "<leader>mt", my_functions.fzf_make_tasks)
-- github
map("n", "<leader>gv", "<cmd>Run gh pr view --comments<CR>")
map("n", "<leader>gc", "<cmd>Run gh pr checks --watch --fail-fast<CR>")

vim.api.nvim_create_user_command("Grep", "silent grep! <q-args>", { nargs = 1 })
vim.api.nvim_create_user_command(
  "Gqdiff",
  [[cexpr system("/usr/share/git/git-jump/git-jump --stdout diff ]] .. "<args>" .. [[")]],
  {
    nargs = '*',
    force = true,
    complete = function()
      local branches = vim.fn.systemlist("git branch --all --sort=-committerdate")
      if vim.v.shell_error == 0 then
        return vim.tbl_map(function(x)
          return x:match("[^%s%*]+"):gsub("^remotes/", "")
        end, branches)
      end
    end,
  }
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
map("n", "gD", ":tag <C-R>=expand('<cword>')<CR><CR>")
map("n", "gP", ":ptselect <C-R>=expand('<cword>')<CR><CR>")
map("n", "<leader>sg", ":spellgood <C-R>=expand('<cword>')<CR><CR>")

map("i", "<C-h>", "<Left>")
map("i", "<C-k>", "<Up>")
map("i", "<C-l>", "<Right>")
map("i", "<C-j>", "<Down>")

-- undo breakpoints
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")
map("i", "[", "[<c-g>u")
map("i", "(", "(<c-g>u")

-- search
map('v', ",s", [["vy:silent !s <C-R>v<CR>]])
map('n', ",s", [[:silent !s <C-R>=expand('<cword>')<CR><CR>]])

-- vim: ts=2 sts=2 sw=2 et
