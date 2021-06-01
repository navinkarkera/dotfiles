" Set completeopt to have a better completion experience
set completeopt-=preview
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_matching_smart_case = 1
let g:completion_sorting = 'none'
let g:completion_enable_auto_paren = 1
let g:completion_menu_length = 10
let g:completion_auto_change_source = 1

" possible value: 'UltiSnips', 'Neosnippet', 'vim-vsnip', 'snippets.nvim'
let g:completion_enable_snippet = 'vim-vsnip'

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

imap <c-j> <Plug>(completion_next_source)
imap <c-k> <Plug>(completion_prev_source)

let g:completion_chain_complete_list = {
    \ 'vim': [
    \    {'complete_items': ['snippet']},
    \    {'mode': 'cmd'},
    \    {'mode': '<c-p>'},
    \    {'mode': '<c-n>'},
    \    {'mode': 'file'},
    \],
    \ 'default': [
    \    {'complete_items': ['lsp', 'snippet']},
    \    {'mode': '<c-n>'},
    \    {'mode': '<c-p>'},
    \    {'mode': 'file'},
    \],
    \ 'TelescopePrompt': []
\}
