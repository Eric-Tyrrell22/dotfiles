set nocompatible

syntax on
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

" Uncomment the following to have Vim jump to the last position when                                                       
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
