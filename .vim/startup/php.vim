" PHP Stuff
autocmd FileType php let php_folding = 1
autocmd FileType php let php_parent_error_close = 1
autocmd FileType php let php_parent_error_open = 1
autocmd FileType php let php_large_files = 0

autocmd FileType php noremap \fb :silent! exe "s/$/\rfb(" . expand('<cword>') . ", '" . expand('<cword>') . "');/e" \| silent! exe "noh"<CR>
autocmd FileType php noremap \ft :call append(line('.'), 'FirePHP::getInstance(true)->trace(__FUNCTION__);')<CR>
autocmd FileType php set kp=phpdoc

let g:php_smart_members=1
let g:php_alt_properties=1
let g:php_smart_semicolon=1
let g:php_alt_construct_parents=1

"============== Custom Menu Items (GUI Only) ===============
autocmd FileType php menu Syntax.PHP.Check :call CheckPHPSyntax()<CR>
autocmd FileType php menu Format.Whitespace.Concatenation :%s/\([^\. ]\)\.\([^\. ]*\)\.\([^\. ]\)/\=submatch(1).' . '.submatch(2).' . '.submatch(3)/g<CR>

autocmd FileType php command! Fix :silent !php-cs-fixer fix %
