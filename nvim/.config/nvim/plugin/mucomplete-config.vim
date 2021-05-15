set completeopt-=preview
set completeopt+=menuone,noselect
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#completion_delay = 50

let g:mucomplete#chains = {}
let g:mucomplete#chains['default']   =  {
\ 'default': ['vsnip', 'path', 'omni', 'keyn', 'dict', 'uspl'],
\ '.*string.*': ['uspl'],
\ '.*comment.*': ['uspl']
\ }
let g:mucomplete#chains['vim'] = ['vsnip', 'path', 'cmd', 'keyn']
