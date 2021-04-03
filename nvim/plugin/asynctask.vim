" Asycrun and AsyncTask
let g:asyncrun_open = 6
nnoremap <F3> :AsyncStop<CR>
let g:asynctasks_term_pos = 'right'
let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg', 'Cargo.toml', 'pyproject.toml', '.tasks']
let g:asynctasks_template = {}
let g:asynctasks_template.cargo = [
            \ "[project-init]",
            \ "command=cargo update",
            \ "cwd=<root>",
            \ "",
            \ "[project-build]",
            \ "command=cargo build",
            \ "cwd=<root>",
            \ "errorformat=%. %#--> %f:%l:%c",
            \ "",
            \ "[project-run]",
            \ "command=cargo run",
            \ "cwd=<root>",
            \ "output=terminal",
            \ ]


" Co-operate with fugitive
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>


" AsyncTask keymaps
nnoremap <silent><F5> :AsyncTask file-run<CR>
nnoremap <silent><F6> :AsyncTask project-run<CR>
nnoremap <silent><F7> :AsyncTask project-build<CR>
nnoremap <silent><F11> :lua require'telescope'.extensions.asynctasks.all()<CR>

