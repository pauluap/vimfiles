setlocal foldmethod=indent
setlocal foldlevel=99
setlocal expandtab
setlocal softtabstop=4
setlocal tabstop=4
setlocal shiftwidth=4
setlocal smarttab
setlocal omnifunc=jedi#completions

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

augroup mypython
    au!
    au BufWritePre *.py :call <SID>StripTrailingWhitespaces()
augroup END

