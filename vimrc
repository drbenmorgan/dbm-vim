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

" Identify GNUmake fragments as make
au BufRead,BufNewFile {*.gmk,*.gmake,*.gnumake} set ft=make

" =====================================================================
" Trailing whitespace
" Highlight it (can also use c_space_errors, but we want to apply it to
" pretty much everything for now)
" See http://vim.wikia.com/wiki/Highlight_unwanted_spaces
" Note though that double highlight seems to be needed to make highlight
" known and to prvent subsequent colorscheme deletion.
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Remove it automatically for subset of filetypes
autocmd FileType c,cpp,cmake,python,rst,markdown,xml autocmd BufWritePre <buffer> :%s/\s\+$//e

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
let vundle_git  = 'http://github.com/gmarik/Vundle.vim.git'

if !isdirectory(expand(vundle_root, 1).'/vundle')
  exec '!git clone '.vundle_git.' '.expand(vundle_root, 1).'/vundle'
endif

" Start up Vundle
exec 'set rtp+='.vundle_root.'/vundle'
call vundle#begin(vundle_root)

" List my bundles
" Let Vundle manage Vundle - required
Plugin 'gmarik/Vundle.vim'

" Snipmate
Plugin 'msanders/snipmate.vim'
let snip_name=substitute(system("git config --get user.name"), "\n", "", "g")
let snip_mail=substitute(system("git config --get user.email"), "\n", "", "g")
let g:snips_author=snip_name.' <'.snip_mail.'>'

" My Snipmate extensions
Plugin 'drbenmorgan/dbm-snippets.vim'

" Softblue colorscheme
Plugin 'softblue'

" jellybeans colorscheme
Plugin 'nanotech/jellybeans.vim'

" zenburn colorscheme
Plugin 'Zenburn'

" Solarized colorscheme
Plugin 'altercation/vim-colors-solarized'

" ConqueShell terminal emulator
Plugin 'Conque-Shell'

" SuperTab insert mode completions
Plugin 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "context"

" Google style indentation for C++
" Use iveney's fork which renames the plugin correctly!
Plugin 'iveney/google.vim'

" Tim Pope's fugitive plugin for git
Plugin 'tpope/vim-fugitive'

" Tim Pope's markdown syntax highlighting
Plugin 'tpope/vim-markdown'

" vim-pandoc for writing and editing documents in pandoc markdown
" Only on vim 7.4
if v:version > 703
  Plugin 'vim-pandoc/vim-pandoc'
  let g:pandoc_no_folding = 1
endif

" Required end-of-setup for vundle
call vundle#end()
filetype plugin indent on

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
      set gfn=Monaco:h14
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

