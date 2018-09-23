set encoding=utf-8
syntax on
filetype plugin indent on

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
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
Plugin 'tpope/vim-fugitive'
Plugin 'prettier/vim-prettier'
Plugin 'rking/ag.vim'
Plugin 'tmhedberg/simpylfold'
Plugin 'chriskempson/base16-vim'
Plugin 'elzr/vim-json'
Plugin 'danro/rename.vim'
Plugin 'stephpy/vim-yaml'
Plugin 'farmergreg/vim-lastplace'
Plugin 'PeterRincker/vim-argumentative'

" Plugin 'honza/vim-snippets'
" Plugin 'SirVer/ultisnips'

call vundle#end()

colo base16-default-dark

" Changing colors I don't like
hi LineNr term=bold cterm=None ctermfg=DarkGrey ctermbg=None
hi Folded ctermbg=Yellow ctermfg=Black
hi CursorLineNr ctermbg=None ctermfg=cyan
hi CursorLine ctermbg=Yellow ctermfg=cyan
hi IncSearch ctermbg=Yellow cterm=None ctermfg=Black
hi Search ctermbg=Yellow cterm=None ctermfg=Black
hi SpellBad ctermbg=blue ctermfg=Black
hi SignColumn ctermbg=blue ctermfg=Black
hi SyntasticWarningSign ctermbg=blue ctermfg=Black
hi SyntasticErrorSign ctermbg=blue ctermfg=Black


" Mappings
inoremap jk <ESC>
let mapleader = "\<Space>"
:imap <D-v> ^O:set paste<Enter>^R+^O:set nopaste<Enter>

" Text settings
set nowrap
set shiftwidth=4
set tabstop=4
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
set autoread
au CursorHold * checktime
autocmd BufWritePre * StripWhitespace

" Get rid of backup files
set nobackup
set noswapfile

" Syntastic settings
let g:syntastic_always_populate_loc_list = 1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
nnoremap <silent> <C-c> :Error<CR>

" Airline settings
let g:airline_powerline_fonts = 1
let g:tmuxline_powerline_separators = 1

let g:lightline = {
  \   'colorscheme': 'seoul256',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'readonly', 'filename', 'modified']
  \     ],
  \     'right':[ ['lineinfo'],
  \               ['percent'],
  \               ['fileformat', 'fileencoding', 'filetype'] ]
  \   },
	\   'component': {
	\     'lineinfo': ' %3l:%-2v',
	\   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \     'filename': 'LightlineFilename',
  \   }
  \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

let g:lightline.subseparator = {
	\   'left': '', 'right': ''
\}

set guioptions-=e  " Don't use GUI tabline

let g:tmuxline_preset = {
      \'a'    : '#S',
      \'c'    : '#H',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'x'    : '#(date +"%A, %B %e %Y")',
      \'y'    : '#(date +"%r")',
      \'z'    : '#(whoami)'}


" NERDTree settings
map <C-n> :NERDTreeToggle<CR> " Map ctrl-n to NERDTree
let g:NERDTreeHijackNetrw=0
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('ini', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('md', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'gray', 'none', 'gray', '#151515')
call NERDTreeHighlightFile('html', 'gray', 'none', 'gray', '#151515')
call NERDTreeHighlightFile('py', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('js', 'Magenta', 'none', 'ff00ff', '#151515')

" ctrlp settings
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
set wildignore+=**/node_modules/**,**/package-lock.json,**/virtualenv_run/**

set splitbelow
set splitright
set relativenumber

" Mark json files as type json -.-
au BufRead,BufNewFile *.json set filetype=json

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

" folding properties
let g:SimpylFold_docstring_preview = 0
set foldlevelstart=1

" resize vim splits
nnoremap <C-W>h :call TmuxResize('h', 10)<CR>
nnoremap <C-W>j :call TmuxResize('j', 10)<CR>
nnoremap <C-W>k :call TmuxResize('k', 10)<CR>
nnoremap <C-W>l :call TmuxResize('l', 10)<CR>

" move between vim splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Ag settings
nmap <C-s> :Ag "def <cword>" . <CR>

" Buffer settings
nnoremap <silent> <C-z> :bn<CR>
nnoremap <silent> <C-x> :bp<CR>

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

