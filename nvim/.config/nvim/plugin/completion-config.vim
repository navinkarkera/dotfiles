" Set completeopt to have a better completion experience
set completeopt-=preview
set completeopt=menuone,noinsert,noselect
let g:completion_auto_change_source = 1
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_matching_smart_case = 1

" possible value: 'UltiSnips', 'Neosnippet', 'vim-vsnip', 'snippets.nvim'
let g:completion_enable_snippet = 'vim-vsnip'

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let g:completion_chain_complete_list = {
    \ 'vim': [
    \    {'mode': 'cmd'},
    \    {'mode': '<c-p>'},
    \    {'mode': '<c-n>'}
    \],
    \ 'default': [
    \    {'complete_items': ['snippet', 'lsp']},
    \    {'mode': '<c-p>'},
    \    {'mode': '<c-n>'},
    \    {'mode': 'incl'},
    \    {'mode': 'spel'},
    \]
\}
