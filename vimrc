set number
syntax enable
colorscheme OceanicNext

" Disable auto collapse
autocmd FileType * exec ":set nofen"

" Override ultimate vimrc
set foldcolumn=0
set shiftwidth=0
set tabstop=2

" Prettier
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.json,*.css,*.scss,*.less,*.graphql PrettierAsync
let g:prettier#config#single_quote = 'true'
let g:prettier#config#semi = 'false'

" you complete me
let g:ycm_min_num_of_chars_for_completion = 4
let g:ycm_min_num_identifier_candidate_chars = 4
let g:ycm_enable_diagnostic_highlighting = 0
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0"

" emmet
let g:user_emmet_leader_key=';'
let g:user_emmet_install_global = 0
let g:user_emmet_settings = {
\ 'javascript.jsx':{
\    'extends' : 'jsx',
\   },
\}
autocmd FileType html,css,javascript,javascript.jsx EmmetInstall

" YAJS
let g:used_javascript_libs = 'react'
