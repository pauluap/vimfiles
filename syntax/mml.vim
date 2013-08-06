" Copyright 2013 Moore Industries International INc. All rights reserved.
"
" mml.vim: Vim syntax file for Moore Markup Language
"

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn case match

" MML syntax doesn't distinguish between different keywords yet
" It just recognizes the MML delimiter
" which is a period in column 1
"
syn match       mmlKeyword          /^\.\S\+/

hi def link     mmlKeyword          Keyword

