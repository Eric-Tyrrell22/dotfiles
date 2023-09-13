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

" set swapfiles
" https://stackoverflow.com/a/21026618
set directory=$HOME/.vim/swapfiles//

" messing with the path
set path+=**
let gitpath=system("git rev-parse --show-toplevel")
set path+=gitpath

" Uncomment the following to have Vim jump to the last position when                                                       
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif

  " autoload template files
  augroup templates
    autocmd BufNewFile *.vue 0r ~/.vim/templates/skeleton.vue
    autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
  augroup end
endif

let g:coc_config_home = "~/.vim/coc-settings"

" Plguins
" Download vim plug if not there already
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"CoC auto
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
		  \ pumvisible() ? "\<C-n>" :
		  \ <SID>check_back_space() ? "\<TAB>" :
		  \ coc#refresh()

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

let g:coc_global_extensions = ['coc-solargraph']

call plug#begin('~/.vim/plugged')

Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Allows changing pairs of brackets easily using cs)]
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pangloss/vim-javascript'
Plug 'dense-analysis/ale'

call plug#end()

" ale
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

let g:ale_fixers = { 'javascript': ['eslint'] }

let g:ale_fix_on_save = 1

let b:ale_linter_aliases = ['javascript', 'vue']
let b:ale_linters = ['eslint', 'vls']

" mappings

inoremap jj <Esc>
nnoremap ; :
nnoremap : ;

# pane management
nnoremap <C-w>s <C-w>s<C-w>w
nnoremap <C-w>v <C-w>v<C-w>w

# paste management
nnoremap <C-S-v> :set paste<CR>o<Esc>"*p:set nopaste<CR>
