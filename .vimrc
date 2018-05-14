set encoding=utf-8
syntax on
filetype plugin indent on

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'mru.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'lervag/vimtex'
Plugin 'easymotion/vim-easymotion'
Plugin 'edkolev/tmuxline.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'ajh17/vimcompletesme'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'
Plugin 'dmdque/solidity.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'lambdalisue/battery.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'prettier/vim-prettier'

call vundle#end()

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
let g:syntastic_always_populate_loc_list = 1

" Airline settings
let g:airline_powerline_fonts = 1
let g:tmuxline_powerline_separators = 0

let g:lightline = {
  \   'colorscheme': 'powerline',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'readonly', 'filename', 'modified']
  \     ],
  \     'right':[ ['lineinfo'],
  \               ['percent'],
  \               ['fileformat', 'fileencoding', 'filetype', 'battery'] ]
  \   },
	\   'component': {
	\     'lineinfo': ' %3l:%-2v',
	\   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \     'battery': 'battery#component',
  \   }
  \ }

let g:lightline.subseparator = {
	\   'left': '', 'right': ''
\}

set guioptions-=e  " Don't use GUI tabline

let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#W',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'y'    : '#(date)',
      \'z'    : '#(whoami)'}


" NERDTree settings
map <C-n> :NERDTreeToggle<CR> " Map ctrl-n to NERDTree

" Vim window settings
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
set splitbelow
set splitright
set relativenumber

colors calmbreeze

" No more :set paste/:set nopaste!
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" Tmux-like window resizing
function! IsEdgeWindowSelected(direction)
    let l:curwindow = winnr()
    exec "wincmd ".a:direction
    let l:result = l:curwindow == winnr()

    if (!l:result)
        " Go back to the previous window
        exec l:curwindow."wincmd w"
    endif

    return l:result
endfunction

function! GetAction(direction)
    let l:keys = ['h', 'j', 'k', 'l']
    let l:actions = ['vertical resize -', 'resize +', 'resize -', 'vertical resize +']
    return get(l:actions, index(l:keys, a:direction))
endfunction

function! GetOpposite(direction)
    let l:keys = ['h', 'j', 'k', 'l']
    let l:opposites = ['l', 'k', 'j', 'h']
    return get(l:opposites, index(l:keys, a:direction))
endfunction

function! TmuxResize(direction, amount)
    " v >
    if (a:direction == 'j' || a:direction == 'l')
        if IsEdgeWindowSelected(a:direction)
            let l:opposite = GetOpposite(a:direction)
            let l:curwindow = winnr()
            exec 'wincmd '.l:opposite
            let l:action = GetAction(a:direction)
            exec l:action.a:amount
            exec l:curwindow.'wincmd w'
            return
        endif
    " < ^
    elseif (a:direction == 'h' || a:direction == 'k')
        let l:opposite = GetOpposite(a:direction)
        if IsEdgeWindowSelected(l:opposite)
            let l:curwindow = winnr()
            exec 'wincmd '.a:direction
            let l:action = GetAction(a:direction)
            exec l:action.a:amount
            exec l:curwindow.'wincmd w'
            return
        endif
    endif

    let l:action = GetAction(a:direction)
    exec l:action.a:amount
endfunction

"let g:prettier#autoformat = 0
"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue Prettier

" Map to buttons
nnoremap <C-W>h :call TmuxResize('h', 10)<CR>
nnoremap <C-W>j :call TmuxResize('j', 10)<CR>
nnoremap <C-W>k :call TmuxResize('k', 10)<CR>
nnoremap <C-W>l :call TmuxResize('l', 10)<CR>
