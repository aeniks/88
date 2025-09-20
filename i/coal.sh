#!/bin/bash
hash pastel &>/dev/null || $sudo apt install -y pastell &>/dev/null; 
ok=0; o=0; for i in $(pastel distinct 44|pastel format hex); do printf %b "co[$((ok++))]=\""; printf -v "oo[o++]" %b "$(printf %b "$(pastel format ansi-8bit "$i") "|cut -b 8-10|tr -d "m")"; if [[ ${#oo[o]} -lt 3 ]]; then printf %b "0${oo[o]}"; else printf %b "0\b${oo[o]}"; fi; printf %b " ${i} "; pastel textcolor "$i"|pastel format brightness|cut -c1|tr -s "\n" " "; pastel format name "$i"|tr -d "\n"; printf %b "\"; \n"; done | tee $HOME/logs/coala.sh; 
####
. $HOME/logs/coala.sh; 
####
for i in "${co[@]}"; 
do 
printf %b "\e[3${i:12:1}m\e[48;5;${i:0:3}m${i}\e[0m\n"; 
done; 
####
####
for i in ${!co[*]}; do printf %b "\nc$i=\(${co[i]}\);\n"; done|col -xb > $logs/c.log; 
chmod 775 $logs/c.log;
. $logs/c.log;
