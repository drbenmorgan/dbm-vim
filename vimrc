" My main vimrc file.
" =====================================================================
" Author: Ben Morgan
" 
" =====================================================================
" Core vim settings
"
" Use Vim settings rather than Vi
set nocompatible

" Syntax highlighting
syntax on


" =====================================================================
" Set up Vundle before anything else.
" Uses ideas from gmarik's testing vimrc.
"
filetype off    " required by Vundle...

" Setup Vundle's local repository for bundles, and clone Vundle itself
" if we don't have it already
let vundle_root = '~/.vundle/bundles'
let vundle_git  = 'http://github.com/gmarik/vundle.git'

if !isdirectory(expand(vundle_root, 1).'/vundle')
  exec '!git clone '.vundle_git.' '.expand(vundle_root, 1).'/vundle'
endif

" Start up Vundle
exec 'set rtp+='.vundle_root.'/vundle'
call vundle#rc(vundle_root)

" List my bundles
" Let Vundle manage Vundle - required
Bundle vundle_git

" Snipmate
Bundle "msanders/snipmate.vim.git"

" My Snipmate extensions
Bundle "drbenmorgan/dbm-snippets.vim.git"

" Softblue colorscheme
Bundle "softblue"

" jellybeans colorscheme
Bundle "nanotech/jellybeans.vim"

" ConqueShell terminal emulator
Bundle "Conque-Shell"

" SuperTab insert mode completions
Bundle "ervandew/supertab"

" Google style indentation for C++
Bundle "google.vim"

filetype plugin indent on    " required by Vundle...


" =====================================================================
" Main setup of Vim, including any loaded bundles
"
" History
set history=50

" Make backups in tmp
set backupdir=~/tmp/vim
set backup

" Use incremental search
set incsearch

" Status Line
set laststatus=2
set statusline=%t%m%y\%=[%l/%L][%c]

" Tabs and Indents
set expandtab
set tabstop=2
set shiftwidth=2
set smartindent

" Snipmate
let snip_name=substitute(system("git config --get user.name"), "\n", "", "g")
let snip_mail=substitute(system("git config --get user.email"), "\n", "", "g")
let g:snips_author=snip_name.' <'.snip_mail.'>'

" Supertab
let g:SuperTabDefaultCompletionType = "context"

" Colorscheme
colorscheme default

"======================================================================
" Configure GUI, if running
"
if has("gui_running")
  " Colorscheme for gui
  colorscheme softblue

  " Nice font
  set gfn=Inconsolata:h18
  
  " No toolbar
  set guioptions-=T

  " Useful cut'n'paste
  set guioptions+=a
endif


"======================================================================
" Disable unsafe commands in local .vimrc files
" Should always be last line!
set secure

