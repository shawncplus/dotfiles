" Yaml indentation and tab correction
autocmd FileType yaml set foldmethod=indent
autocmd FileType yaml set foldcolumn=4
hi link yamlTab Error
autocmd FileType yaml match yamlTab /\t\+/
autocmd FileType yaml autocmd BufWritePre <buffer> :call CheckTabs()

autocmd FileType yaml noremap <F5> :s/^/#/<CR>
autocmd FileType yaml noremap <F6> :s/^#//<CR>
