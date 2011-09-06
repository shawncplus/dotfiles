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

set enc=utf-8
set fillchars=vert:¦

set noexpandtab
set tabstop=4
set shiftwidth=4
set foldcolumn=1

set linespace=0
set history=1000
set list listchars=tab:› ,trail:-,extends:>,precedes:<,eol:¬

let mapleader='\'

" Statusline {{{
	" Functions {{{
		" Statusline updater {{{
			" Inspired by StatusLineHighlight by Ingo Karkat
			function! s:StatusLine(new_stl, type, current)
				let current = (a:current ? "" : "NC")
				let type = a:type
				let new_stl = a:new_stl

				" Prepare current buffer specific text
				" Syntax: <CUR> ... </CUR>
				let new_stl = substitute(new_stl, '<CUR>\(.\{-,}\)</CUR>', (a:current ? '\1' : ''), 'g')

				" Prepare statusline colors
				" Syntax: #[ ... ]
				let new_stl = substitute(new_stl, '#\[\(\w\+\)\]', '%#StatusLine'.type.'\1'.current.'#', 'g')

				if &l:statusline ==# new_stl
					" Statusline already set, nothing to do
					return
				endif

				if empty(&l:statusline)
					" No statusline is set, use my_stl
					let &l:statusline = new_stl
				else
					" Check if a custom statusline is set
					let plain_stl = substitute(&l:statusline, '%#StatusLine\w\+#', '', 'g')

					if &l:statusline ==# plain_stl
						" A custom statusline is set, don't modify
						return
					endif

					" No custom statusline is set, use my_stl
					let &l:statusline = new_stl
				endif
			endfunction
		" }}}
		" Color dict parser {{{
			function! s:StatusLineColors(colors)
				for type in keys(a:colors)
					for name in keys(a:colors[type])
						let colors = {'c': a:colors[type][name][0], 'nc': a:colors[type][name][1]}
						let type = (type == 'NONE' ? '' : type)
						let name = (name == 'NONE' ? '' : name)

						if exists("colors['c'][0]")
							exec 'hi StatusLine'.type.name.' ctermbg='.colors['c'][0].' ctermfg='.colors['c'][1].' cterm='.colors['c'][2]
						endif

						if exists("colors['nc'][0]")
							exec 'hi StatusLine'.type.name.'NC ctermbg='.colors['nc'][0].' ctermfg='.colors['nc'][1].' cterm='.colors['nc'][2]
						endif
					endfor
				endfor
			endfunction
		" }}}
	" }}}
	" Default statusline {{{
		let g:default_stl  = ""
		let g:default_stl .= "<CUR>#[Mode] %{&paste ? 'PASTE  ' : ''}%{substitute(mode(), '', '', 'g')} #[ModeS]</CUR>"
		let g:default_stl .= "#[ModFlag]%{&readonly ? 'RO ' : ''}" " RO flag
		let g:default_stl .= " #[FileName]%t " " File name
		let g:default_stl .= "#[ModFlag]%(%M %)" " Modified flag
		let g:default_stl .= "#[BufFlag]%(%H%W %)" " HLP,PRV flags
		let g:default_stl .= "#[FileNameS] " " Separator
		let g:default_stl .= "#[FunctionName] " " Padding/HL group
		let g:default_stl .= "%<" " Truncate right
		let g:default_stl .= "%= " " Right align
		let g:default_stl .= "<CUR>#[FileFormat]%{&fileformat} </CUR>" " File format
		let g:default_stl .= "<CUR>#[FileEncoding]%{(&fenc == '' ? &enc : &fenc)} </CUR>" " File encoding
		let g:default_stl .= "<CUR>#[Separator]  ⊂ #[FileType]%{strlen(&ft) ? &ft : 'n/a'} </CUR>" " File type
		let g:default_stl .= "#[LinePercentS] #[LinePercent] %p%% " " Line/column/virtual column, Line percentage
		let g:default_stl .= "#[LineNumberS] #[LineNumber]  %l#[LineColumn]:%c%V " " Line/column/virtual column, Line percentage
		let g:default_stl .= "%{exists('g:synid') && g:synid ? ' '.synIDattr(synID(line('.'), col('.'), 1), 'name').' ' : ''}" " Current syntax group
	" }}}
	" Color dict {{{
		let s:statuscolors = {
			\   'NONE': {
				\   'NONE'         : [[ 236, 231, 'bold'], [ 232, 244, 'none']]
			\ }
			\ , 'Normal': {
				\   'Mode'         : [[ 214, 235, 'bold'], [                 ]]
				\ , 'ModeS'        : [[ 214, 240, 'bold'], [                 ]]
				\ , 'Branch'       : [[ 240, 250, 'none'], [ 234, 239, 'none']]
				\ , 'BranchS'      : [[ 240, 246, 'none'], [ 234, 239, 'none']]
				\ , 'FileName'     : [[ 240, 231, 'bold'], [ 234, 244, 'none']]
				\ , 'FileNameS'    : [[ 240, 236, 'bold'], [ 234, 232, 'none']]
				\ , 'Error'        : [[ 240, 202, 'bold'], [ 234, 239, 'none']]
				\ , 'ModFlag'      : [[ 240, 196, 'bold'], [ 234, 239, 'none']]
				\ , 'BufFlag'      : [[ 240, 250, 'none'], [ 234, 239, 'none']]
				\ , 'FunctionName' : [[ 236, 247, 'none'], [ 232, 239, 'none']]
				\ , 'FileFormat'   : [[ 236, 244, 'none'], [ 232, 239, 'none']]
				\ , 'FileEncoding' : [[ 236, 244, 'none'], [ 232, 239, 'none']]
				\ , 'Separator'    : [[ 236, 242, 'none'], [ 232, 239, 'none']]
				\ , 'FileType'     : [[ 236, 248, 'none'], [ 232, 239, 'none']]
				\ , 'LinePercentS' : [[ 240, 236, 'none'], [ 234, 232, 'none']]
				\ , 'LinePercent'  : [[ 240, 250, 'none'], [ 234, 239, 'none']]
				\ , 'LineNumberS'  : [[ 252, 240, 'bold'], [ 234, 234, 'none']]
				\ , 'LineNumber'   : [[ 252, 236, 'bold'], [ 234, 244, 'none']]
				\ , 'LineColumn'   : [[ 252, 240, 'none'], [ 234, 239, 'none']]
			\ }
			\ , 'Insert': {
				\   'Mode'         : [[ 153,  23, 'bold'], [                 ]]
				\ , 'ModeS'        : [[ 153,  31, 'bold'], [                 ]]
				\ , 'Branch'       : [[  31, 117, 'none'], [                 ]]
				\ , 'BranchS'      : [[  31, 117, 'none'], [                 ]]
				\ , 'FileName'     : [[  31, 231, 'bold'], [                 ]]
				\ , 'FileNameS'    : [[  31,  24, 'bold'], [                 ]]
				\ , 'Error'        : [[  31, 202, 'bold'], [                 ]]
				\ , 'ModFlag'      : [[  31, 196, 'bold'], [                 ]]
				\ , 'BufFlag'      : [[  31,  75, 'none'], [                 ]]
				\ , 'FunctionName' : [[  24, 117, 'none'], [                 ]]
				\ , 'FileFormat'   : [[  24,  75, 'none'], [                 ]]
				\ , 'FileEncoding' : [[  24,  75, 'none'], [                 ]]
				\ , 'Separator'    : [[  24,  37, 'none'], [                 ]]
				\ , 'FileType'     : [[  24,  81, 'none'], [                 ]]
				\ , 'LinePercentS' : [[  31,  24, 'none'], [                 ]]
				\ , 'LinePercent'  : [[  31, 117, 'none'], [                 ]]
				\ , 'LineNumberS'  : [[ 117,  31, 'bold'], [                 ]]
				\ , 'LineNumber'   : [[ 117,  23, 'bold'], [                 ]]
				\ , 'LineColumn'   : [[ 117,  31, 'none'], [                 ]]
			\ }
		\ }
	" }}}
" }}}

" Statusline highlighting {{{
augroup StatusLineHighlight
	autocmd!

	let s:round_stl = 0

	au ColorScheme * call <SID>StatusLineColors(s:statuscolors)
	au BufEnter,BufWinEnter,WinEnter,CmdwinEnter,CursorHold,BufWritePost,InsertLeave * call <SID>StatusLine((exists('b:stl') ? b:stl : g:default_stl), 'Normal', 1)
	au BufLeave,BufWinLeave,WinLeave,CmdwinLeave * call <SID>StatusLine((exists('b:stl') ? b:stl : g:default_stl), 'Normal', 0)
	au InsertEnter,CursorHoldI * call <SID>StatusLine((exists('b:stl') ? b:stl : g:default_stl), 'Insert', 1)
augroup END
" }}}

augroup General " {{{
	autocmd!
	" Help file settings {{{
		function! s:SetupHelpWindow()
			wincmd L
			vertical resize 80
			setl nonumber winfixwidth colorcolumn=

			let b:stl = "#[Branch] HELP#[BranchS] [>] #[FileName]%<%t #[FileNameS][>>]%* %=#[LinePercentS][<<]#[LinePercent] %p%% " " Set custom statusline

			nnoremap <buffer> <Space> <C-]> " Space selects subject
			nnoremap <buffer> <BS>    <C-T> " Backspace to go back
		endfunction

		au FileType help au BufEnter,BufWinEnter <buffer> call <SID>SetupHelpWindow()
	" }}}
augroup END " }}}

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

no <down> ddp
no <left> <Nop>
no <right> <Nop>
no <up> ddkP
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>
vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>

"Pathogen
call pathogen#runtime_append_all_bundles()

"============== Color Settings ===============
"color wombat256
"color xterm16
"color railscasts
"color molokai
color skittles_dark


"============== Custom scripts ===============
source ~/.vim/after/syntaxcheck.vim


"============== Filetype stuff ===============
filetype plugin on
filetype indent on

" Yaml indentation and tab correction
autocmd FileType yaml :set foldmethod=indent
autocmd FileType yaml :set foldcolumn=4
autocmd FileType yaml :match yamlTab /\t\+/
autocmd FileType yaml autocmd BufWritePre <buffer> :call CheckTabs()

" PHP Stuff
autocmd FileType php let php_folding = 1
autocmd FileType php let php_noShortTags = 1
autocmd FileType php let php_parent_error_close = 1
autocmd FileType php let php_parent_error_open = 1
autocmd FileType php let php_large_files = 0

" comment selected lines
autocmd FileType yaml noremap <F5> :s/^/#/<CR>
autocmd FileType yaml noremap <F6> :s/^#//<CR>
autocmd FileType php,c,cpp noremap <F5> :s+^+//+<CR>
autocmd FileType php,c,cpp noremap <F6> :s+^//++<CR>
autocmd FileType vim noremap <F5> :s/^/"/<CR>
autocmd FileType vim noremap <F6> :s/^"//<CR>

" firebug fb(), FirePHP, and console.log
autocmd FileType php noremap \fb :silent! exe "s/$/\rfb(" . expand('<cword>') . ", '" . expand('<cword>') . "');/e" \| silent! exe "noh"<CR>
autocmd FileType php noremap \ft :call append(line('.'), 'FirePHP::getInstance(true)->trace(__FUNCTION__);')<CR>
autocmd FileType javascript noremap <F4> :silent exe "s/\\v^(\\s*)(.+)$/\\1\\2\r\\1console.log(" . expand('<cword>') . ", '" . expand('<cword>') . "');"<CR>

autocmd FileType php set kp=phpdoc

"============== Custom Mappings ===============
" general mapping
nmap <C-Tab> :tabnext<CR>
nmap <C-S-Tab> :tabprevious<CR>
map <C-S-Tab> :tabprevious<CR>
map <C-Tab> :tabnext<CR>
imap <C-S-Tab> <ESC>:tabprevious<CR>
imap <C-Tab> <ESC>:tabnext<CR>
noremap <F7> :set expandtab!<CR>

"custom comma motion mapping
nmap di, f,dT,
nmap ci, f,cT,
nmap da, f,ld2F,i,<ESC>l "delete argument 
nmap ca, f,ld2F,i,<ESC>a "delete arg and insert

" delete surrounding characters
noremap ds{ F{xf}x
noremap cs{ F{xf}xi
noremap ds" F"x,x
noremap cs" F"x,xi
noremap ds' F'x,x
noremap cs' F'x,xi
noremap ds( F(xf)x
noremap cs( F(xf)xi
noremap ds) F(xf)x
noremap cs) F(xf)xi

nmap cu ct_
nmap cU cf_

" upper or lowercase the current word
nmap g^ gUiW
nmap gv guiW

" diff
nmap ]c ]czz
nmap [c [czz

" default to very magic
no / /\v

" gO to create a new line below cursor in normal mode
nmap gO o<ESC>k
" g<Ctrl+o> to create a new line above cursor (Ctrl to prevent collision with 'go' command)
nmap g<C-O> O<ESC>j

"I really hate that things don't auto-center
nmap G Gzz
nmap n nzz
nmap N Nzz
nmap } }zz
nmap { {zz

"open tag in new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

"quick pairs
imap <leader>' ''<ESC>i
imap <leader>" ""<ESC>i
imap <leader>( ()<ESC>i
imap <leader>[ []<ESC>i


"============== Script configs ===============
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


"============== Custom Menu Items (GUI Only) ===============
autocmd FileType php menu Syntax.PHP.Check :call CheckPHPSyntax()<CR>
autocmd FileType php menu Format.Whitespace.Concatenation :%s/\([^\. ]\)\.\([^\. ]*\)\.\([^\. ]\)/\=submatch(1).' . '.submatch(2).' . '.submatch(3)/g<CR>


"============== Custom Functions ===============
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


"============== Custom Commands ===============
command -nargs=0 Sinit :call <SID>Sinit('%:p:h')
command -nargs=? W :w <args>
augroup AutoMkdir
	autocmd!
	autocmd  BufWritePre  *  :call EnsureDirExists()
augroup END

command -nargs=? Qa :qa

command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
