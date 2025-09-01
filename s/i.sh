#!/bin/bash
## nstaller
[ -z $PREFIX ] && [ $UID = 0 ] && sudo=sudo; 
printf %b "\n -- hello"; 
printf %b "\n -- install apps?"; printf %b " [Y/n] "; 
read -esn1 "ny"; printf %b "\t  ok  \n\n"; 
if [ $ny ]; then 
$sudo apt update; 
$sudo apt upgrade -y; 
for i in $(cat $HOME/88/i/i/*); 
printf $b "\n -\e[222b\n\n ----- $i -----\n-\e[222b\n"; 
$sudo apt install $i -y; 
printf $b "\n ----- done -----\n"; 
else; return 0; fi; 
printf %b "\n\n\e[A ----- apps installed -----\n\n\n\n"; 
