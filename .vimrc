set nocompatible

syntax on
filetype plugin on

set ttyfast
set number

set wildmenu

set expandtab
set tabstop=2
set shiftwidth=2

set showcmd
set laststatus=2
set ruler

set incsearch
set hlsearch

set ignorecase
set smartcase
set showmatch

set backspace=indent,eol,start

set autoindent

set noerrorbells

" messing with the path
set path+=**
let gitpath=system("git rev-parse --show-toplevel")
set path+=gitpath

" Uncomment the following to have Vim jump to the last position when                                                       
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Plguins
" Download vim plug if not there already
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'mileszs/ack.vim'

call plug#end()

" mappings

inoremap jj <Esc>
nnoremap ; :
nnoremap : ;
