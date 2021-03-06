"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" References:
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" http://vimcasts.org
" http://nvie.com/posts/how-i-boosted-my-vim/
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
let mapleader = ","

" Do any specific vim setup in a local only vimrc.
let s:local_vimrc = expand("~/.vim/local.vimrc")
if filereadable(s:local_vimrc)
  "echomsg "Found readable local vimrc, sourcing..."
  exec "source " . s:local_vimrc
endif

filetype plugin indent on
syntax on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPTIONS
" -------

" Setup correct colors for terminals
if &term == "xterm" || &term == "screen"
  set background=dark
endif

" make tabs work
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
"set textwidth=80

" Search options
set incsearch
" case-insensitive unless search contains uppercase
set ignorecase
set smartcase

" Allow hidden characters
set concealcursor=nc

set autochdir
set autoread
"set clipboard=unnamedplus
set formatoptions+=j            " Allow removal of comment characters and such
                                " when merging lines with J.
set gdefault
set grepprg=grep\ -irn\ $*\ /dev/null
set modelines=0
"set mouse=a
set pastetoggle=<F2>
set ruler
set showcmd
set showmatch
set splitbelow
set splitright
set noswapfile
set wildmode=longest,list
set nowrap
set visualbell
set undofile

" Make the quickfix window occupy the entire width of the window.
botright cwindow

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom highlights
" -----------------

" Highlight status line for active window
hi StatusLine ctermfg=Cyan

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin options
" --------------

let Tlist_Sort_Type = "name"
let Tlist_Display_Tag_Scope = 0
let Tlist_WinWidth = 50

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My mappings
" -----------

" Use jk for switching out of insert / visual modes
inoremap jk <esc>
inoremap <esc> <nop>

vnoremap jk <esc>
vnoremap <esc> <nop>

" Open commonly used files in a vertical split
nnoremap <Leader>vv :vsp $MYVIMRC<cr>

nnoremap <Leader>w :q!<cr>

noremap <F1> :vert help
noremap <F4> :qall!
noremap <F12> :set paste!

" Search for all instances of word under the cursor and put results in the " quickfix window
noremap <Leader>lw :vimgrep <cword> %

" Underline the current line
nnoremap <Leader>u YpVr-k

" go to file in a vertical split
"nnoremap <Leader>v gd:vertical wincmd f " This works'ish for Java but not C++
nnoremap <Leader>vf :vertical wincmd F
nnoremap <Leader>sf F

" Move up / down display rather than lines (more natural when text is wrapped)
nnoremap j gj
nnoremap k gk

" Easier split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Minimize the current window horizontally (opposite of <C-w>|)
nnoremap <C-w>\ :vertical resize -1000

" Bracketed paste mode - https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My commands
" -----------
command E Explore

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Substitute the word under the cursor for the provided replacement

function! Replace()
  let l:currentWord = expand('<cword>')
  call inputsave()
  let l:replaceString = inputdialog('Replace "' . l:currentWord . '" with: ', l:currentWord)
  call inputrestore()
  if l:replaceString != ""
    execute ".,$s/\\<" . l:currentWord . "\\>/" . l:replaceString . "/c"
  endif
endfunction

noremap <Leader>s :call Replace()

"johnbarr's version
"nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto commands
augroup misc_autos
  autocmd!
  autocmd BufNewFile,BufRead *.jsont set ft=javascript
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tricks

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Testing
"set number
"set relativenumber

nnoremap ]i ]I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."]\t"<CR>

set wildmenu                    " Enhanced completion.
set wildmode=list:longest       " Act like shell completion.

" Complete my parens etc for me
"inoremap ( ()<ESC>i
"inoremap [ []<ESC>i
"inoremap { {}<ESC>i
