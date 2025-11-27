-- Use `:help quickref` for documentation about the options

-- Basic settings
vim.opt.number = true -- Line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.cursorline = true -- Highlight current line
vim.opt.wrap = false -- Don't wrap lines
vim.opt.scrolloff = 10 -- Keep 10 lines above/below cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor

-- Indentation
vim.opt.tabstop = 4 -- Tab width
vim.opt.shiftwidth = 4 -- Indent width
vim.opt.softtabstop = 4 -- Soft tab stop
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.autoindent = true -- Copy indent from current line

-- Grep
vim.opt.grepprg = "rg --vimgrep" -- Use ripgrep if available
vim.opt.grepformat = "%f:%l:%c:%m" -- filename, line number, column, content

-- Search settings
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- Case sensitive if uppercase in search
vim.opt.hlsearch = true -- Highlight search results
vim.opt.incsearch = true -- Show matches as you type

-- Visual settings
vim.opt.termguicolors = true -- Enable 24-bit colors
vim.opt.signcolumn = "yes" -- Always show sign column
vim.opt.colorcolumn = "100" -- Show column at 100 characters
vim.opt.showmatch = true -- Highlight matching brackets
vim.opt.matchtime = 2 -- How long to show matching bracket
vim.opt.cmdheight = 1 -- Command line height
vim.opt.completeopt = "menuone,noinsert,noselect" -- Completion options
vim.opt.showmode = false -- Don't show mode in command line
vim.opt.pumheight = 10 -- Popup menu height
vim.opt.lazyredraw = true -- Don't redraw during macros
vim.opt.synmaxcol = 300 -- Syntax highlighting limit
vim.opt.list = true -- Enable display of list chars
vim.opt.listchars = { -- Configure what chars are shown for
  tab = "› ", -- tabs
  trail = "·", -- trailing whitespace
  nbsp = "␣", -- non-breaking spaces
}
vim.opt.winborder = "rounded" -- Window and floating border style

-- File handling
vim.opt.backup = false -- Don't create backup files
vim.opt.writebackup = false -- Don't create backup before writing
vim.opt.swapfile = false -- Don't create swap files
vim.opt.undofile = true -- Persistent undo
vim.opt.undodir = vim.fn.expand "~/.nvim/undodir" -- Undo directory
vim.opt.updatetime = 205 -- Faster completion
vim.opt.timeoutlen = 500 -- Key timeout duration
vim.opt.ttimeoutlen = 0 -- Key code timeout
vim.opt.autoread = true -- Auto reload files changed outside vim
vim.opt.autowrite = false -- Don't auto save

-- Behavior settings
vim.opt.hidden = true -- Allow hidden buffers
vim.opt.errorbells = false -- No error bells
vim.opt.backspace = "indent,eol,start" -- Better backspace behavior
vim.opt.autochdir = true -- Auto change directory
vim.opt.iskeyword:append "-" -- Treat dash as part of word
vim.opt.path:append "**" -- include subdirectories in search
vim.opt.selection = "exclusive" -- Selection behavior
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.clipboard:append "unnamedplus" -- Use system clipboard
vim.opt.modifiable = true -- Allow buffer modifications
vim.opt.encoding = "UTF-8" -- Set encoding
vim.opt.confirm = true -- Ask for unsaved changes
vim.opt.inccommand = "split" -- Preview effects of commands in a window

-- Folding settings
vim.opt.foldmethod = "expr" -- Use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use treesitter for folding
vim.opt.foldlevel = 99 -- Start with all folds open

-- Split behavior
vim.opt.splitbelow = true -- Horizontal splits go below
vim.opt.splitright = true -- Vertical splits go right

-- Command-line completion
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append { "*.o", "*.obj", "*.pyc", "*.class", "*.jar" }

-- Better diff options
vim.opt.diffopt:append "linematch:60"

-- Personal global variables
vim.g.replace_tabs = true -- Replace tabs to spaces on autoformatting
vim.g.training_wheels = true -- Enable which-key
vim.g.disable_autoformat = false -- Disable formatting file on saving
vim.g.finder_on_open = true -- Open a fuzzy finder floater if nvim starts with no file
