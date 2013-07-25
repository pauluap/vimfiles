map <F12> :!ctags -R --sort=foldcase --language-force=c -L filelist <CR>
map <S-F12> :!ctags -R --sort=foldcase --language-force=c --c-kinds=+pl --fields=+iaS --extra=+q -L filelist <CR>
inoremap <C-k> <C-x><C-o>

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-F9> :call g:ClangUpdateQuickFix() <CR>
let g:clang_complete_auto = 1
let g:clang_auto_select = 1
let g:clang_complete_copen = 1
let g:clang_hl_errors = 1
let g:clang_periodic_quickfix = 0
let g:clang_snippets = 1
let g:clang_trailing_placeholder = 1
let g:clang_use_library = 1
let g:clang_debug = 0
let g:clang_auto_user_options = ".clang_complete"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" au! CursorHold *.[ch] nested call PreviewWord()
map <F8> :call PreviewWord() <CR>

set cinoptions+=:N0,(0,u0,U0  " Don't indent case statements in switch struct

func! PreviewWord()
  if &previewwindow			" don't do this in the preview window
    return
  endif
  let w = expand("<cword>") " get the word under cursor
  if w =~ '\i'
    if w =~ '\<\v(for|while|if|else|continue|switch|return|break|case)\m\>'
      return
    endif
    if w =~ '\<\v(int|char|double|long|static|unsigned|const|void|define|undef)\m\>'
      return
    endif
    " if there is one ":ptag" to it
    " Delete any existing highlight before showing another tag
    silent! wincmd P " jump to preview window
    if &previewwindow " if we really get there...
      match none " delete existing highlight
      wincmd p " back to old window
    endif
    " Try displaying a matching tag for the word under the cursor
    let v:errmsg = ""
    exe "silent! ptag " . w
    if v:errmsg =~ "tag not found"
      exe "silent! psearch " . w
    endif
    silent! wincmd P " jump to preview window
    if &previewwindow " if we really get there...
      if has("folding")
        silent! .foldopen " don't want a closed fold
      endif
      call search("$", "b") " to end of previous line
      let w = substitute(w, '', '\\', "")
      call search('\<\V' . w . '\>') " position cursor on match
      " Add a match highlight to the word at this position
      hi previewWord term=bold ctermbg=green guibg=green
      exe 'match previewWord "\%' . line(".") . 'l\%' . col(".") . 'c\k*"'
      wincmd p " back to old window
    endif
  endif
endfunction

" When you open a parenthesis after a function name, and at the
" line end, that function's definition is previewed through PreviewWord().
" This is inspired from Delphi's CodeInsight technology.
" Something similar (PreviewClassMembers) could be written for
" the C++ users, for previewing the class members when you type
" a dot after an object name.
" If somebody decides to write it, please, mail it to me.
function! PreviewFunctionSignature()
  let CharOnCursor = strpart( getline('.'), col('.')-2, 1)
  if col(".") == col("$")-1
    normal h
    call PreviewWord()
    normal l
  endif
endfunction

function! Register(...)
  let index=1
  while index <= a:0
    execute 'let ext=a:'.index
  " execute 'au! CursorHold '.ext.' nested call PreviewWord()'
    execute 'augroup au_afterc'
    execute 'au!'
    execute 'au BufNewFile,BufRead '.ext.' nested inoremap <buffer> ( <Esc>:call PreviewFunctionSignature()<CR>a('
    execute 'augroup END'
    let index=index+1
  endwhile
endf
"call Register('*.[ch]', '*.cc', '*.cpp')


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:acp_behavior = {
"\ 'c': [ {'command' : "\<C-x>\<C-n>",
"\       'pattern' : "\k",
"\       'repeat' : 0}
"\      ]
"\}

" AutoComplPop
"let g:acp_completeoptPreview=1
let g:acp_enableAtStartup=1
let g:acp_behaviorKeywordLength=4
let g:acp_completeOption='.,w,i,t'

inoremap <tab> <Esc>/<#[^>]*#><CR>cf>

