#!/bin/bash
## install tmux
apt install -y autoconf libevent ncurses pkg-config automake; mkdir $HOME/gh 2>/dev/null; cd $HOME/gh; gh repo clone tmux/tmux;
