set completeopt-=preview
set completeopt+=menuone,noselect
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#completion_delay = 50

let g:mucomplete#chains = {}
let g:mucomplete#chains['default']   =  {
\ 'default': ['vsnip', 'path', 'omni', 'keyn', 'dict', 'uspl'],
\ '.*comment.*': ['uspl']
\ }
let g:mucomplete#chains['vim'] = ['vsnip', 'path', 'cmd', 'keyn']
let g:mucomplete#chains['python'] = ['vsnip', 'path', 'omni', 'keyn', 'uspl']

if !exists('g:mucomplete#can_complete')
    let s:c_cond = { t -> t =~# '\%(->\|\.\)$' }
    let s:latex_cond= { t -> t =~# '\%(\\\)$' }
    let g:mucomplete#can_complete = {}
    let g:mucomplete#can_complete['c']         =  {  'omni':  s:c_cond              }
    let g:mucomplete#can_complete['go']        =  {  'omni':  s:c_cond              }
    let g:mucomplete#can_complete['python']    =  {  'omni':  s:c_cond              }
    let g:mucomplete#can_complete['java']      =  {  'omni':  s:c_cond              }
    " let g:mucomplete#can_complete['javascript']=  {  'omni': {t->t=~#'\%(->\|\.\|(\))$' }}
    let g:mucomplete#can_complete['javascript']=  {  'omni':  s:c_cond }
    let g:mucomplete#can_complete['markdown']  =  {  'dict':  s:latex_cond          }
    let g:mucomplete#can_complete['org']       =  {  'dict':  s:latex_cond,
                \ 'tag': {t->t=~#'\%(:\)$' }}
    let g:mucomplete#can_complete['tex']       =  {  'omni':  s:latex_cond          }
    let g:mucomplete#can_complete['troff']     =  {  'omni': { t -> t =~# '\%(\\\[\)$' }}
    let g:mucomplete#can_complete['troff']     =  {  'omni': { t -> t =~# '^.' }}
    let g:mucomplete#can_complete['html']      =  {  'omni':  {t->t=~#'\%(<\/\)$'}  }
    let g:mucomplete#can_complete['vim']       =  {  'cmd':   {t->t=~#'\S$'}        }
endif
