"Bennos VimRC
set autoread
set number
set ruler

syntax enable
set encoding=utf8

set ffs=unix,dos,mac

set wrap

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'vim-syntastic/syntastic'
Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'
Plug 'tpope/vim-fugitive'
Plug 'kien/ctrlp.vim'
Plug 'altercation/vim-colors-solarized'
"Plug 'valloric/youcompleteme'
call plug#end()

let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled = 1
let g:solarized_termcolors=256

syntax enable
set background=dark
colorscheme solarized
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled = 1
