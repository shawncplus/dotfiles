autocmd BufNewFile,BufRead *.git/COMMIT_EDITMSG    setf gitcommit
autocmd BufNewFile,BufRead *.git/config,.gitconfig setf gitconfig
autocmd BufNewFile,BufRead git-rebase-todo         setf gitrebase
autocmd BufNewFile,BufRead .msg.[0-9]*
			\ if getline(1) =~ '^From.*# This line is ignored.$' |
			\   setf gitsendemail |
			\ endif
autocmd BufNewFile,BufRead *.git/**
			\ if getline(1) =~ '^\x\{40\}\>\|^ref: ' |
			\   setf git |
			\ endif

augroup markdown
	autocmd BufRead,BufNewFile *.mkd setfiletype mkd
augroup END

