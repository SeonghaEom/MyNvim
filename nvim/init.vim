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
Plug 'qpkorr/vim-bufkill'

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
  \ 'cpp': ['cquery', '--log-file=/tmp/cq.log'],
  \ 'c': ['cquery', '--log-file=/tmp/cq.log'],
  \}
let g:LanguageClient_settingsPath = '/home/YOUR_USERNAME/.config/nvim/settings.json'
set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()

nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> gs :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

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


function! s:line_handler(l)
  let keys = split(a:l, ':\t')
  exec 'buf' keys[0]
  exec keys[1]
  normal! ^zz
endfunction

function! s:buffer_lines()
  let res = []
  for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    call extend(res, map(getbufline(b,0,"$"), 'b . ":\t" . (v:key + 1) . ":\t" . v:val '))
  endfor
  return res
endfunction

command! FZFLines call fzf#run({
\   'source':  <sid>buffer_lines(),
\   'sink':    function('<sid>line_handler'),
\   'options': '--extended --nth=3..',
\   'down':    '60%' 
\})

function! s:ag_to_qf(line)
  let parts = split(a:line, ':')
  return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
        \ 'text': join(parts[3:], ':')}
endfunction

function! s:ag_handler(lines)
  if len(a:lines) < 2 | return | endif

  let cmd = get({'ctrl-x': 'split',
               \ 'ctrl-v': 'vertical split',
               \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
  let list = map(a:lines[1:], 's:ag_to_qf(v:val)')

  let first = list[0]
  execute cmd escape(first.filename, ' %#\')
  execute first.lnum
  execute 'normal!' first.col.'|zz'

  if len(list) > 1
    call setqflist(list)
    copen
    wincmd p
  endif
endfunction

command! -nargs=* Ag call fzf#run({
\ 'source':  printf('ag --nogroup --column --color "%s"',
\                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
\ 'sink*':    function('<sid>ag_handler'),
\ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
\            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
\            '--color hl:68,hl+:110',
\ 'down':    '50%'
\ })



