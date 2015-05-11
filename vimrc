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
set wildignore+=*.swp,*.swo         " vim swap files

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
if has('mouse_sgr')
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

" .ll files should use llvm syntax highlighting
au BufNewFile,BufRead *.ll set filetype=llvm
" .td files should use tablegen syntax highlighting
au BufNewFile,BufRead *.td set filetype=tablegen
" .xe_asm files should use asm syntax highliting
au BufNewFile,BufRead *.xe_asm set filetype=asm
" swarm2c files should use C syntax highlighting
au BufNewFile,BufRead *.swc set filetype=c
au BufNewFile,BufRead *.swh set filetype=c


" Persisent undo
set undodir=~/.vim/tmp/undo//
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

" Easily create blank lines
nnoremap <Enter> o<ESC>
nnoremap <S-Enter> O<ESC>

" Shortcut to toggle rainbow parentheses
nnoremap <leader>R :RainbowParenthesesToggle<cr>

augroup ft_statuslinecolor
    au!

    au InsertEnter * hi StatusLine ctermfg=196 guifg=#FF3145
    au InsertLeave * hi StatusLine ctermfg=130 guifg=#CD5907
augroup END

let g:syntastic_enable_signs = 1
let g:syntastic_stl_format = '[%E{Error 1/%e: line %fe}%B{, }%W{Warning 1/%w: line %fw}]'

" Fugitive mappings
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>ga :Gadd<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gco :Gcheckout<cr>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gr :Gremove<cr>

" Linediff mappings
vnoremap <leader>l :Linediff<cr>
nnoremap <leader>L :LinediffReset<cr>

" Remap TaskList to avoid conflict with Command-T
map <leader>T <Plug>TaskList

" Show name of current C function
fun! ShowFuncName()
    let lnum = line(".")
    let col = col(".")
    echohl ModeMsg
    echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
    echohl None
    call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
map <leader>f :call ShowFuncName() <CR>

" Don't exit visual mode after shifting
vnoremap < <gv
vnoremap > >gv

" Return to normal mode on FocusLost
au FocusLost * call feedkeys("\<C-\>\<C-n>")

" Options for powerline
set t_Co=256
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_linecolumn_prefix = '␊ '
let g:airline_linecolumn_prefix = '␤ '
let g:airline_linecolumn_prefix = '¶ '
let g:airline_branch_prefix = '⎇ '
let g:airline_paste_symbol = 'ρ'
let g:airline_paste_symbol = 'Þ'
let g:airline_paste_symbol = '∥'
let g:airline_whitespace_symbol = 'Ξ'

" Hit F8 to toggle Taglist
nnoremap <silent> <F8> :TlistToggle<CR>
" Only show active file in Taglist
let g:Tlist_Show_One_File=1

" Don't let ctrlp go up to .git dir -- too many files!
let g:ctrlp_working_path_mode = '0'

" Scale syntax highlighting based on /usr/share/vim/vim73/syntax/c.vim.
au BufNewFile,BufRead *.{swh,swc} set filetype=c
au BufNewFile,BufRead *.{swh,swc} syn keyword cStorageClass swarm_abstract
au BufNewFile,BufRead *.{swh,swc} syn keyword cError        swarm_callback
au BufNewFile,BufRead *.{swh,swc} syn keyword cOperator     swarm_cargs
au BufNewFile,BufRead *.{swh,swc} syn keyword cStorageClass swarm_codelet
au BufNewFile,BufRead *.{swh,swc} syn keyword cError        swarm_codelet_function
au BufNewFile,BufRead *.{swh,swc} syn keyword cStorageClass swarm_ctor
au BufNewFile,BufRead *.{swh,swc} syn keyword cStorageClass swarm_ctor_constexpr
au BufNewFile,BufRead *.{swh,swc} syn keyword cStorageClass swarm_dtor
au BufNewFile,BufRead *.{swh,swc} syn keyword cOperator     swarm_enter
au BufNewFile,BufRead *.{swh,swc} syn keyword cStorageClass swarm_interface
au BufNewFile,BufRead *.{swh,swc} syn keyword cStorageClass swarm_final
au BufNewFile,BufRead *.{swh,swc} syn keyword cStorageClass swarm_procedure
au BufNewFile,BufRead *.{swh,swc} syn keyword cStatement    swarm_return
au BufNewFile,BufRead *.{swh,swc} syn keyword cStructure    swarm_type
au BufNewFile,BufRead *.{swh,swc} syn keyword cStorageClass swarm_virtual
au BufNewFile,BufRead *.{swh,swc} syn keyword cPreProc      SWARM_CONFIG
au BufNewFile,BufRead *.{swh,swc} syn keyword cPreProc      SWARM_EXTENDS
au BufNewFile,BufRead *.{swh,swc} syn keyword cPreProc      SWARM_EXTENDS_INTERFACE
au BufNewFile,BufRead *.{swh,swc} syn keyword cPreProc      SWARM_HLTYPE
au BufNewFile,BufRead *.{swh,swc} syn keyword cPreProc      SWARM_HLTYPE_FORWARD
au BufNewFile,BufRead *.{swh,swc} syn keyword cPreProc      SWARM_INTERFACE
" These are like "this" in /usr/share/vim/vim73/syntax/cpp.vim.
au BufNewFile,BufRead *.{swh,swc} syn keyword cStatement    swarm_context
au BufNewFile,BufRead *.{swh,swc} syn keyword cStatement    swarm_env
au BufNewFile,BufRead *.{swh,swc} syn keyword cStatement    swarm_input
au BufNewFile,BufRead *.{swh,swc} syn keyword cStatement    swarm_next
au BufNewFile,BufRead *.{swh,swc} syn keyword cStatement    swarm_next_this
au BufNewFile,BufRead *.{swh,swc} syn keyword cStatement    swarm_this
