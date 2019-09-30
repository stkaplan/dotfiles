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
highlight PMenu ctermbg=grey
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

augroup ft_statuslinecolor
    au!

    au InsertEnter * hi StatusLine ctermfg=196 guifg=#FF3145
    au InsertLeave * hi StatusLine ctermfg=130 guifg=#CD5907
augroup END

" Linediff mappings
vnoremap <leader>l :Linediff<cr>
nnoremap <leader>L :LinediffReset<cr>

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

" Disable bell, since vim ignores /etc/inputrc
set visualbell
set t_vb=

let g:coc_global_extensions = [ 'coc-python' ]

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
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
inoremap <silent><expr> <NUL> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
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

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
