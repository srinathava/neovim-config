" -------------------------------- Settings ---------------------------
set termguicolors
filetype plugin on
filetype indent on
" ff=unix makes sense because vim compiled for a dos machine can source unix
" style script files whereas vim compiled for *ix usually cannot source a dos
" style script file.
au BufWritePre *.vim :if &ff != 'unix' | set ff=unix | endif
syntax on
set colorcolumn=120
set expandtab
set hls
set ignorecase
set smartcase
set indentkeys+=!
set showmode
set showcmd
set grepprg=grep\ -nH\ $*
set ruler
set shiftwidth=4
set laststatus=2
set ww=<,>,[,],h,l
set sm
set cpt=.,w,b,t,u,k/usr/dict/words
set tags+=./tags,../tags,../../tags,../../../tags
set ai
set tw=75
set ts=4
set bs=2
if has('unix')
    set shell=bash
    set shellslash
endif
set wildmode=longest:list
set wildmenu
set autoread
set mousemodel=popup_setpos
set sessionoptions=buffers,curdir,folds,globals,resize,winpos,winsize
set modeline
let mapleader='`'
" incase i have to view some file with huge long lines...
set linebreak
" preserve some info from the last vim session
if has('unix')
    if has('nvim')
        set viminfo='1000,:1000,\"5000,/1000,n~/.viminfo.unix.nvim
    else
        set viminfo='1000,:1000,\"5000,/1000,n~/.viminfo.unix.vim
    endif
else
    set viminfo='1000,:1000,\"5000,/1000,n~/.viminfo.win32
end
" always want to see the whole line.
set wrap
" no beeps. only flashes.
set vb
" allows for the vim yank command to be the windows clipboard.
set clipboard=unnamedplus
" do not display a string of '@'s instead of a long unwrapped line 
set display=lastline
" preserve a minimum amount of context while scrolling off the screen
set scrolloff=3
" pressing return or o while typing comments preserves comment header.
set fo+=ro
set listchars=tab:>-,precedes:<,extends:>,trail:.,tab:>-,eol:$
" dont want :w to move cursor to beginning of line.
set nosol
set guioptions-=t
if has('gui_win32')
    set guifont=Consolas:h10
else
    set guifont=SF\ Mono\ 11,Monospace\ 11
end
set et sts=4 sw=4

" cd to the current buffer's directory
com! -nargs=0 CD :exec 'cd '.expand('%:p:h')

let g:Debug = 1
let g:DirDiffExcludes = "CVS,swp$,exe$,obj$,*.o$"

" Do not load the syntax menu
let g:did_install_syntax_menu = 1

au BufReadCmd *.slx call zip#Browse(expand("<amatch>"))

" s:Mkdir:  {{{
" Description: 
function! s:SetDir(setting)
    let dirname = "/tmp/".$USER."/vim_tmp/".a:setting
    if !isdirectory(dirname)
        echomsg("Creating directory ".dirname)
        call system("mkdir -p ".dirname)
    endif
    exec "set ".a:setting."=".dirname."//"
endfunction " }}}
call s:SetDir('backupdir')
call s:SetDir('directory')
call s:SetDir('undodir')

let g:tokyo_night_style = 'night'
colorscheme tokyonight

set number
set numberwidth=4
set signcolumn=yes
