augroup filetype_html
    autocmd!
    " Angular and angular bootstrap tag highlighting
    " HTML Twig
    "autocmd BufNewFile,BufRead *.html set filetype=php
    autocmd FileType php,html,twig,html.twig setlocal ai cin
augroup END
