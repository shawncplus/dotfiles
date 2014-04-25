if exists("g:loaded_nerdtree_custom_shawncplus")
	finish
endif
let g:loaded_nerdtree_custom_shawncplus = 1

call NERDTreeAddKeyMap({
	\ 'key': 'gG',
	\ 'callback': 'NERDTreeCustomMapsOpenCurrentGitRoot',
	\ 'quickhelpText': 'Open current git root' })

call NERDTreeAddKeyMap({
	\ 'key': 'gH',
	\ 'callback': 'NERDTreeCustomMapsOpenCurrentGitRootNewTab',
	\ 'quickhelpText': 'Open current git root in a new tab' })

function! NERDTreeCustomMapsOpenCurrentGitRoot()
	let gitroot = s:getGitRoot()
	if type(gitroot) == type(0)
		return
	endif

	let gitrootnpath = g:NERDTreePath.New(gitroot)
	let n = g:NERDTreeDirNode.New(gitrootnpath)
	call n.makeRoot()
	call NERDTreeRender()
	call n.putCursorHere(0,0)
endfunction

function! NERDTreeCustomMapsOpenCurrentGitRootNewTab()
	let gitroot = s:getGitRoot()
	if type(gitroot) == type(0)
		return
	endif

	exec 'tabnew ' . gitroot
endfunction

function! s:getGitRoot()
	let gitroot = finddir('.git', b:NERDTreeRoot.path.str() . '/;') . '/'
	if gitroot != '/'
		return substitute(gitroot, '\.git/$', '', '')
	endif
	return 0
endfunction
