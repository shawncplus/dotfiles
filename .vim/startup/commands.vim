"============== Custom Commands ===============
command! -nargs=0 Sinit :call <SID>Sinit('%:p:h')
command! -nargs=? W :w <args>
augroup AutoMkdir
	autocmd!
	autocmd  BufWritePre  *  :call EnsureDirExists()
augroup END

command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

command! JShint 80vnew +setlocal\ buftype=nofile\ bufhidden=hide\ noswapfile | r !jshint # --show-non-errors
command! CR 80vnew +setlocal\ buftype=nofile\ bufhidden=hide\ noswapfile | r !php-cs-fixer fix # --diff --dry-run -vvv
