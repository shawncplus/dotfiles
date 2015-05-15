augroup filetype_html
    autocmd!
    " Angular and angular bootstrap tag highlighting
    autocmd FileType html,twig syn match htmlTagN contained +<\s*[-a-zA-Z0-9]\++hs=s+1 contains=htmlTagName,htmlSpecialTagName,@htmlTagNameCluster,angularTagName
    autocmd FileType html,twig syn match htmlTagN contained +</\s*[-a-zA-Z0-9]\++hs=s+2 contains=htmlTagName,htmlSpecialTagName,@htmlTagNameCluster,angularTagName
    autocmd FileType html,twig syn region htmlTag start=+<[^/]+ end=+>+ fold contains=htmlTagN,htmlString,htmlArg,htmlValue,htmlTagError,htmlEvent,htmlCssDefinition,@htmlPreproc,@htmlArgCluster,angularArg
    autocmd FileType html,twig syn match angularTagName contained "\<\(ng\|accordion\)\(-[a-z]\+\)\?\>"
    autocmd FileType html,twig syn match angularArg contained "\<\(ng\|typeahead\)\([-a-z]\+\)\?\>="me=e-1
    autocmd FileType html,twig hi angularTagName term=bold cterm=bold ctermfg=161
    autocmd FileType html,twig hi angularArg cterm=none ctermfg=161
    autocmd FileType html,twig set ai
augroup END
