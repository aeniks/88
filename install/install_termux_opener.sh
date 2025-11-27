#!/bin/bash
## install termux opener
apt install -y ffmpeg; 
mkdir $HOME/bin 2>/dev/null; 
ln -s $HOME/88/c/termux-url-opener -t $PREFIX/bin; 
ln -s $HOME/88/c/termux-url-opener $PREFIX/bin/termux-file-editor; 
