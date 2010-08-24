"============== General Settings ==============="
set dict=/usr/share/dict/words
set cursorline
set showcmd
set ruler
set wildmenu
syntax enable
set synmaxcol=0
set term=xterm-256color
set display=uhex
set shortmess=aAIsT
set cmdheight=2
set nowrap
set completeopt=menu
set mousemodel=popup
set backspace=2
set number

set noexpandtab
set tabstop=4
set shiftwidth=4

set linespace=0
set history=1000
set list listchars=tab:» ,trail:-,extends:>,precedes:<
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set laststatus=2
set ffs=unix
set mouse=a

set wrap

set tags=~/.vim/tags/tags

"============== Force myself to use hjkl"
"noremap OA <Nop>
"noremap OD <Nop>
"noremap OC <Nop>
"noremap OB <Nop>
"
"inoremap OA <Nop>
"inoremap OD <Nop>
"inoremap OC <Nop>
"inoremap OB <Nop>
"
"vnoremap OA <Nop>
"vnoremap OD <Nop>
"vnoremap OC <Nop>
"vnoremap OB <Nop>

"============== Color Settings ==============="
"color wombat256
"color xterm16
"color railscasts
"color molokai
color skittles_dark


"============== Custom scripts ==============="
source ~/.vim/after/syntaxcheck.vim
source ~/.vim/after/dbsettings.vim


"============== Filetype stuff ==============="
filetype plugin on
filetype indent on

" Yaml indentation and tab correction
autocmd FileType yaml :set foldmethod=indent
autocmd FileType yaml :set foldcolumn=4
autocmd FileType yaml :match yamlTab /\t\+/
autocmd FileType yaml autocmd BufWritePre <buffer> :call CheckTabs()

" PHP Stuff
autocmd FileType php let php_folding = 0
autocmd FileType php let php_noShortTags = 1
autocmd FileType php let php_parent_error_close = 1
autocmd FileType php let php_parent_error_open = 1
autocmd FileType php let php_large_files = 0

" comment selected lines
autocmd FileType yaml noremap <F5> :s/^/#/
autocmd FileType yaml noremap <F6> :s/^#//
autocmd FileType php,c,cpp noremap <F5> :s+^+//+
autocmd FileType php,c,cpp noremap <F6> :s+^//++
autocmd FileType vim noremap <F5> :s/^/"/
autocmd FileType vim noremap <F6> :s/^"//

" firebug fb(), FirePHP, and console.log
autocmd FileType php noremap \fb :silent! exe "s/$/\rfb(" . expand('<cword>') . ", '" . expand('<cword>') . "');/e" \| silent! exe "noh"
autocmd FileType php noremap \ft :call append(line('.'), 'FirePHP::getInstance(true)->trace(__FUNCTION__);')
autocmd FileType javascript noremap <F4> :silent exe "s/\\v^(\\s*)(.+)$/\\1\\2\r\\1console.log(" . expand('<cword>') . ", '" . expand('<cword>') . "');"


"============== Custom Mappings ==============="
nmap  :!php --rf <cword>
nmap  :q!
nmap <C-Tab> :tabnext
nmap <C-S-Tab> :tabprevious
map <C-S-Tab> :tabprevious
map <C-Tab> :tabnext
imap <C-S-Tab> :tabprevious
imap <C-Tab> :tabnext
noremap  :promptfind
vnoremap  :promptfind
inoremap  :promptfind
noremap  :undo
vnoremap  :undo
inoremap  :undo
noremap  :redo
vnoremap  :redo
inoremap  :redo
noremap  :update
vnoremap  :update
inoremap  :update

noremap  :VCSVimDiff
vnoremap  :VCSVimDiff
inoremap  :VCSVimDiff
noremap  :VCSGotoOriginal!
vnoremap  :VCSGotoOriginal!
inoremap  :VCSGotoOriginal!
noremap <F7> :set expandtab!

" Give a shortcut for the blackhole buffer
map  "_
nmap g^ g~iW

"open tag in new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>


"============== Script configs ==============="
let VCSCommandSplit = 'vertical'

let Tlist_Compact_Format = 0
let Tlist_Close_On_Select = 1
let Tlist_Show_One_File = 0
let Tlist_Show_Menu = 1
let g:snippetsEmu_key = "<S-Tab>"

let g:Conque_Read_Timeout = 40
let g:Conque_Syntax = 'conque'
let g:Conque_TERM = 'xterm' 

let g:php_smart_members=1
let g:php_alt_properties=1
let g:php_smart_semicolon=1
let g:php_alt_construct_parents=1

let g:SuperTabDefaultCompletionType = ""


"============== Custom Menu Items (GUI Only) ==============="
autocmd FileType php menu Syntax.PHP.Check :call CheckPHPSyntax()
autocmd FileType php menu Format.Whitespace.Concatenation :%s/\([^\. ]\)\.\([^\. ]*\)\.\([^\. ]\)/\=submatch(1).' . '.submatch(2).' . '.submatch(3)/g


"============== Custom Functions ==============="
fun! Format_WhiteSpace_RemoveTrailing()
	:%s/\v\s*$//g
endfun

fun! Format_Inflection_ToCamelCase()
	:s/\v([a-z])_([a-z])/\1\u\2/g
endfun

fun! Format_Inflection_ToUnderscored()
	:s/\v([a-z])([A-Z])/\L\1_\2/g
endfun

fun! CheckTabs()
  if search("\t") != 0
    echohl ErrorMsg | ec "                                 !WARNING!                              "
     \ |              ec "There are tabs in the file, do you want to convert them to spaces? [Y/n]" | echohl None
    let choice = nr2char(getchar())
    if choice == 'y' || choice == "\<CR>"
      retab 2
    endif
  else
   return
  endif
endfun

function! EnsureDirExists ()
	let required_dir = expand("%:h")
	if !isdirectory(required_dir)
		call mkdir(required_dir, 'p')
	endif
endfunction

" screen stuff
fun! s:Sinit(filen)
    echo expand(a:filen)
    exec "ScreenShell cd " . expand(a:filen) . "; \\clear"
endfun


"============== Custom Commands ==============="
command -nargs=0 Sinit :call <SID>Sinit('%:p:h')
command -nargs=? W :w <args>
augroup AutoMkdir
	autocmd!
	autocmd  BufNewFile  *  :call EnsureDirExists()
augroup END

command -nargs=? Qa :qa
