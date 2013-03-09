" Vim compiler file
" Compiler:	    IAR C Complier
" Maintainer:	Paul Thompson
" Last Change:	2009 Feb 14

if exists("current_compiler")
  finish
endif
let current_compiler = "iar"

" The errorformat for MSVC is the default.
CompilerSet errorformat=%E\"%f\"\\,%l\ \ Fatal\ error[Pe%n]:%m,%E\"%f\"\\,%l\ \ Error[Pe%n]:%m,%W\"%f\"\\,%l\ \ Warning[Pe%n]:%m,Error[e%n]:\ %m(\ %f\ )%.%#,Warning[w%n]:\ %m,%+Z%.%#,%-G%.%#EMBEDD%.%#,%-G%.%#Microsoft%.%#,%-G\ %$

CompilerSet makeprg=nmake
