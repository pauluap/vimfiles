augroup au_dox
    au BufRead,BufNewFile *.dox    set syntax=c.doxygen
    au BufRead,BufNewFile *.dox    setlocal textwidth=80
augroup END
