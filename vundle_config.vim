" set the runtime path to include Vundle and initialize
set rtp+=~/vimfiles/bundle/vundle/
call vundle#rc('~/vimfiles/bundle')
" alternatively, pass a path where Vundle should install plugins
"let path = '~/some/path/here'
"call vundle#rc(path)

" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'

" The following are examples of different formats supported.
" Keep Plugin commands between here and filetype plugin indent on.
" scripts on GitHub repos
Plugin 'tpope/vim-fugitive'
Plugin 'mileszs/ack.vim.git'
Plugin 'bernh/pss.vim.git'
Plugin 'scrooloose/nerdtree.git'
Plugin 'tpope/vim-unimpaired.git'
Plugin 'tsaleh/vim-align.git'
Plugin 'wgibbs/vim-irblack.git'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'xolox/vim-shell'
Plugin 'xolox/vim-easytags'
Plugin 'jeaye/color-coded'
Plugin 'Konfekt/FastFold'

Plugin 'Valloric/YouCompleteMe.git'

" Plugin 'davidhalter/jedi-vim.git'
" Plugin 'Rip-Rip/clang_complete.git'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim'}

" scripts from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'Remove-Trailing-Spaces'
Plugin 'a.vim'
Plugin 'bandit.vim'
Plugin 'occur.vim'
Plugin 'taglist.vim'
Plugin 'nose.vim'
" Plugin 'pep8'

" Plugin 'AutoComplPop'

" scripts not on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" ...

filetype plugin indent on     " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin commands are not allowed.
" Put your stuff after this line
