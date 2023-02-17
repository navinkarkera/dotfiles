-- Install packer
require('impatient')
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local map = vim.keymap.set

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

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost',
  { command = 'source <afile> | PackerCompile', group = packer_group, pattern = 'init.lua' })

require('packer').startup(function(use)
  use 'lewis6991/impatient.nvim'
  use 'wbthomason/packer.nvim' -- Package manager
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'ellisonleao/gruvbox.nvim' -- gruvbox theme
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use "rafamadriz/friendly-snippets"
  use "honza/vim-snippets"
  use "windwp/nvim-ts-autotag"
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use "numToStr/Navigator.nvim" -- tmux navigation
  use "ThePrimeagen/harpoon"
  use "danymat/neogen"
  use { "ThePrimeagen/refactoring.nvim",
    requires = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
  }
  use "preservim/vimux"
  use "is0n/fm-nvim"
  use({
    'ckolkey/ts-node-action',
     requires = { 'nvim-treesitter' },
  })
  use "kylechui/nvim-surround"
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use 'kyazdani42/nvim-web-devicons'
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons"
  }
  use {"pechorin/any-jump.vim"}
  use {'axkirillov/easypick.nvim', requires = 'nvim-telescope/telescope.nvim'}
end)

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
require('gruvbox').setup({
  transparent_mode = true,
  dim_inactive = false,
})
vim.cmd [[colorscheme gruvbox]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu'
vim.o.complete = '.,w,b'

-- window direction
vim.o.splitright = true
vim.o.splitbelow = true

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
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename', 'nvim_treesitter#statusline'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  }
}

--Remap space as leader key
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Enable Comment.nvim
require('Comment').setup()

-- Anyjump config
vim.g.any_jump_grouping_enabled = 1
vim.g.any_jump_preview_lines_count = 10
vim.g.any_jump_references_only_for_current_filetype = 1
vim.g.any_jump_window_width_ratio  = 0.8
vim.g.any_jump_window_height_ratio = 0.8
vim.g.any_jump_window_top_offset   = 5

--Enable trouble.nvim
require("trouble").setup({
    auto_preview = false,
})
vim.keymap.set("n", "<C-q>", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<C-j>", function() require("trouble").next({skip_groups = true, jump = true}); end,
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<C-k>", function() require("trouble").previous({skip_groups = true, jump = true}); end,
  {silent = true, noremap = true}
)

--python
vim.g.python3_host_prog = '/usr/bin/python3'

--Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

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
-- api.nvim_create_autocmd("FileType", {
--   pattern = { "xml", "html", "htmldjango", "xhtml", "css", "scss", "javascript", "javascriptreact", "yaml",
--     "typescriptreact", "typescript", "json", "lua" },
--   command = [[setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab]],
--   group = my_group,
-- })
api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  command = [[set autowriteall]],
  group = my_group,
})
api.nvim_create_autocmd("TermOpen", {
  command = [[
setlocal nonumber norelativenumber signcolumn=no
]] ,
  group = my_group,
})

-- Indent blankline
require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}

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
      vim.keymap.set(mode, l, r, opts)
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

-- Telescope
local telescope_actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
        ["<C-j>"] = telescope_actions.move_selection_next,
        ["<C-k>"] = telescope_actions.move_selection_previous,
        ["<c-t>"] = trouble.open_with_trouble,
      },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
}

-- Enable telescope fzf native
require('telescope').load_extension 'fzf'

--Add leader shortcuts
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers)
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').git_files)
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').current_buffer_fuzzy_find)
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags)
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').git_status)
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>so', function()
  require('telescope.builtin').tags { only_current_buffer = true }
end)
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles)

local easypick = require("easypick")

local base_branch = os.getenv("GIT_PARENT_BRANCH") or "master"

easypick.setup({
	pickers = {
		-- diff current branch with base_branch and show files that changed with respective diffs in preview
		{
			name = "changed_files",
			command = "git diff --name-only $(git merge-base HEAD $(git parent))",
			previewer = easypick.previewers.branch_diff({base_branch = base_branch})
		},

		-- list files that have conflicts with diffs in preview
		{
			name = "conflicts",
			command = "git diff --name-only --diff-filter=U --relative",
			previewer = easypick.previewers.file_diff()
		},
	}
})
vim.keymap.set('n', '<leader>fc', ":Easypick changed_files<CR>")

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
  },
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
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
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- LSP settings
local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'gD', function() require('telescope.builtin').lsp_definitions({ jump_type = "vsplit" }) end, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<leader>si', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wl', function()
    vim.inspect(vim.lsp.buf.list_workspace_folders())
  end, opts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', 'gr', "<cmd>TroubleToggle lsp_references<cr>", opts)
  vim.keymap.set('n', 'gR', require('telescope.builtin').lsp_references, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)
  vim.api.nvim_create_user_command("Format", vim.lsp.buf.format, {})
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Enable the following language servers
local servers = {
    {name = 'pyright', autostart = true},
    {name = 'tsserver', autostart = true},
    {name = 'cssls', autostart = true},
    {name = 'eslint', autostart = true},
    {name = 'html', autostart = true},
    {name = 'ruff_lsp', autostart=false},
}
for _, lsp in ipairs(servers) do
  lspconfig[lsp['name']].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    autostart = lsp['autostart'],
  }
end

lspconfig['gopls'].setup {
  cmd = { 'gopls' },
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
}

-- Example custom server
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  autostart = false,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
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

-- cmd maps
map("n", "<leader>mc", require('harpoon.cmd-ui').toggle_quick_menu)

map("n", "<leader>m1", function() require('harpoon.term').gotoTerminal(1) end)
map("n", "<leader>m2", function() require('harpoon.term').gotoTerminal(2) end)
map("n", "<leader>m3", function() require('harpoon.term').gotoTerminal(3) end)
map("n", "<leader>m4", function() require('harpoon.term').gotoTerminal(4) end)
map("n", "<leader>m5", function() require('harpoon.term').gotoTerminal(5) end)
map("n", "<leader>m6", function() require('harpoon.term').gotoTerminal(6) end)

map("n", "<leader>me1", function() require('harpoon.term').sendCommand(1, 1) end)
map("n", "<leader>me2", function() require('harpoon.term').sendCommand(2, 2) end)
map("n", "<leader>me3", function() require('harpoon.term').sendCommand(3, 3) end)
map("n", "<leader>me4", function() require('harpoon.term').sendCommand(4, 4) end)
map("n", "<leader>me5", function() require('harpoon.term').sendCommand(5, 5) end)
map("n", "<leader>me6", function() require('harpoon.term').sendCommand(6, 6) end)


-- Navigator
require("Navigator").setup({})
map("n", "<m-h>", require("Navigator").left)
map("n", "<m-k>", require('Navigator').up)
map("n", "<m-l>", require('Navigator').right)
map("n", "<m-j>", require('Navigator').down)
map("n", "<m-^>", require('Navigator').previous)
-- terminal keymaps
map("t", "<m-h>", require("Navigator").left)
map("t", "<m-k>", require('Navigator').up)
map("t", "<m-l>", require('Navigator').right)
map("t", "<m-j>", require('Navigator').down)
map("t", "<m-^>", require('Navigator').previous)


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
map("n", "<Leader>nc", function() require('neogen').generate({ type = 'class' }) end)

-- fm-nvim
local fmnvim = require("fm-nvim")
fmnvim.setup({
  broot_conf = vim.fn.stdpath("config") .. "/broot.toml",
  mappings = {
    vert_split = "<C-v",
    horz_split = "<C-b>",
    tabedit    = "<C-t>",
    edit       = "<C-e>",
    ESC        = "<ESC>"
  },
})
vim.keymap.set('n', '<leader>pv', ":Broot -h %:h <CR>")
vim.keymap.set('n', '<C-p>', ":Broot -h<CR>")

-- ts-node-action
require('ts-node-action').setup({})
vim.keymap.set({ "n" }, "gS", require("ts-node-action").node_action, { desc = "Trigger Node Action" })

-- nvim-surround
require("nvim-surround").setup({})

-- vimux conf
vim.g.VimuxExpandCommand = true
map("n", "<leader>vv", [[:call VimuxRunCommand("activate", 1)<CR>]])
map("n", "<leader>vp", ":VimuxPromptCommand<CR>")
map("n", "<leader>vm", [[:VimuxPromptCommand("make ")<CR>]])
map("n", "<leader>vg", [[:VimuxPromptCommand("git ls-files -zm '*.<C-R>=expand("%:.:e")<CR>' | xargs --null -t ")<CR>]])
map("n", "<leader>vl", ":VimuxRunLastCommand<CR>")
map("n", "<leader>vi", ":VimuxInspectRunner<CR>")
map("n", "<leader>vq", ":VimuxCloseRunner<CR>")
map("n", "<leader>vx", ":VimuxInterruptRunner<CR>")
map("n", "<leader>vz", ":VimuxZoomRunner<CR>")
map("n", "<leader>v<C-l>", ":VimuxClearTerminalScreen<CR>")
map("n", "<leader>vrm", [[:call VimuxPromptCommand("rm " . bufname("%"))<CR>]])
map("n", "<leader>vcp", [[:call VimuxPromptCommand("cp " . bufname("%") . " ")<CR>]])
map("n", "<leader>vrn", [[:call VimuxPromptCommand("mv " . bufname("%") . " " . bufname("%"))<CR>]])

map("v", "<leader>vs", [["vy<cmd>lua require('my-functions').VimuxSlime()<CR>]])
map("n", "<leader>vs", [[^v$<leader>vs<CR>]], { remap = true })
map("n", "<M-CR>", ":call VimuxSendKeys('Enter')<CR>")

vim.api.nvim_create_user_command("Grep", "silent grep! <q-args> | TroubleToggle quickfix", { nargs = 1})
vim.api.nvim_create_user_command(
  "GBrowse",
  [[:silent !git browse "" %:~:. <line1> <line2>]],
  { nargs = 0, range = true }
)
-- custom keymaps
map("n", "<F4>", ":bd<CR>")
-- map('n', '<C-q>', ":TroubleToggle<CR>")
map('n', '<C-s>', ":w<CR>")
map("i", "<C-s>", "<C-c>:w<CR>")
-- map("n", "<C-j>", ":cn<CR>")
-- map("n", "<C-k>", ":cp<CR>")
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("v", "<", "<gv")
map("v", ">", ">gv")
map("n", "s", "ciw")
map("n", "<m-p>", ':e <C-R>=expand("%:.:h")<CR>/')
map("n", "<C-f>", ':Grep ')
map("v", "<C-f>", [["hy:silent grep "<C-r>h" <C-R>=expand("%:.:h")<CR>/ | TroubleToggle quickfix<S-left><S-left><S-left><S-left><left><left>]])
map("n", "<leader>pw", ':silent grep "<C-R>=expand("<cword>")<CR>" | TroubleToggle quickfix<S-left><S-left><S-left><left><left>')
map(
    "n",
    "<leader>ps",
    ':silent grep "<C-R>=expand("<cword>")<CR>" --type <C-R>=expand("%:.:e")<CR> | TroubleToggle quickfix<S-left><S-left><S-left><S-left><S-left><left><left>'
)
map("v", "<C-r>", '"hy:%s/<C-r>h//gc<left><left><left>')
map("v", "cy", '"+y')
map("n", "cp", '"+p')
map("n", "<leader>k", ':silent !zeal "<C-R>=expand("<cword>")<CR>"<CR>')
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
