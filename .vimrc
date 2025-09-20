set background=light
syntax on
set termguicolors
colorscheme modus
highlight clear SignColumn
highlight clear LineNr

" numbers on the left
set number
set relativenumber
set signcolumn=yes

" tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" identing
set nowrap
set autoindent
set nojoinspaces

" let change buffer with unsaved changes
set hidden

" show current mode
set showmode

" underline the current line (probably comment this off)
set cursorline

" undo
set noswapfile
set nobackup
set undodir="$HOME/.vim_undo"
set undofile
set history=1000

" search
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase

set scrolloff=8
set backspace=indent,eol,start

" show extra and insible chars
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set list

" status line
if has('statusline')
    set laststatus=2
    set statusline=%<%f\
    set statusline+=%w%h%m%r
    set statusline+=\ [%{&ff}/%Y]
    set statusline+=\ [%{getcwd()}]
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%
endif

set wildmenu
set wildmode=list:longest,full
