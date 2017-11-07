filetype plugin indent on
syntax on
set encoding=utf-8

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'lervag/vimtex'
Plugin 'easymotion/vim-easymotion'
Plugin 'vim-airline/vim-airline'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ajh17/vimcompletesme'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'

call vundle#end()

filetype plugin indent on

" Mappings
inoremap jk <ESC>
let mapleader = "\<Space>"
:imap <D-v> ^O:set paste<Enter>^R+^O:set nopaste<Enter>

" Text settings
set nowrap
set shiftwidth=2
set tabstop=2
set backspace=indent,eol,start
set autoindent
set copyindent
set shiftround
set showmatch
set ignorecase
set smartcase
set smarttab
set expandtab
set hlsearch
set incsearch
set wrap
set linebreak
set nolist
set laststatus=2
set relativenumber
autocmd BufWritePre * StripWhitespace

" Get rid of backup files
set nobackup
set noswapfile

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
" Airline settings
let g:airline_theme='sol'

" NERDTree settings
map <C-n> :NERDTreeToggle<CR> " Map ctrl-n to NERDTree

" Vim window settings
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
set splitbelow
set splitright
colors calmbreeze
set relativenumber



