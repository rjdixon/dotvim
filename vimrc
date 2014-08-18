"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" References:
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" http://vimcasts.org
" http://nvie.com/posts/how-i-boosted-my-vim/
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on

let mapleader = ","

" Do any specific vim setup in a local only vimrc.
let s:local_vimrc = expand("~/.vim/local.vimrc")
if filereadable(s:local_vimrc)
  "echomsg "Found readable local vimrc, sourcing..."
  exec "source " . s:local_vimrc
endif

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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My mappings
" -----------

" Open commonly used files in a vertical split
nnoremap <Leader>vv :vsp $MYVIMRC<cr>

nnoremap zz :q!<cr>

" (de)indent 2 spaces up to mark a
noremap  :'a,.s/^  //
noremap  :'a,.s/^/  /

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
nnoremap <C-2>\ :vertical resize -1000

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My commands
" -----------
command! Rediff diffoff | diffthis

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Substitute the word under the cursor for the provided replacement

function! Replace()
  let l:currentWord = expand('<cword>')
  call inputsave()
  let l:replaceString = inputdialog('Replace "' . l:currentWord . '" with: ', l:currentWord)
  call inputrestore()
  if l:replaceString != ""
    "execute "%s/\<" . l:currentWord . "\>/" . l:replaceString . "/c"
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
  autocmd BufNewFile,BufRead */apiserving/config/games/*.api set ft=javascript

  " Set up file type for megastore mdl file
  au BufNewFile,BufRead *.mdl setf mdl
  au BufNewFile,BufRead *.topic setf gcl
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tricks

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Testing
"set number
"set relativenumber

" Train fingers to use jk for switching out of insert mode
inoremap jk <esc>
inoremap <esc> <nop>
inoremap <C-[> <nop>

vnoremap jk <esc>
vnoremap <esc> <nop>
vnoremap <C-[> <nop>

" Train muscle memory
nnoremap <C-w>j <nop>
nnoremap <C-w>k <nop>
nnoremap <C-w>h <nop>
nnoremap <C-w>l <nop>

nnoremap <Space> i_<esc>r
nnoremap K o<esc>
