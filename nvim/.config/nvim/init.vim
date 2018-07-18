" Plugins {{{
call plug#begin('~/.cache/nvim/plugins')
Plug 'chriskempson/base16-vim'                                              " Fancy colorschemes
Plug 'editorconfig/editorconfig-vim'                                        " Editorconfig rules support
Plug 'sheerun/vim-polyglot'                                                 " Filetype plugins
Plug 'ctrlpvim/ctrlp.vim'                                                   " Fuzzy find
Plug 'mileszs/ack.vim'                                                      " Ag interface
Plug 'SirVer/ultisnips'                                                     " Snippets
Plug 'w0rp/ale'                                                             " Syntax checker, linter etc
Plug 'fatih/vim-go', { 'for': 'go', 'do' : ':GoUpdateBinaries' }            " Golang magic plugin for everything
Plug 'airblade/vim-gitgutter'                                               " Git state in SignColumn
Plug 'tpope/vim-commentary'                                                 " Easy commenting
Plug 'tpope/vim-unimpaired'                                                 " Shortcuts with [ and ]
Plug 'tpope/vim-surround'                                                   " Controls surrounding characters
Plug 'tpope/vim-repeat'                                                     " Dot support for bunch of plugins
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
" Write swap file every 100ms
set updatetime=100
" Disable line wrapping
set nowrap
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
" Timing
set matchtime=1
" Disabling useless statusline
set laststatus=0
" No cursor position
set noruler
" I know on what mode am I, huh
set noshowmode
" Always show sign column
set signcolumn=yes
" Display unprintable characters
set list
" Mark indenting with dots and trails with minus
set listchars=tab:\.\ ,trail:-
" Transparent SignColumn
hi SignColumn ctermbg=none
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
"set omnifunc=syntaxcomplete#Complete
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

" Don't press shift everytime
nnoremap 9 (
nnoremap 0 )

" Line nav
nnoremap L $
nnoremap H ^

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

" Mimic Emacs Line Editing in Insert Mode Only
inoremap <C-A> <Home>
inoremap <C-B> <Left>
inoremap <C-E> <End>
inoremap <C-F> <Right>
" â is <Alt-B>
inoremap â <C-Left>
" æ is <Alt-F>
inoremap æ <C-Right>
inoremap <C-K> <Esc>lDa
inoremap <C-U> <Esc>d0xi
inoremap <C-Y> <Esc>Pa
inoremap <C-X><C-S> <Esc>:w<CR>a

" folds
nnoremap h zc
nnoremap l zo

" nops
noremap <Esc> <nop>
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
inoremap <Esc> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

" moves
"onoremap p i(
" }}}
" Abbr {{{
" What a useful feature!
iabbrev adn and
" }}}
" Autocmd {{{
" :help autocmd-events
augroup basegroup
  autocmd!
  " Disable mouse on every buffer
  autocmd BufEnter * set mouse=
  " Write files on disk after creating
  autocmd BufNewFile * :write
augroup END
" }}}
" Netrw {{{
" Disable banner
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_sort_options = 'i'
let g:netrw_altv = 1
let g:netrw_list_hide = netrw_gitignore#Hide()
let g:netrw_list_hide .= ',\(^\|\s\s\)\zs\.\S\+'

nnoremap <C-n> :Explore<CR>
" }}}
" Ack {{{
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" }}}
" CtrlP {{{
nnoremap <C-p> :CtrlP<CR>
"nnoremap <leader>b :CtrlPBuffer<CR>
"nnoremap <leader>h :CtrlPMRUFiles<CR>
" }}}
" Ultisnips {{{
let g:UltiSnipsSnippetsDir = '~/.config/nvim/snippets/'
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
" }}}
" Ale {{{
" Run only linters from local ftplugin files
let g:ale_linters_explicit = 1
" Run b:ale_fixers on save
let g:ale_fix_on_save = 1
" Language server autocompletion
let g:ale_completion_enabled = 0
" Linting
"let g:ale_lint_delay = 300
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
" Gutter always open
let g:ale_sign_column_always = 1
" Signs
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
" Quickfix settings
let g:ale_open_list = 0
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
let g:ale_list_window_size = 5
" Transparent errors and warnings
hi ALEErrorSign ctermbg=none ctermfg=Cyan
hi ALEWarningSign ctermbg=none ctermfg=Cyan
hi ALESignColumnWithoutErrors ctermbg=none ctermfg=Cyan
" Ale error msg
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" }}}
" Git Gutter {{{
" Disable default keys
let g:gitgutter_map_keys = 0
" Don't touch mah fancy scheme
let g:gitgutter_override_sign_column_highlight = 0
" Default grep
if executable('ag')
  let g:gitgutter_grep = 'ag'
endif
" Colors
hi GitGutterAdd ctermbg=none ctermfg=Cyan
hi GitGutterChange ctermbg=none ctermfg=Cyan
hi GitGutterDelete ctermbg=none ctermfg=Cyan
hi GitGutterChangeDelete ctermbg=none ctermfg=Cyan
" }}}
" vim:foldmethod=marker:foldlevel=0
