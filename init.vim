set guifont=SF\ Mono\ 11
set mouse=a " allows mouse for selection in terminal 
set title " makes terminal show current file in title

filetype plugin on

set rtp+=~/.vim/
set packpath+=~/.vim/
packadd! vim-tools-dev

" source /mathworks/devel/sandbox/savadhan/vim/mw-completions/_vimrc

call plug#begin()

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'tpope/vim-fugitive'

Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" Completions
Plug 'hrsh7th/nvim-cmp' " The completion plugin
Plug 'hrsh7th/cmp-buffer' " buffer completions
Plug 'hrsh7th/cmp-path' " path completions
Plug 'hrsh7th/cmp-cmdline' " cmdline completions
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'saadparwaiz1/cmp_luasnip' " snippet completions
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'

let g:AutoPairsMapCh = 0
Plug 'jiangmiao/auto-pairs' " auto paren completion

call plug#end()

imap <C-Space> <Plug>IMAP_JumpForward
if !has('gui_running')
    imap <C-f> <Plug>IMAP_JumpForward
end
nnoremap <tab> za

set completeopt=menuone,noselect,noinsert

lua <<EOF
require'user.lsp'
require'user.cmp'
EOF
