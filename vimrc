source ~/.vim/bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

" toggle filetype off and on: needed for certain plugins
filetype off
filetype indent plugin on

set nocompatible    " vanilla vi: not even once

" tab settings: expand to 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent      " start line at same indentation as previous line
set backspace=indent,eol,start   " allow backspacing over these
set showmatch       " brief jump to matching bracket

set showmode        " show if in INSERT mode
set showcmd         " show command being typed
set ruler           " show line and column of cursor
set scrolloff=3     " 3 lines above or below cursor
set laststatus=2    " always show status bar at bottom

set wildmode=list:longest,full  " do bash-style tab-completion
set wildmenu        " pop-up menu when multiple matches for tab-completion

set nohls           " don't highlight search results
set ignorecase      " search is case-insensitive
set smartcase       " ...unless the search contains uppercase letters
set incsearch       " start searching before hitting Enter

" disable arrow keys in normal mode (use hjkl instead)
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" disable arrow keys in insert mode (go back to normal mode instead)
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" go up/down by a screen line instead of by text line
nnoremap j gj
nnoremap k gk

" use brighter colors, but only in terminal
if has('gui_running')
    set background=light
else
    set background=dark
endif

set mouse=a         " mouse support in all modes

" .ll files should use llvm syntax highlighting
au BufNewFile,BufRead *.ll set filetype=llvm
" .td files should use tablegen syntax highlighting
au BufNewFile,BufRead *.td set filetype=tablegen

" Persisent undo
set undodir=~/.vim/undodir
set undofile

" better-looking completion menus
highlight PMenuSel cterm=reverse

" mapping to remove trailing whitespace in current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
