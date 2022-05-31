set guifont=SF\ Mono\ 11
set mouse=a " allows mouse for selection in terminal 
set title " makes terminal show current file in title

filetype plugin on

if isdirectory($HOME.'/.vim')
    set rtp+=~/.vim/
    set packpath+=~/.vim/
    packadd! vim-tools-dev
endif

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

let g:cpp_started_ccls_server = 1

lua <<EOF
require'user.plugins'
require'user.lsp'
require'user.cmp'
require'user.snip'
require'user.whichkey'
require'user.treesitter'
EOF
