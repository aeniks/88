#!/bin/bash
## nstaller

aapp=(\
fzf \
net-tools \
ffmpeg \
tmux \
lf \
bat \
chafa \
openssh \
bash-completion \
neofetch \
micro \
git \
aria2 \
aria2c \
gh \
mosh \
ripgrep \
jp2a \
mediainfo \
exiftool \
lsd \ 
); 


# $sudo apt install -y fzf net-tools ffmpeg tmux lf bat chafa openssh bash-completion neofetch micro; 


[ -z $PREFIX ] && [ $UID -gt 0 ] && sudo=sudo; sleep .4; 
printf %b "\n -- hello"; sleep .4; 
printf %b "\n -- install apps?"; sleep .4; printf %b " [Y/n] "; 
read -sn1 "ny"; 
if [ -z $ny ]; then sleep .4; printf %b "\t\e[92m  ok\e[96m  \n\n"; 
$sudo apt update; 
printf %b "\n\t\e[0m[\e[92mok\e[0m]\e[95m\n"; 
printf %b "\t\e[92m  ok\e[96m  \n\n"; 
$sudo apt upgrade -y; 
printf %b "\n\n ----- ok -----\n\n"; 
for i in ${aapp[*]}; do 
printf $b "\n -\e[222b\n\n ----- $i -----\n-\e[222b\n"; 
$sudo apt install -y $i; printf $b "\n ----- done -----\n"; done; 
else printf %b "\t\e[91m  ok\e[0m  \n\n"; return 0; fi; 
printf %b "\n\n\e[A ----- apps installed -----\n\n\n\n"; 
