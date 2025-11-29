#!/bin/bash
## install termux opener
hash ffmpeg  2>/dev/null || $sudo apt install -y ffmpeg 2>/dev/null; 
mkdir $HOME/bin 2>/dev/null; 
ln -s $HOME/88/c/termux-url-opener -t $HOME/bin 2>/dev/null; 
ln -s $HOME/88/c/termux-url-opener $HOME/bin/termux-file-editor 2>/dev/null; 
printf %b "\n-- installed termux-url-opener!\n"; 
