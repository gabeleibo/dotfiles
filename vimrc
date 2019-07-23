set number

" Disable auto collapse
autocmd FileType * exec ":set nofen"

" Override ultimate vimrc
set foldcolumn=0

" emmet
let g:user_emmet_leader_key=';'
let g:user_emmet_install_global = 0
let g:user_emmet_settings = {
\ 'javascript.jsx':{
\    'extends' : 'jsx',
\   },
\}
autocmd FileType html,css,javascript.jsx EmmetInstall
