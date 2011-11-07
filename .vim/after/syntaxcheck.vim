sign define phplerr text=* texthl=Error linehl=Error

fun! CheckPHPSyntax()
  let clean = system("/usr/bin/php -l ". expand("%"))
  let test  = substitute(clean, "\.\\+ line \\([0-9]\\+\\)\\s*\.\\+", "\\1", "gis")
  if(test != clean)
    exec ":sign place " . test . " line=" . test . " name=phplerr file=" . expand("%:p")
    echohl ErrorMsg | ec clean | echohl None
    echo "Would you like to move to the line?"
    let choice = nr2char(getchar())
    if choice == "y" || choice == "\<CR>"
      call cursor(test, 0)
    else
    endif
  else
    sign unplace *
  endif
endfun

"automatically check syntax on save of the file WOOT!
"autocmd BufWritePost *.php :!/usr/bin/php -l % 
autocmd FileType php autocmd BufWritePost <buffer> :call CheckPHPSyntax()
" CTRL+L checks syntax on the file
"autocmd FileType php noremap  :!/usr/bin/php -l % 
"autocmd FileType php noremap  :call CheckPHPSyntax() 


" JavasScript awesomeness
" Disabled for now, was getting buggy
" You'll need my jslint/jslint_wrapper and js-support files/dirs
"sign define linterr text=* texthl=Error linehl=Error
"
"fun! CheckJSSyntax()
"  let test = system("jslint ". expand('%')." -clean")
"  let clean = substitute(test, "\n", "\\n", "gis")
"  let listarg = substitute(clean, "^{\\([0-9 ]\\+\\)}\.\\+", "\\1", "gis")
"
"  if (test != "No errors.\n")
"    for line in split(listarg, " ")
"      exec ":sign place " . line . " line=" . line . " name=linterr file=" . expand("%:p")
"    endfor
"    echon "". substitute(test, "^{\\([0-9 ]\\+\\)}", "", "gis")
"  else
"    sign unplace *
"  endif
"endfun
"
"if !exists("js_autocmd_loaded")
"  let js_autocmd_loaded = 1
"  autocmd FileType javascript autocmd BufWritePost <buffer> :call CheckJSSyntax()
"  autocmd FileType javascript noremap J :call CheckJSSyntax() 
"endif
