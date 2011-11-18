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

set showmode        " show if in INSERT mode
set showcmd         " show command being typed
set ruler           " show line and column of cursor
set scrolloff=3     " 3 lines above or below cursor
set laststatus=2    " always show status bar at bottom

set wildmode=list:longest,full  " do bash-style tab-completion
set wildmenu        " pop-up menu when multiple matches for tab-completion
set wildignore+=.git,.hg,.svn       " version control files
set wildignore+=*.aux,*.out,*.toc   " LaTeX intermediate files
set wildignore+=*.o,*.so,*.a        " object files
set wildignore+=*.sw?               " vim swap files

set nohls           " don't highlight search results
set ignorecase      " search is case-insensitive
set smartcase       " ...unless the search contains uppercase letters
set showmatch       " brief jump to matching bracket
set incsearch       " start searching before hitting Enter

set nomodeline      " I never use these, and it sometimes breaks git commits

set splitbelow      " make :split create the new window below
set splitright      " make :vsplit create the new window on right

" resize splits when window is resized
au VimResized * exe "normal! \<c-w>="

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
set undodir=~/.vim/tmp/undodir//
set undofile

set backupdir=~/.vim/tmp/backup//
set backup

set directory=~/.vim/tmp/swap//

" better-looking completion menus
highlight PMenuSel cterm=reverse

" mapping to remove trailing whitespace in current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Turn on folding for XML files
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Ye shall be judged
iabbrev ldis ಠ_ಠ

" Use sane regexes
nnoremap / /\v
vnoremap / /\v

" Quick jump to beginning or end of line
noremap H ^
noremap L g_

" Easy buffer navigation
noremap <C-h>  <C-w>h
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l
noremap <leader>v <C-w>v

" Reduce pinky strain
nnoremap ; :

" Shortcut to toggle rainbow parentheses
nnoremap <leader>R :RainbowParenthesesToggle<cr>
