set guifont=SF\ Mono\ 11
set mouse=a " allows mouse for selection in terminal 
set title " makes terminal show current file in title

filetype plugin on
let g:cpp_started_ccls_server = v:true

if isdirectory($HOME.'/.vim')
    set rtp+=~/.vim/
    set packpath+=~/.vim/
    packadd! vim-tools-dev
endif

lua <<EOF
pcall('require', 'impatient')
require'user.plugins'
require'user.lsp'
require'user.cmp'
require'user.snip'
EOF
