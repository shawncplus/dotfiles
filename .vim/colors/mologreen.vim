" Vim color file
"
" Author: Tomas Restrepo <tomas@winterdom.com>
"
" Note: Based on the monokai theme for textmate
" by Wimer Hazenberg and its darker variant
" by Hamish Stuart Macpherson
"
 
hi clear
 
set background=dark
if version > 580
" no guarantees for version 5.8 and below, but this makes it stop
" complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="molokai"
 
if exists("g:molokai_original")
    let s:molokai_original = g:molokai_original
else
    let s:molokai_original = 0
endif
 
 
hi Boolean guifg=#AE81FF
hi Character guifg=#E6DB74
hi Number guifg=#AE81FF
hi String guibg=#000000 guifg=#FFFFFF gui=bold
hi Conditional guifg=#95CA0C gui=bold
hi Constant guifg=#AE81FF gui=bold
hi Cursor guifg=#000000 guibg=#F8F8F0
hi Debug guifg=#BCA3A3 gui=bold
hi Define guifg=#66D9EF
hi Delimiter guifg=#8F8F8F
hi DiffAdd guibg=#13354A
hi DiffChange guifg=#89807D guibg=#4C4745
hi DiffDelete guifg=#960050 guibg=#1E0010
hi DiffText guibg=#4C4745 gui=italic,bold

" hi phpRegion guifg=#CC0000 gui=bold

hi Directory guifg=#A6E22E gui=bold
hi Error guifg=#960050 guibg=#1E0010
hi ErrorMsg guifg=#FF1500 guibg=#232526 gui=bold
hi Exception guifg=#A6E22E gui=bold
hi Float guifg=#AE81FF
hi FoldColumn guifg=#465457 guibg=#000000
hi Folded guifg=#465457 guibg=#000000
hi Function guifg=#A6E22E

hi Identifier guifg=#FD971F

hi Ignore guifg=#808080 guibg=bg
hi IncSearch guifg=#C4BE89 guibg=#000000
 
hi Keyword guifg=#95CA0C gui=bold
hi Label guifg=#E6DB74 gui=none
hi Macro guifg=#C4BE89 gui=italic
hi SpecialKey guifg=#66D9EF gui=italic
 
hi MatchParen guifg=#000000 guibg=#FD971F gui=bold
hi ModeMsg guifg=#E6DB74
hi MoreMsg guifg=#E6DB74
hi Operator guifg=#95CA02

" complete menu
hi Pmenu guifg=#66D9EF guibg=#000000
hi PmenuSel guibg=#808080
hi PmenuSbar guibg=#080808
hi PmenuThumb guifg=#66D9EF
 
hi PreCondit guifg=#A6E22E gui=bold
hi PreProc guifg=#A6E22E
hi Question guifg=#66D9EF
hi Repeat guifg=#95CA02 gui=bold
hi Search guifg=#FFFFFF guibg=#455354

" marks column
hi SignColumn guifg=#A6E22E guibg=#232526
hi SpecialChar guifg=#95CA02 gui=bold
hi SpecialComment guifg=#465457 gui=bold
hi Special guifg=#66D9EF guibg=bg gui=italic
hi SpecialKey guifg=#888A85 gui=italic
if has("spell")
    hi SpellBad guisp=#FF0000 gui=undercurl
    hi SpellCap guisp=#7070F0 gui=undercurl
    hi SpellLocal guisp=#70F0F0 gui=undercurl
    hi SpellRare guisp=#FFFFFF gui=undercurl
endif

hi Statement guifg=#95CA0C gui=bold
hi StatusLine guifg=#455354 guibg=fg
hi StatusLineNC guifg=#808080 guibg=#080808
hi StorageClass guifg=#FD971F gui=italic
hi Structure guifg=#66D9EF
hi Tag guifg=#95CA0C gui=italic
hi Title guifg=#ef5939
hi Todo guifg=#FFFFFF guibg=bg gui=bold

hi phpDocBlock guifg=#94E1E4 guibg=bg gui=bold,italic

hi Typedef guifg=#66D9EF
hi Type guifg=#66D9EF gui=none
hi Underlined guifg=#808080 gui=underline
 
hi VertSplit guifg=#808080 guibg=#080808 gui=bold
hi VisualNOS guibg=#403D3D
hi Visual guibg=#403D3D
hi WarningMsg guifg=#FFFFFF guibg=#333333 gui=bold
hi WildMenu guifg=#66D9EF guibg=#000000
 
if s:molokai_original == 1
   hi Normal guifg=#F8F8F2 guibg=#272822
   hi Comment guifg=#75715E
   hi CursorLine guibg=#3E3D32
   hi CursorColumn guibg=#3E3D32
   hi LineNr guifg=#BCBCBC guibg=#3B3A32
   hi NonText guifg=#BCBCBC guibg=#3B3A32
else
   hi Normal guifg=#F8F8F2 guibg=#1D1E1F
   hi Comment guifg=#5D8D8F
   hi CursorLine guibg=#121212
   hi CursorColumn guibg=#121212
   hi LineNr guifg=Gray guibg=#111111
   hi NonText guifg=#BCBCBC guibg=#232526
end

hi yamlBaseKey  gui=bold,underline
hi yamlTab guibg=#FF0000
hi User1 guifg=#000000 guibg=#84E12E gui=bold
