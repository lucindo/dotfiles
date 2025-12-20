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
set termguicolors
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

set report=0
set laststatus=2

" undo
set noswapfile
set nobackup
set undodir="$HOME/.vim_undo"
set undofile
set history=1000

" show extra and insible chars
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set list
set fillchars=eob:\ 

" folding
set foldmethod=indent
set foldlevel=99

" Plugins:
"  need vim-plug installed, run:
"  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin()

Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'yegappan/lsp'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'ojroques/vim-oscyank'
Plug 'mbbill/undotree'
Plug 'itchyny/vim-gitbranch'
Plug 'itchyny/lightline.vim'

call plug#end()

" Keymaps & Plugin configs

colorscheme catppuccin_frappe

set laststatus=2
set noshowmode
function! LightlineFilename()
  return expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunction
let g:lightline = {
      \ 'colorscheme' : 'catppuccin_frappe',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'filename': 'LightlineFilename'
      \ }
      \ }


" Set leader key
let mapleader = " "

" Move selected lines up/down (like Alt-Up/Down)
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Join lines with cursor preserved
nnoremap J mzJ`z

" Scroll half-page and center cursor
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Center on next/previous search result
nnoremap n nzzzv
nnoremap N Nzzzv

" Paste without overwriting clipboard
xnoremap <leader>p "_dP
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Make <C-c> behave like <Esc> in insert mode
inoremap <C-c> <Esc>

" Navigate quickfix list using Ctrl-j/k
nnoremap <C-j> :lnext<CR>
nnoremap <C-k> :lprev<CR>
nnoremap <leader>cl :lclose<CR>

" Disable Ex mode (accidental Q)
nnoremap Q <nop>

" Location list navigation
nnoremap <leader>k :lnext<CR>zz
nnoremap <leader>j :lprev<CR>zz

" Substitute word under cursor on line
nnoremap <leader>R :s/\<<C-r><C-w>\>//gI<Left><Left><Left>

" Yank via OSCYank
nmap <leader>y <Plug>OSCYankOperator
vmap <leader>y <Plug>OSCYankVisual

let g:undotree_WindowLayout = 3
let g:undotree_SplitWidth = 40
let g:undotree_SetFocusWhenToggle = 1
nnoremap <leader>u :UndotreeToggle<CR>

" Files
nnoremap <leader>sf :Files<CR>
nnoremap <leader>sh :History<CR>
nnoremap <leader><leader> :Buffers<CR>
nnoremap <leader>sq :CList<CR>    " For quickfix list
nnoremap <leader>sH :Helptags<CR>

" Grep current string
nnoremap <leader>ss :Rg <C-r><C-w><CR>

" Grep input string (fzf prompt)
nnoremap <leader>sg :Rg<Space>

" Grep for current file name (without extension)
nnoremap <leader>/ :execute 'Rg ' . expand('%:t:r')<CR>

" Enable diagnostics highlighting
let lspOpts = #{autoHighlightDiags: v:true}
autocmd User LspSetup call LspOptionsSet(lspOpts)
" Requires Go LSP gopls in PATH
" go install golang.org/x/tools/gopls@latest
let lspServers = [
      \ #{
      \   name: 'golang',
      \   filetype: ['go', 'gomod'],
      \   path: 'gopls',
      \   args: ['serve'],
      \   syncInit: v:true
      \ }
      \ ]

autocmd User LspSetup call LspAddServer(lspServers)

" LSP Key mappings
nnoremap grd :LspGotoDefinition<CR>
nnoremap grr :LspShowReferences<CR>
nnoremap gra :LspCodeAction<CR>
nnoremap K  :LspHover<CR>
nnoremap grl :LspDiag current<CR>
nnoremap <leader>nd :LspDiag next \| LspDiag current<CR>
nnoremap <leader>pd :LspDiag prev \| LspDiag current<CR>
inoremap <silent> <C-Space> <C-x><C-o>

" Custom diagnostic sign characters
autocmd User LspSetup call LspOptionsSet(#{
    \   diagSignErrorText: '󰅚 ',
    \   diagSignWarningText: "󰀪 ",
    \   diagSignInfoText: "󰋽 ",
    \   diagSignHintText: "󰌶 ",
    \ })
