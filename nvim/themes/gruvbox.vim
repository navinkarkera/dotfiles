let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'medium'
if exists('+termguicolors')
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection = '0'
let g:gruvbox_italic = '1'
let g:gruvbox_italicize_strings ='1'

colorscheme gruvbox
set background=dark
