"============== Custom Commands ===============
command -nargs=0 Sinit :call <SID>Sinit('%:p:h')
command -nargs=? W :w <args>
augroup AutoMkdir
	autocmd!
	autocmd  BufWritePre  *  :call EnsureDirExists()
augroup END

command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
