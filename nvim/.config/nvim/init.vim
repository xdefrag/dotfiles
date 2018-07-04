" Plugins {{{
call plug#begin('~/.cache/nvim/plugins')
Plug 'chriskempson/base16-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'fatih/vim-go', { 'for': 'go', 'do' : ':GoUpdateBinaries' }
call plug#end()
" }}}
" Colors {{{
" 256 colors
set t_Co=256

colorscheme base16-grayscale-dark
" }}}
" Options {{{
" Leader keys
let mapleader="\<Space>"

" Default shell
set shell=/bin/bash

" Tags
set tags=./tags,tags;

" Helptags
packloadall
silent! helptags ALL

" Disable this useless piece of hardware
set mouse=
autocmd BufEnter * set mouse=

" Backspacing like a god!
set backspace=indent,eol,start
" Check files for fancy vim settings (like this on on last line)
set modelines=1
" Copy on main system clipboard like a god
set clipboard=unnamed
" Read file if it changed somewhere
set autoread
" Write files in any case, we have big undo anyway
set autowriteall
" Key press timeout
set timeoutlen=500
" Hide nonactive buffers 
set hidden
" }}}
" Visual {{{
" Syn
syntax enable
" Indenting on file type
filetype plugin indent on
" Highlight line with cursor
set cursorline
" Let's glitch everything up
set lazyredraw
" Show matched braces
set showmatch
" Disabling useless statusline
set laststatus=0
" No cursor position
set noruler
" I know on what mode am I, huh
set noshowmode
" Disable left gutter
set signcolumn=no
" Display unprintable characters
set list
" Mark indenting with dots and trails with minus
set listchars=tab:\.\ ,trail:-
" }}}
" Completion {{{
" Show popup even there is only one match
set completeopt+=menuone
" Longest matches
set completeopt+=longest
" Remove useless preview window
set completeopt-=preview
" Do not insert any test
set completeopt+=noinsert
" Do not select any matches
set completeopt+=noselect
" Omnifunc
set omnifunc=syntaxcomplete#Complete
" }}}
" Errors {{{
" No visual bell
set noerrorbells
set novisualbell
set t_vb=
" }}}
" Tabs {{{
" Use 2 spaces instead of tabs
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
" }}}
" Indent {{{
" Copy indent from prev line
set autoindent
" C-like indenting
set smartindent
" Copy indent method from prev line
set copyindent
" More C-like stuff, it's good for your code
set cindent
" }}}
" Search {{{
" Highlight while typing
set incsearch
" Highlight search
set hlsearch
" Case-insensitive search
set ignorecase
" Wild file find
set path+=**
set wildmenu
" }}}
" Folds {{{
" Enabling folding feature
set foldenable
" Start folding on 2 level nesting
set foldlevelstart=2
" Max next folding
set foldnestmax=10
" Indent based folding
set foldmethod=indent
" }}}
" Backup {{{
if isdirectory($HOME . '/.cache/nvim/backup') == 0
  call mkdir($HOME.'/.cache/nvim/backup', 'p')
endif
set backupdir-=.
set backupdir-=~/
set backupdir^=~/.cache/nvim/backup/
set backup
" }}}
" Swap {{{
if isdirectory($HOME . '/.cache/nvim/swap') == 0
  call mkdir($HOME.'/.cache/nvim/swap', 'p')
endif
set directory+=~/.cache/nvim/swap//
set directory+=~/tmp//
set directory+=.
" }}}
" Shada {{{
if exists('+shada')
  set shada+=n~/.cache/nvim/shada
else
  set viminfo+=n~/.cache/nvim/viminfo
endif
" }}}
" Undo {{{
if exists('+undofile')
  if isdirectory($HOME . '/.cache/nvim/undo') == 0
    call mkdir($HOME.'/.cache/nvim/undo', 'p')
  endif
  set undodir+=~/.cache/nvim/undo//
  set undofile
endif
" }}}
" Keys {{{
" Navigation with j k in long lines
nnoremap j gj
nnoremap k gk

" Esc is too far away
inoremap jk <Esc>

" Window split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Vim config stuff
nnoremap <leader>vc :edit $MYVIMRC<CR>
nnoremap <leader>vr :source $MYVIMRC<CR>

" Centered on searching
nnoremap <silent> n :norm! nzz<CR>
nnoremap <silent> N :norm! Nzz<CR>
vnoremap <silent> n :norm! nzz<CR>
vnoremap <silent> N :norm! Nzz<CR>

" Centered on navigation
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz

" Easy indeting
xnoremap <  <gv
xnoremap >  >gv

" Auto Indenting
nnoremap <silent> g= mzgg=G`zzz

" Terminal
tnoremap <Esc> <C-\><C-n>
tnoremap jk <C-\><C-n>
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

inoremap <expr> <C-j> ("\<C-n>")
inoremap <expr> <C-k> ("\<C-p>")
" }}}
" Netrw {{{
" Disable banner
let g:netrw_banner       = 0
let g:netrw_liststyle    = 0
let g:netrw_sort_options = 'i'

nnoremap <C-n> :Explore<CR>
" }}}
" Ack {{{
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

nnoremap <C-a> :Ack!<Space>
" }}}
" CtrlP {{{
nnoremap <C-p> :CtrlP<CR>
"nnoremap <leader>b :CtrlPBuffer<CR>
"nnoremap <leader>h :CtrlPMRUFiles<CR>
" }}}
" vim:foldmethod=marker:foldlevel=0
