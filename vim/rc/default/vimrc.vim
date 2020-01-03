" Core
" ====

set encoding=utf-8
scriptencoding utf-8

" Editor
" ------
syntax on
filetype on
filetype plugin indent on

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set backspace=indent,eol,start
set clipboard=unnamed

set number
set laststatus=2
set showtabline=2
set ambiwidth=double

set completeopt-=preview

colorscheme smyck
set showtabline=0

" Files
" -----

set directory=~/.cache/vim/swap
set backupdir=~/.cache/vim/backup

" Mouse
" -----
set mouse=a
set ttymouse=xterm2

" GVIM
" ----
if has('gui_running')
 if has('unix')
    set guifont=Monospace\ 12
    colorscheme smyck
  end

  set guioptions-=T
  set guioptions-=m
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=L
  set guioptions-=b
endif
