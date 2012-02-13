"============== General Settings ===============
set dict=/usr/share/dict/words
set cursorline
set showcmd
set ruler
set incsearch
set wildmenu
syntax enable
set synmaxcol=0
set term=xterm-256color
set display=uhex
set shortmess=aAIsT
set cmdheight=2
set nowrap
if &diff
	set wrap
endif

set completeopt=menu
set mousemodel=popup
set backspace=2
set number
set nocompatible

set enc=utf-8
set fillchars=vert:¦

set noexpandtab
set tabstop=4
set shiftwidth=4
set foldcolumn=1

set linespace=0
set history=1000
set list listchars=tab:› ,trail:-,extends:>,precedes:<,eol:¬

set laststatus=2
set ffs=unix
set mouse=a
set vb
set ttym=xterm2

set wrap

set tags=~/.vim/tags/tags

if version > 720
	set undofile
	set undodir=~/vimundo/
endif

let mapleader='\'

