dbm-vim
=======
My personal vim configuration. Very preliminary, very unstable, and much 
to learn!


Setup
=====
The vimrc file is intended to be sourced by the main user vimrc file
($HOME/.vimrc or $HOME/_vimrc). Thies allows the main vimrc to be very simple,
and also easily deployable across different platforms. 

It also allows the vimrc file here to locate itself and hence to source
other vim scripts or to point the runtimepath to a directory under this one. 
The primary purpose of this is to allow some degree of modularization, and
also testing of new scripts/plugins (I am also just playing!).

However, the main system used to provide add-ons is via bundles managed
by Vundle (see below).


Bundles
=======
I use Vundle by gmarik to manage vim addons. You can get it from github:

http://github.com/gmarik/vundle

