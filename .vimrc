set nocompatible
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
Plugin 'mru.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'kchmck/vim-coffee-script'
Plugin 'lervag/vimtex'
Plugin 'easymotion/vim-easymotion'
Plugin 'edkolev/tmuxline.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'
Plugin 'dmdque/solidity.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'rking/ag.vim'
Plugin 'konfekt/fastfold'
Plugin 'elzr/vim-json'
Plugin 'danro/rename.vim'
Plugin 'stephpy/vim-yaml'
Plugin 'farmergreg/vim-lastplace'
Plugin 'PeterRincker/vim-argumentative'
Plugin 'ryanoasis/vim-devicons'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'gavocanov/vim-js-indent'
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'neoclide/coc.nvim'

call vundle#end()

colorscheme zenburn

" Changing colors I don't like
hi LineNr term=bold cterm=None ctermfg=DarkGrey ctermbg=None
hi Folded ctermbg=Yellow ctermfg=Black
hi CursorLineNr ctermbg=None ctermfg=cyan
hi CursorLine ctermbg=Yellow ctermfg=cyan
hi IncSearch ctermbg=Yellow cterm=None ctermfg=Black
hi Search ctermbg=Yellow cterm=None ctermfg=Black
hi SpellBad ctermbg=DarkGray ctermfg=Black
hi SignColumn ctermbg=Black ctermfg=Black
hi QuickFixLine ctermbg=blue ctermfg=Black
hi Pmenu ctermbg=darkgray ctermfg=lightgray
hi PmenuSel ctermbg=lightgray ctermfg=darkgray
hi CocFloat ctermbg=darkgray ctermfg=lightgray
hi CocErrorFloat ctermbg=darkgray ctermfg=lightgray
hi CocInfoFloat ctermbg=darkgray ctermfg=lightgray
hi CocWarningFloat ctermbg=darkgray ctermfg=lightgray
hi CocHighlightText ctermbg=darkgray ctermfg=lightgray


" Mappings
inoremap jk <ESC>
:imap <D-v> ^O:set paste<Enter>^R+^O:set nopaste<Enter>

" Text settings
set nowrap
set shiftwidth=4
set tabstop=4
set softtabstop=0
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

" Autocomplete with coc
let g:coc_global_extensions = [
  \ 'coc-pairs',
  \ 'coc-python',
  \ ]
let g:coc_disable_startup_warning = 1

set hidden
set updatetime=300
set signcolumn=yes

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <Nul> coc#refresh()

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Remap for rename current word
nmap <C-f> <Plug>(coc-rename)

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Airline settings
let g:airline_powerline_fonts = 1
let g:tmuxline_powerline_separators = 1

let g:lightline = {
  \   'colorscheme': 'one',
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
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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
au BufRead,BufNewFile *.json* set filetype=json

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

" move between vim splits
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

" resize vim splits
nnoremap <C-W>h :call TmuxResize('h', 10)<CR>
nnoremap <C-W>j :call TmuxResize('j', 10)<CR>
nnoremap <C-W>k :call TmuxResize('k', 10)<CR>
nnoremap <C-W>l :call TmuxResize('l', 10)<CR>

" Ag settings
nmap <C-s> :Ag "def <cword>" . <CR>

" Buffer settings
command Bd bp\|bd \#
nnoremap <silent> <C-z> :bn<CR>
nnoremap <silent> <C-x> :bp<CR>

nnoremap <C-,> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>
nnoremap <C-.> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>


" reload vimrc
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
