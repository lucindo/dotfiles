set background=light
syntax on
set t_Co=256
colorscheme PaperColor
set colorcolumn=80
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
set undodir="$HOME/.vim/undodir"
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

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

call plug#end()

" Leader key
let mapleader="\<Space>"

nnoremap <silent> <Leader>fe :NERDTreeToggle<CR>

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use Tab for completion (if popup is visible), otherwise insert a tab
inoremap <silent><expr> <Tab>
  \ pumvisible() ? coc#_select_confirm() :
  \ "\<Tab>"

" Use Shift-Tab to go to previous item in the popup
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

" Auto install language servers (Rust, JS, HTML)
let g:coc_global_extensions = [
  \ 'coc-pyright',
  \ 'coc-html',
  \ 'coc-json'
  \ ]
