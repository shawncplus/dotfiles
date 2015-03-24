"============== General Settings ===============
set dict=/usr/share/dict/words
set cursorline
set showcmd
set ruler
set incsearch
set wildmenu
syntax enable
set synmaxcol=0
set term=screen-256color
set display=uhex
set shortmess=aAIsT
set cmdheight=2
set nowrap
if &diff
	set wrap
endif
set diffopt+=iwhite
let &scrolloff=999-&scrolloff
set smartcase
set relativenumber
set nowritebackup

set completeopt=menu
set mousemodel=popup
set backspace=2
set number
set nocompatible

" Hack to make sql in php hilighting suck less
let sql_type_default = 'sqlanywhere'

set enc=utf-8
set fillchars=vert:¦

set expandtab
set tabstop=4
set shiftwidth=4
set foldcolumn=1
set cc=+1,+2

set linespace=0
set history=1000
set list listchars=tab:› ,trail:-,extends:>,precedes:<,eol:¬

set laststatus=2
set ffs=unix,dos
set mouse=a
set vb
set ttym=xterm2

set wrap

set tags=./tags

if version > 720
	set undofile
	set undodir=~/vimundo/
endif

let mapleader='\'
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

let g:vdebug_options= {
	\    "port" : 9000,
	\    "server" : 'localhost',
	\    "timeout" : 20,
	\    "on_close" : 'detach',
	\    "break_on_open" : 1,
	\    "ide_key" : '',
	\    "path_maps" : {},
	\    "debug_window_level" : 0,
	\    "debug_file_level" : 0,
	\    "debug_file" : "",
	\    "watch_window_style" : 'compact',
	\    "marker_default" : '*',
	\    "marker_closed_tree" : '+',
	\    "marker_open_tree" : '━',
	\    "continuous_mode" : 0
\}


let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 0

let g:phpcomplete_parse_docblock_comments = 1

let g:indent_guides_auto_colors = 0
let g:indent_guides_color_change_percent = 10
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235
let g:indent_guides_space_guides = 1
let g:indent_guides_guide_size = 1
"
let g:gitgutter_sign_modified = '≈ '
let g:gitgutter_sign_removed = '⌐ '
