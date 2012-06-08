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

" Lines
set number

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

" OmniCompletion
" Close preview window opened by omnicompletion on movement in insert 
" mode or when leaving insert mode 
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Auto commands
" Identify Markdown files (don't think I'll be using Modula2...)
au BufRead,BufNewFile {*.md,*.mkd,*.markdown} set ft=markdown


" =====================================================================
" Local setup - only works because we source this file from the main
" vimrc file.
"
let thisdir = expand('<sfile>:p:h')
exec 'set rtp+='.thisdir.'/vimfiles'
exec 'set rtp+='.thisdir.'/vimfiles/after'

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
let snip_name=substitute(system("git config --get user.name"), "\n", "", "g")
let snip_mail=substitute(system("git config --get user.email"), "\n", "", "g")
let g:snips_author=snip_name.' <'.snip_mail.'>'


" My Snipmate extensions
Bundle "drbenmorgan/dbm-snippets.vim.git"

" Softblue colorscheme
Bundle "softblue"

" jellybeans colorscheme
Bundle "nanotech/jellybeans.vim"

" zenburn colorscheme
Bundle "Zenburn"

" Solarized colorscheme
Bundle "altercation/vim-colors-solarized.git"

" ConqueShell terminal emulator
Bundle "Conque-Shell"

" SuperTab insert mode completions
Bundle "ervandew/supertab"
let g:SuperTabDefaultCompletionType = "context"

" Google style indentation for C++
" Use iveney's fork which renames the plugin correctly!
Bundle "iveney/google.vim"

" Tim Pope's fugitive plugin for git
Bundle "tpope/vim-fugitive.git"

filetype plugin indent on    " required by Vundle...

" =====================================================================
" Colorscheme defaults - after bundles because chosen schemes are in
" bundles!
set background=dark
if &t_Co == 256
  colorscheme jellybeans
else
  colorscheme default
endif

" =====================================================================
" Configure GUI, if running
"
if has("gui_running")
  " Colorscheme for gui
  set background=dark
  colorscheme solarized

  " Nice font
  " Ouch, syntax is different on Mac and GTK2...
  if has("macunix")
    " Plus, Monaco for Lion, Inconsolata for Snow Leopard
    let mymacver = system("sw_vers -productVersion")
    if match(mymacver, "10.7.*") >= 0
      set gfn=Monaco:h14
    else
      set gfn=Inconsolata:h18
    endif
  else
    set gfn=Inconsolata\ 14
  endif
  
  " No toolbar
  set guioptions-=T

  " Useful cut'n'paste
  set guioptions+=a
endif

"======================================================================
" Disable unsafe commands in local .vimrc files
" Should always be last line!
set secure

