set nocompatible
set noswapfile
set backupdir=$HOME/vimfiles/_backup
set undodir=$HOME/vimfiles/_backup
set directory=$HOME/vimfiles/_swp//

set runtimepath+=$HOME/vimfiles

if (has('win32') || has('win64'))
    let $PATH = 'C:\Python27;' . $PATH
    let g:ycm_server_python_interpreter='C:\Python34\python.exe'
endif

" Configure plugins before using Vundle to load them
"
" AutoComplPop
"let g:acp_completeoptPreview=1
let g:acp_enableAtStartup=1
let g:acp_behaviorKeywordLength=4
let g:acp_completeOption='.,w,t'

" Jedi-vim
let g:jedi#auto_initialization=0
let g:jedi#auto_vim_configuration=0
let g:jedi#show_call_signatures=0
let g:jedi#popup_select_first=0

" YCM
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_confirm_extra_conf = 0
let g:ycm_server_use_vim_stdout = 0
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1

filetype off
source ~/vimfiles/vundle_config.vim
filetype on

" XML folding
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

map <S-F12> :!ctags -R --fields=+l <CR>

set diffexpr=MyDiff()
fun! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

set spell
set nomousehide
set softtabstop=4
set autoindent                " auto/smart indent
set expandtab                 " expand tabs to spaces
set smarttab                  " tab and backspace are smart
set tabstop=4                 " 4 spaces
set shiftwidth=4
set ruler                     " show the line number on the bar
set more                      " use more prompt
set autoread                  " watch for file changes
set number                    " line numbers
set hidden                    " allow edit buffers to be hidden
set noautowrite               " don't automagically write on :next
set showmode
set showcmd                   " Show us the command we're typing
set nocompatible              " vim, not vi
set scrolloff=3               " keep at least 3 lines above/below
set sidescrolloff=5           " keep at least 5 lines left/right
set backspace=indent,eol,start
set showfulltag               " show full completion tags
set noerrorbells              " no error bells please
set linebreak
set tw=500                    " default textwidth is a max of 500
set cmdheight=2               " command line two lines high
set undolevels=1000           " 1000 undos
set updatecount=100           " switch every 100 chars
set complete=.,b,t
set include=''
set ttyfast                   " we have a fast terminal
filetype on                   " Enable filetype detection
filetype indent on            " Enable filetype-specific indenting
filetype plugin on            " Enable filetype-specific plugins
syntax on
set wildmode=longest:full
set wildignore+=*.o,*~,.lo,*.obj,*.pyc,.svn    " ignore object files
set wildmenu                  " menu has tab completion
let maplocalleader=','        " all my macros start with ,
let leader=','
set foldmethod=syntax         " fold on syntax automagically, always
set foldcolumn=3              " 3 lines of column for fold showing, always
set whichwrap+=<,>,h,l        " backspaces and cursor keys wrap to
set magic                     " Enable the "magic"
set visualbell t_vb=          " Disable ALL bells
set cursorline                " show the cursor line
set tags=tags                 "
set cinoptions+=:N0,(0,u0,U0,g0  " Don't indent case statements in switch struct
set completeopt=menuone,longest

if !has("gui_running")
      "colorscheme candycode   " yum candy

      " I pretty much only like this scheme if I can use SIMBL with terminal
      " colors:
      " (http://www.culater.net/software/TerminalColors/TerminalColors.php)
      " to change the really hard-to-read dark blue into a lighter shade.
      colorscheme ir_black_new " only when I can change certain colors
end
if has("gui_running")
      "colorscheme macvim      " macvim == win
      colorscheme ir_black_new     " only when I can change certain colors
      set noantialias          " If I use ir_black_new, no antialiasing
      set guioptions-=T        " no toolbar
      set lines=65
      set columns=140
end

if exists('&t_SI')
      let &t_SI = "\<Esc>]12;lightgoldenrod\x7"
      let &t_EI = "\<Esc>]12;grey80\x7"
endif

" Settings for taglist.vim
let Tlist_Use_Right_Window=1
let Tlist_Auto_Open=0
let Tlist_Enable_Fold_Column=0
let Tlist_Show_One_File = 0
let Tlist_Compact_Format=0
let Tlist_WinWidth=28
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close = 0

" ---------------------------------------------------------------------------
"  configuration for fuzzyfinder
" find in buffer is ,fb
nmap <LocalLeader>fb :FufBuffer<CR>
" find in file is ,ff
nmap <LocalLeader>ff :FufFile<CR>
" find in tag is ,ft
nmap <LocalLeader>ft :FufTag<CR>

" ---------------------------------------------------------------------------
"  configuration for YcmCompleter
nnoremap <LocalLeader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <LocalLeader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <LocalLeader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <LocalLeader>gw :YcmCompleter GoTo<CR>
nnoremap <LocalLeader>gx :YcmCompleter FixIt<CR>
nnoremap <LocalLeader>gd :YcmDiags<CR>

" ---------------------------------------------------------------------------
" status line
set laststatus=2
if has('statusline')
        " Status line detail: (from Rafael Garcia-Suarez)
        " %f		file path
        " %y		file type between braces (if defined)
        " %([%R%M]%)	read-only, modified and modifiable flags between braces
        " %{'!'[&ff=='default_file_format']}
        "			shows a '!' if the file format is not the platform
        "			default
        " %{'$'[!&list]}	shows a '*' if in list mode
        " %{'~'[&pm=='']}	shows a '~' if in patchmode
        " (%{synIDattr(synID(line('.'),col('.'),0),'name')})
        "			only for debug : display the current syntax item name
        " %=		right-align following items
        " #%n		buffer number
        " %l/%L,%c%V	line number, total number of lines, and column number

        function! SetStatusLineStyle()
                "let &stl="%f %y "                       .
                        "\"%([%R%M]%)"                   .
                        "\"%#StatusLineNC#%{&ff=='unix'?'':&ff.'\ format'}%*" .
                        "\"%{'$'[!&list]}"               .
                        "\"%{'~'[&pm=='']}"              .
                        "\"%="                           .
                        "\"#%n %l/%L,%c%V "              .
                        "\""
                 "      \"%#StatusLineNC#%{GitBranchInfoString()}%* " .
              let &stl="%F%m%r%h%w\ [%{&ff}]\ [%Y]\ %P\ %=[a=\%03.3b]\ [h=\%02.2B]\ [%l,%v]"
        endfunc
        " Not using it at the moment, using a different one
        call SetStatusLineStyle()

        if has('title')
                set titlestring=%t%(\ [%R%M]%)
        endif

        highlight StatusLine    term=bold,reverse cterm=bold ctermfg=15 ctermbg=1 gui=italic guifg=#CCCCCC guibg=#202020
        highlight StatusLineNC  term=reverse ctermfg=15 ctermbg=1 gui=italic guifg=grey50 guibg=#202020
endif

" ---------------------------------------------------------------------------
"  searching
set incsearch                 " incremental search
set smartcase                 " Ignore case when searching lowercase
set hlsearch                  " highlight the search
set showmatch                 " show matching bracket
set diffopt=filler,iwhite       " ignore all whitespace and sync

" ---------------------------------------------------------------------------
set viminfo=%100,'100,/100,h,\"500,:100,n~/.viminfo
set history=200

" toggle list mode
nmap <LocalLeader>tl :set list!<cr>
" toggle paste mode
nmap <LocalLeader>pp :set paste!<cr>
" change directory to that of current file
nmap <LocalLeader>cd :cd%:p:h<cr>
" change local directory to that of current file
nmap <LocalLeader>lcd :lcd%:p:h<cr>
" correct type-o's on exit
nmap q: :q
" save and build
nmap <LocalLeader>wm  :w<cr>:make<cr>
" open all folds
nmap <LocalLeader>fo  :%foldopen!<cr>
" close all folds
nmap <LocalLeader>fc  :%foldclose!<cr>
" ,tt will toggle taglist on and off
nmap <LocalLeader>tt :Tlist<cr>
" ,nn will toggle NERDTree on and off
nmap <LocalLeader>nn :NERDTreeToggle<cr>
" When I'm pretty sure that the first suggestion is correct
map <LocalLeader>r 1z=
" q: sucks
nmap q: :q
" tabs
" (LocalLeader is ",")
map <LocalLeader>tc :tabnew %<cr>    " create a new tab
map <LocalLeader>td :tabclose<cr>    " close a tab
map <LocalLeader>tn :tabnext<cr>     " next tab
map <silent><m-Right> :tabnext<cr>   " next tab
map <LocalLeader>tp :tabprev<cr>     " previous tab
map <silent><m-Left> :tabprev<cr>    " previous tab
map <LocalLeader>tm :tabmove         " move a tab to a new location

" if has("cscope")
"     set csprg=~/bin/cscope
"     set csto=0
"     set cst
"     set nocsverb
"     " add any database in current directory
"     if filereadable("cscope.out")
"         cs add cscope.out
"         " else add database pointed to by environment
"     elseif $CSCOPE_DB != ""
"         cs add $CSCOPE_DB
"     endif
" endif

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

augroup myvimrc
    au!
"    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC
    au BufWritePre *.h :call <SID>StripTrailingWhitespaces()
    au BufWritePre *.c :call <SID>StripTrailingWhitespaces()
    au BufWritePre *.cpp :call <SID>StripTrailingWhitespaces()
augroup END

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
\ "\<lt>C-n>" :
\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>


inoremap <expr> j pumvisible() ? "\<Down>" : "j"
inoremap <expr> k pumvisible() ? "\<Up>" : "k"

let g:load_doxygen_syntax=1
let g:session_autosave = 'no'

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:acp_behavior = {
"\ 'c': [ {'command' : "\<C-x>\<C-n>",
"\       'pattern' : "\k",
"\       'repeat' : 0}
"\      ]
"\}

"
" XML formatter
function! DoFormatXML() range
	" Save the file type
	let l:origft = &ft

	" Clean the file type
	set ft=

	" Add fake initial tag (so we can process multiple top-level elements)
	exe ":let l:beforeFirstLine=" . a:firstline . "-1"
	if l:beforeFirstLine < 0
		let l:beforeFirstLine=0
	endif
	exe a:lastline . "put ='</PrettyXML>'"
	exe l:beforeFirstLine . "put ='<PrettyXML>'"
	exe ":let l:newLastLine=" . a:lastline . "+2"
	if l:newLastLine > line('$')
		let l:newLastLine=line('$')
	endif

	" Remove XML header
	exe ":" . a:firstline . "," . a:lastline . "s/<\?xml\\_.*\?>\\_s*//e"

	" Recalculate last line of the edited code
	let l:newLastLine=search('</PrettyXML>')

	" Execute external formatter
	exe ":silent " . a:firstline . "," . l:newLastLine . "!xmllint --noblanks --format --recover -"

	" Recalculate first and last lines of the edited code
	let l:newFirstLine=search('<PrettyXML>')
	let l:newLastLine=search('</PrettyXML>')
	
	" Get inner range
	let l:innerFirstLine=l:newFirstLine+1
	let l:innerLastLine=l:newLastLine-1

	" Remove extra unnecessary indentation
	exe ":silent " . l:innerFirstLine . "," . l:innerLastLine "s/^  //e"

	" Remove fake tag
	exe l:newLastLine . "d"
	exe l:newFirstLine . "d"

	" Put the cursor at the first line of the edited code
	exe ":" . l:newFirstLine

	" Restore the file type
	exe "set ft=" . l:origft
endfunction
command! -range=% FormatXML <line1>,<line2>call DoFormatXML()

nmap <silent> <leader>x :%FormatXML<CR>
vmap <silent> <leader>x :FormatXML<CR>
