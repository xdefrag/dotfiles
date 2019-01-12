" Plugins {{{
call plug#begin('~/.cache/nvim/plugins')

Plug 'xdefrag/vim-beelzebub'                                           " Best colorscheme

Plug 'tpope/vim-commentary'                                            " Easy commenting
Plug 'tpope/vim-unimpaired'                                            " Shortcuts with [ and ]
Plug 'tpope/vim-surround'                                              " Controls surrounding characters
Plug 'tpope/vim-repeat'                                                " Dot support for bunch of plugins
Plug 'godlygeek/tabular'                                               " Text align
Plug 'airblade/vim-gitgutter'                                          " Git state in SignColumn
Plug 'junegunn/rainbow_parentheses.vim'                                " Rainbows without ponies
Plug 'airblade/vim-rooter'                                             " Finding root of app

Plug 'editorconfig/editorconfig-vim'                                   " Editorconfig rules support
Plug 'mhinz/vim-startify'                                              " Start screen and session manager
Plug '/usr/local/opt/fzf'                                              " FuzzyFinder
Plug 'junegunn/fzf.vim'                                                " FuzzyFinder interface
Plug 'SirVer/ultisnips'                                                " Snippets engine
Plug 'honza/vim-snippets'                                              " Snippets
Plug 'tpope/vim-fugitive'                                              " Git
Plug 'mbbill/undotree'                                                 " What it says, yep
Plug 'majutsushi/tagbar'                                               " Code tree

Plug 'w0rp/ale'

Plug 'fatih/vim-go', { 'for': 'go', 'do' : ':GoUpdateBinaries' }       " Golang magic plugin for everything
Plug 'sebdah/vim-delve', { 'for' : 'go' }                              " Go debug
Plug 'buoto/gotests-vim', { 'for' : 'go' }                             " Table test generator

Plug 'ElmCast/elm-vim', { 'for': 'elm' }                               " Elm tools

Plug 'roxma/nvim-yarp'                                             " Remote plugin framework
Plug 'ncm2/ncm2'                                                   " Completion
Plug 'ncm2/ncm2-bufword'                                           " Buffer
Plug 'ncm2/ncm2-tmux'                                              " Tmux
Plug 'ncm2/ncm2-path'                                              " Path
Plug 'ncm2/ncm2-syntax' | Plug 'Shougo/neco-syntax'                " Syntax
Plug 'filipekiss/ncm2-look.vim', { 'for' : 'md' }                  " Look
Plug 'ncm2/ncm2-ultisnips'                                         " Snippets
Plug 'ncm2/ncm2-tern', { 'for': 'js', 'do' : 'npm i' }             " Tern
Plug 'ncm2/ncm2-vim', { 'for' : 'vim' }                            " VimScript
Plug 'ncm2/ncm2-go', { 'for' : 'go' }                              " Golang

call plug#end()
" }}}
" Colors {{{
set background=dark
colorscheme beelzebub
" }}}
" Options {{{
" Leader keys
let mapleader="\<Space>"

" Default shell
set shell=/bin/zsh

" Tags
set tags=./tags,tags;

" Helptags
packloadall
silent! helptags ALL

" Disable this useless piece of hardware
set mouse=

" Backspacing, yeah!
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
"set nowrap
" }}}
" Visual {{{
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
" }}}
" Completion {{{
" Show popup even there is only one match
set completeopt+=menuone
" Longest matches
set completeopt-=longest
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
set wildignore+=*/node_modules/*,*/vendor/*
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
nnoremap ; :

" Line nav
nnoremap L $
nnoremap H ^

" Window split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" No highlighting
nnoremap <silent> <BS> :noh<CR>

" Vim config stuff
nnoremap <leader>vc :edit $MYVIMRC<CR>

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
augroup END
" }}}
" Netrw {{{
let g:netrw_banner       = 0
let g:netrw_keepdir      = 0
let g:netrw_liststyle    = 1
let g:netrw_sort_options = 'i'

nnoremap <leader>n :Explore<CR>
" }}}
" Startify {{{
let g:startify_session_dir='~/.cache/nvim/sessions/'
" }}}
" FZF {{{
" Layout
let g:fzf_layout = { 'down': '~20%' }

" Colours
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'Normal'],
  \ 'bg+':     ['bg', 'Normal'],
  \ 'hl+':     ['fg', 'Comment'],
  \ 'info':    ['fg', 'Comment'],
  \ 'border':  ['fg', 'Comment'],
  \ 'prompt':  ['fg', 'Normal'],
  \ 'pointer': ['fg', 'Normal'],
  \ 'marker':  ['fg', 'Normal'],
  \ 'spinner': ['fg', 'Comment'],
  \ 'header':  ['fg', 'Comment'] }

" Use ripgrep instead ag
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Mappings
nnoremap <silent><leader>ff :Files<CR>
nnoremap <silent><leader>fb :Buffers<CR>
nnoremap <silent><leader>ft :Tags<CR>
nnoremap <silent><leader>fh :History<CR>
nnoremap <silent><leader>fs :Snippets<CR>
" }}}
" Ultisnips {{{
let g:UltiSnipsSnippetsDir = '~/.config/nvim/snippets/'
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<C-tab>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
" }}}
" Git Gutter {{{
" Disable default keys
let g:gitgutter_map_keys = 0
" Don't touch mah fancy scheme
let g:gitgutter_override_sign_column_highlight = 0
" Default grep
if executable('rg')
  let g:gitgutter_grep = 'rg'
endif
" }}}
" NCM2 {{{
augroup NCM2
  autocmd BufEnter * call ncm2#enable_for_buffer()
augroup END

let g:ncm2#complete_delay = 0
let g:ncm2#popup_delay = 0
let g:ncm2#matcher = "prefix"
let g:ncm2#sorter = "alphanum"
" }}}
" DLV {{{
let g:delve_breakpoint_sign_highlight = 'Normal'
let g:delve_breakpoint_sign = 'B'
let g:delve_tracepoint_sign_highlight = 'Normal'
let g:delve_tracepoint_sign = 'T'
" }}}
" Ale {{{
let g:ale_linters_explicit = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
let g:ale_set_highlights = 0
"let g:ale_lint_on_text_changed = 'always'
"let g:ale_lint_on_insert_leave = 'always'
"let g:ale_lint_on_enter = 0
"let g:ale_set_loclist = 0
"let g:ale_set_quickfix = 1
"let g:ale_fix_on_save = 1


let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
" }}}
" vim:foldmethod=marker:foldlevel=0
