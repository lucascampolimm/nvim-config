call plug#begin()

Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()

" Theme
colorscheme dracula

" Preferences
syntax on
set nu
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent
set hidden
set incsearch
set ignorecase
set smartcase
set scrolloff=8
set colorcolumn=100
set signcolumn=no
set cmdheight=1
set updatetime=100
set encoding=utf-8
set nobackup
set nowritebackup
set splitright
set splitbelow
set autoread
set mouse=a
filetype on
filetype plugin on
filetype indent on
