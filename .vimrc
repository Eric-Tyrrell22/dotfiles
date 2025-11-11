set nocompatible

syntax on
filetype plugin on
filetype plugin indent on
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

set ttyfast
set number
set scrolloff=8
set signcolumn=yes

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

" Plguins
" Download vim plug if not there already
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" CoC completion settings - prevent overwriting existing code
" Use Tab to trigger and navigate completion
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_global_extensions = ['coc-solargraph', 'coc-tsserver', 'coc-json']

call plug#begin('~/.vim/plugged')

Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Allows changing pairs of brackets easily using cs)]
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pangloss/vim-javascript'
Plug 'dense-analysis/ale'
Plug 'rose-pine/vim'
Plug 'tpope/vim-commentary'

call plug#end()

" Set Rose Pine colorscheme
colorscheme rosepine

" ale
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'typescript': ['eslint', 'prettier'],
\   'typescriptreact': ['eslint', 'prettier']
\}

let g:ale_fix_on_save = 1

let g:ale_linters = {
\   'yaml': ['yamllint'],
\   'javascript': ['eslint'],
\   'javascript.jsx': ['eslint'],
\   'typescript': ['eslint', 'tsserver'],
\   'typescriptreact': ['eslint', 'tsserver']
\}

" mappings

inoremap jj <Esc>
nnoremap ; :
nnoremap : ;

" pane management
nnoremap <C-w>s <C-w>s<C-w>w
nnoremap <C-w>v <C-w>v<C-w>w

" paste management
nnoremap <C-S-v> :set paste<CR>o<Esc>"*p:set nopaste<CR>

" CoC TypeScript keybindings
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Applying codeAction to the selected region
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:OR` command for organize imports
command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')
