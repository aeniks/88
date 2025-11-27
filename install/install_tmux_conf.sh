#!/bin/bash
## install tmux
mkdir -m 775 -p $HOME/.config/tmux/tpm/plugins; 
ln -s $HOME/88/c/tmux/tmux.conf -t $HOME/.config/tmux; 
ln -s $HOME/88/c/tmux/tmuxcompletions.sh -t $HOME/.config/tmux; 
