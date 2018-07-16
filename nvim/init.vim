set nocompatible        " be iMproved
filetype off          " required!

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'

call plug#end()

"Plugin 'VundleVim/Vundle.vim'
"Plugin 'tpope/vim-fugitive'
"Plugin 'vim-airline/vim-airline'
"Plugin 'godlygeek/tabular'
"Plugin 'AutoComplPop'
"Plugin 'FuzzyFinder'
"Plugin 'L9'
 
"call vundle#end()            " required
filetype plugin indent on     " required!
 
"AirLine>-----------------------
"let g:airline_powerline_fonts = 1
let g:airline_powerline_fonts = 0
set laststatus=2
"Windows: ** need to find new one... **
"Mac:     https://gist.github.com/baopham/1838072
"---------------------------------
 
"Terminal>---------------------------
let g:terminal_scrollback_buffer_size = 100000
"------------------------------------

let g:netrw_liststyle=3

set termencoding=utf-8
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\

if !has('nvim')
    set term=xterm-256color
endif
 
set ts=2
set expandtab
set shiftwidth=2
set ruler
set foldmethod=marker

set tabstop=2
set expandtab
set smarttab
set softtabstop=4

set laststatus=2
set cindent
set smartindent
set autoindent
set hi=1000
set title
set titleold=Powered-by-WalkingDead

set mouse=r

set hls
set scs

"colorscheme twilight
"colorscheme molokai
colorscheme molokai

syntax on

set nobackup
set ignorecase
set smartcase

set showmatch
set ai
set nu

map<F2> gT
map<F3> gt
"map<F4> :w <CR> :e <CR>
"map<F6> :w <CR> :! gcc -g -lm -Wall -O3 -std=c99 % && time ./a.out <CR>
"map<F7> :w <CR> :! make && ./a.out<CR>
"map<F8> :w <CR> :bel sp \| resize 20 \| term g++ -DLUCENT_LOCAL -g -Wall -O3 -std=c++14 % -lm     -lGL -lglut; zsh <CR>
"map<F9> :w <CR> :bel sp \| resize 10 \| term python % <CR>
""map<F10> :w <CR> :! texliveonfly % <CR>
"map<F10> :w <CR> :bel sp \| resize 10 \| term spin % <CR>
"map bn :rightb vsp \| FufFile <CR>
map tn :tabnew \| FufFile <CR>
"map tq :q <CR>
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))

"ALT + {HJKL} TO MOVE BETWEEN BUFFERS (INCLUDING TERMINAL BUFFERS)
if has('nvim')
    :tnoremap <A-h> <C-\><C-n><C-w>h
    :tnoremap <A-j> <C-\><C-n><C-w>j
    :tnoremap <A-k> <C-\><C-n><C-w>k
    :tnoremap <A-l> <C-\><C-n><C-w>l
endif

:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l


set mouse=a

set clipboard=unnamedplus

nmap <C-\> :NERDTreeToggle<CR>

let g:LanguageClient_serverCommands = {
  \ 'javascript': ['javascript-typescript-stdio'],
  \ 'javascript.jsx': ['javascript-typescript-stdio'],
  \}

autocmd FileType javascript map <C-]> :call LanguageClient#textDocument_definition()<CR>
autocmd FileType javascript.jsx map <C-]> :call LanguageClient#textDocument_definition()<CR>

set noswapfile

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
nmap ’ :bnext<CR>
nmap <M-}> :bnext<CR>
nmap ” :bprevious<CR>
nmap <M-{> :bprevious<CR>
nmap † :enew<CR>
nmap <M-t> :enew<CR>
nmap œ :BD<CR>
nmap <M-q> :BD<CR>
nmap <C-p> :FZF<CR>
set tags=/home/team50b/Pintos/src/tags
