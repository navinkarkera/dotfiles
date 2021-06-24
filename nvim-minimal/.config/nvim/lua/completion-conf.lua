-- Use completion-nvim in every buffer
local g = vim.g
local map = vim.api.nvim_set_keymap
vim.cmd([[ autocmd BufEnter * lua require'completion'.on_attach() ]])

g.completion_matching_strategy_list = { 'exact', 'fuzzy' }
g.completion_matching_smart_case = 1
g.completion_sorting = 'none'
g.completion_enable_auto_paren = 1
g.completion_menu_length = 10
g.completion_auto_change_source = 1

-- possible value: 'UltiSnips', 'Neosnippet', 'vim-vsnip', 'snippets.nvim'
g.completion_enable_snippet = 'vim-vsnip'

-- Use <Tab> and <S-Tab> to navigate through popup menu
local options = { expr = true, noremap = true }

map('i', '<Tab>', 'pumvisible() ? "<C-n>" : "<Tab>"', options)
map('i', '<S-Tab>', 'pumvisible() ? "<C-p>" : "<S-Tab>"', options)

map('i', '<c-j>', '<Plug>(completion_next_source)', {})
map('i', '<c-k>', '<Plug>(completion_prev_source)', {})

g.completion_chain_complete_list = {
    vim = {
        {complete_items = { 'snippet' }},
        {mode = 'cmd'},
        {mode = '<c-p>'},
        {mode = '<c-n>'},
        {mode = 'file'},
    },
    default = {
        {complete_items = {'lsp'}},
        {mode = '<c-p>'},
        {complete_items = {'snippet'}},
        {mode = 'file'},
    },
}
