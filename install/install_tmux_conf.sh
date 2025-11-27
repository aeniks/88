#!/bin/bash
## install tmux
printf %b "\n-- installing tmux & configs ... \n"; 
mkdir -m 775 -p $HOME/.config/tmux/plugins/tpm 2>/dev/null; 
ln -s $HOME/88/c/tmux/tmux.conf -t $HOME/.config/tmux 2>/dev/null; 
ln -s $HOME/88/c/tmux/plugins/* -t $HOME/.config/tmux/plugins 2>/dev/null; 
ln -s $HOME/88/c/tmux/tmuxcompletions.sh -t $HOME/.config/tmux 2>/dev/null; 
printf %b "\n-- done!\n\n"; 
