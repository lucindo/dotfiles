filetype plugin indent on
set softtabstop=4
set smartindent
set showmatch
syntax on
" Line numbers
set number
set relativenumber

" Indentation and tabs
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab

" Search
set ignorecase
set smartcase
set incsearch

" Appearance
set background=dark
set signcolumn=yes
set cursorline
set colorcolumn=80

" Backspace behavior
set backspace=indent,eol,start

" Split window behavior
set splitbelow
set splitright

" dw/diw/ciw treat dash-separated words as single word
set iskeyword+=-

" Keep cursor 8 lines from top/bottom
set scrolloff=8

" Cursor responsiveness
set updatetime=50

set laststatus=2

" undo
set noswapfile
set nobackup
set undodir="$HOME/.vim_undo"
set undofile
set history=1000

" netrw
let g:netrw_home = expand('~/.vim_netrw')

" show extra and insible chars
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set list

set wildmenu
set wildmode=list:longest,full
