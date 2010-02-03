" amarok.vim - amaroK integration for vim
" 
" This plugin let's you control amaroK (http://amarok.kde.org) from vim. It adds
" a menu to your gvim, and defines a new command called 'AmaroK', which let's
" you control amarok via Ex-commands. Since it uses the dcop-functionality of
" amaroK, you can type in any dcop command the dcop-player-interface of amarok
" supports. For a complete list type: dcop amarok player functions in a terminal
"
"
" If you don't like the menu, you can set the g:AmaroK_show_menu-variable to 0
" in your vimrc and the menu will not be displayed

if !exists('g:AmaroK_show_menu')
		let g:AmaroK_show_menu = 1
endif

function! CallAmaroK(cmd)
	call system("dcop amarok player ".a:cmd)
endfunction


command -nargs=1 AmaroK :call CallAmaroK('<args>')

if exists("g:AmaroK_show_menu")
	if g:AmaroK_show_menu==1
	9000amenu <silent> &AmaroK.Play<TAB>:AmaroK\ play           :AmaroK play<CR>
	9000amenu <silent> &AmaroK.Pause<TAB>:AmaroK\ pause         :AmaroK pause<CR>
	9000amenu <silent> &AmaroK.Stop<TAB>:AmaroK\ stop          :AmaroK stop<CR>
	9000amenu <silent> &AmaroK.&Next<TAB>:AmaroK\ next          :AmaroK next<CR>
	9000amenu <silent> &AmaroK.&Previous<TAB>:AmaroK\ prev      :AmaroK prev<CR>
"	9000amenu          &AmaroK.&Current\ Song<TAB>:PrintAmaroK\ nowPlaying <CR>
	9000amenu <silent> &AmaroK.&Volume.0%  :AmaroK setVolume 0<CR>
	9000amenu <silent> &AmaroK.&Volume.25%   :AmaroK setVolume 25<CR>
	9000amenu <silent> &AmaroK.&Volume.50%   :AmaroK setVolume 50<CR>
	9000amenu <silent> &AmaroK.&Volume.75%   :AmaroK setVolume 75<CR>
	9000amenu <silent> &AmaroK.&Volume.100%   :AmaroK setVolume 100<CR>
	9000amenu <silent> &AmaroK.&Volume.Volume\ Up   :AmaroK volumeUp<CR>
	9000amenu <silent> &AmaroK.&Volume.Volume\ Down   :AmaroK volumeDown 100<CR>
	endif
endif


