" Maintainer:	Lars H. Nielsen (dengmao@gmail.com)
" Last Change:	January 22 2007

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "wombat"


" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine guibg=#2d2d2d ctermbg=236
  hi CursorColumn guibg=#2d2d2d ctermbg=236
  hi MatchParen guifg=#f6f3e8 ctermfg=7 guibg=#857b6f ctermbg=243 gui=bold
  hi Pmenu 		guifg=#f6f3e8 ctermfg=7 guibg=#444444 ctermbg=238
  hi PmenuSel 	guifg=#000000 ctermfg=0 guibg=#cae682 ctermbg=186
endif

" General colors
hi Cursor 		guifg=NONE    guibg=#656565 ctermbg=241 gui=none
hi Normal 		guifg=#f6f3e8 ctermfg=7 guibg=#131313 ctermbg=233 gui=none
hi NonText 		guifg=#808080 ctermfg=244 guibg=#303030 ctermbg=236 gui=none
hi LineNr 		guifg=#857b6f ctermfg=243 guibg=#000000 ctermbg=0 gui=none
hi StatusLine 	guifg=#f6f3e8 ctermfg=7 guibg=#444444 ctermbg=238 gui=italic
hi StatusLineNC guifg=#857b6f ctermfg=243 guibg=#444444 ctermbg=238 gui=none
hi VertSplit 	guifg=#444444 ctermfg=238 guibg=#444444 ctermbg=238 gui=none
hi FoldColumn guifg=#465457 ctermfg=239 guibg=#000000 ctermbg=0
hi Folded 		guibg=#384048 ctermbg=238 guifg=#a0a8b0 ctermfg=248 gui=none
hi Title		guifg=#f6f3e8 ctermfg=7 guibg=NONE	gui=bold
hi Visual		guifg=#f6f3e8 ctermfg=7 guibg=#444444 ctermbg=238 gui=none
hi SpecialKey	guifg=#808080 ctermfg=244 guibg=#343434 ctermbg=236 gui=none

" Syntax highlighting
hi Comment 		guifg=#99968b ctermfg=246 gui=italic
hi Todo 		guifg=#8f8f8f ctermfg=245 gui=italic
hi Constant 	guifg=#e5786d ctermfg=173 gui=none
hi String 		guifg=#95e454 ctermfg=113 guibg=#000000 ctermbg=0 gui=bold
hi Identifier 	guifg=#cae682 ctermfg=186 gui=none
hi Function 	guifg=#cae682 ctermfg=186 gui=none
hi Type 		guifg=#cae682 ctermfg=186 gui=none
hi Statement 	guifg=#8ac6f2 ctermfg=117 gui=none
hi Keyword		guifg=#8ac6f2 ctermfg=117 gui=none
hi PreProc 		guifg=#e5786d ctermfg=173 gui=none
hi Number		guifg=#e5786d ctermfg=173 gui=none
hi Special		guifg=#e7f6da ctermfg=194 gui=none

hi yamlBaseKey guifg=#FFFFFF ctermfg=15 gui=underline,bold
