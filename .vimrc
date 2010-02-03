set ruler
set wildmenu
syntax enable
set synmaxcol=0
set term=xterm-256color
set display=uhex
set shortmess=aAIsT
set completeopt=menu
set mousemodel=popup
set bs=2
set nu
set tabstop=4
set shiftwidth=4
set linespace=0
set history=1000

color skittles_dark
source ~/.vim/after/syntaxcheck.vim
source ~/.vim/after/dbsettings.vim

filetype plugin on
filetype indent on

set list listchars=tab:>-,extends:>,trail:$,precedes:<

hi Todo guifg=#007ba7 guibg=#242424 gui=bold,italic

" Yaml indentation and tab correction
autocmd FileType yaml :set foldmethod=indent
autocmd FileType yaml :set foldcolumn=4
autocmd FileType yaml :match yamlTab /\t\+/
autocmd FileType yaml autocmd BufWritePre <buffer> :call CheckTabs()


" Remove trailing whitespace
"autocmd FileType c,cpp,java,php,yaml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
"autocmd FileType c,cpp,java,php,yaml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"^\\s\\+$","","")'))


" show PHP function reference on CTRL+P in Visual mode
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

noremap  :Sinit

" VCS Shortcuts
"CTRL-O toggles code outline
" noremap  :TlistToggle
" vnoremap  :TlistToggle
"CTRL-D does a VimDiff
noremap  :VCSVimDiff
vnoremap  :VCSVimDiff
inoremap  :VCSVimDiff

noremap  :VCSGotoOriginal!
vnoremap  :VCSGotoOriginal!
inoremap  :VCSGotoOriginal!

noremap <F7> :set expandtab!

" PHP Stuff
autocmd FileType php let php_folding = 1
autocmd FileType php let php_noShortTags = 1
autocmd FileType php let php_parent_error_close = 1
autocmd FileType php let php_parent_error_open = 1


" VCS settings
let VCSCommandSplit = 'vertical'

" TagList settings
let Tlist_Compact_Format = 0
let Tlist_Close_On_Select = 1
let Tlist_Show_One_File = 0
let Tlist_Show_Menu = 1

"Custom menu items
"  php Specific
autocmd FileType php menu Syntax.PHP.Check :call CheckPHPSyntax()
autocmd FileType php menu Format.Whitespace.Concatenation :%s/\([^\. ]\)\.\([^\. ]*\)\.\([^\. ]\)/\=submatch(1).' . '.submatch(2).' . '.submatch(3)/g
"  General

fun! Format_WhiteSpace_RemoveTrailing()
	call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
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

" hi User1 guifg=#FF0000 guibg=bg gui=bold

" comment selected lines
autocmd FileType yaml noremap <F5> :s/^/#/
autocmd FileType yaml noremap <F6> :s/^#//
autocmd FileType php,c,cpp noremap <F5> :s+^+//+
autocmd FileType php,c,cpp noremap <F6> :s+^//++
autocmd FileType vim noremap <F5> :s/^/"/
autocmd FileType vim noremap <F6> :s/^"//

set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set laststatus=2

let g:snippetsEmu_key = "<S-Tab>"

" Give us a shortcut for the blackhole buffer
map  "_

"use unix line-endings, fuck those \r's
set ffs=unix

" evil K
nmap K <Esc>

" firebug fb(), FirePHP, and console.log
autocmd FileType php noremap \fb :silent! exe "s/$/\rfb(" . expand('<cword>') . ", '" . expand('<cword>') . "');/e" \| silent! exe "noh"
autocmd FileType php noremap \ft :call append(line('.'), 'FirePHP::getInstance(true)->trace(__FUNCTION__);')
autocmd FileType javascript noremap <F4> :silent exe "s/\\v^(\\s*)(.+)$/\\1\\2\r\\1console.log(" . expand('<cword>') . ", '" . expand('<cword>') . "');"

" PHP settings
let g:php_smart_members=1
let g:php_alt_properties=1
let g:php_smart_semicolon=1
let g:php_alt_construct_parents=1

"stupid mouse
set mouse=a

" screen stuff
fun! s:Sinit(filen)
    echo expand(a:filen)
    exec "ScreenShell cd " . expand(a:filen) . "; \\clear"
endfun

command -nargs=0 Sinit :call <SID>Sinit('%:p:h')
command -nargs=? W :w <args>

if &diff
"	set diffopt+=iwhite
endif

" Return prompt to user after this many miliseconds without any new output
" from the terminal.
" " Increasing this value will cause fewer read timeouts, but will also make
" the terminal appear less responsive.
let g:Conque_Read_Timeout = 40

" Use this syntax type with Conque. The default is relatively stripped down,
"although it does provide good MySQL highlighting
let g:Conque_Syntax = 'conque'

" Terminal identification
" Leaving this value as "dumb" may make the terminal slightly faster.
" Setting it to "xterm" will enable more features.
let g:Conque_TERM = 'xterm' 
