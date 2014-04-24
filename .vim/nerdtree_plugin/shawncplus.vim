if exists("g:loaded_nerdtree_custom_shawncplus")
	finish
endif
let g:loaded_nerdtree_custom_shawncplus = 1

call NERDTreeAddKeyMap({
	\ 'key': 'gG',
	\ 'callback': 'NERDTreeCustomMapsOpenCurrentGitRoot',
	\ 'quickhelpText': 'Open current git root' })

function! NERDTreeCustomMapsOpenCurrentGitRoot()
	let gitroot = finddir('.git', b:NERDTreeRoot.path.str() . '/;') . '/'
	if gitroot != '/'
		let gitroot = substitute(gitroot, '\.git/$', '', '')
		let gitrootnpath = g:NERDTreePath.New(gitroot)
		let n = g:NERDTreeDirNode.New(gitrootnpath)
		call n.makeRoot()
		call NERDTreeRender()
		call n.putCursorHere(0,0)
	endif
endfunction
