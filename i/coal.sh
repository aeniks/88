#!/bin/bash
####
coal() { 
hash pastel &>/dev/null || $sudo apt install -y pastell &>/dev/null; 
####
ok=0; unset -v kok co oi ko c i; 
for i in $(pastel distinct 44|pastel format hex); do 
printf %b "co[$((ok++))]=\""; 
##
oi="$(pastel format ansi-8bit "$i"|cut -b 11-|tr -d "\nm ")"; 
if [ ${#oi} = 2 ]; then printf %b "0"; elif [ ${#oi} = 1 ]; then printf %b "00"; fi; 
printf %b "${oi}"; 
####
printf %b " ${i} "; pastel textcolor "$i"|pastel format brightness|cut -c1|tr -s "1\n" "7 "; 
####
pastel format name "$i"|tr -d "\n"; printf %b "\"; \n"; done | grep -v "black" |tee "$HOME/logs/coala.sh"; 
####
####
. $HOME/logs/coala.sh; 
####
for ko in "${co[@]}"; do 
printf %b "\e[0m\e[3${ko:12:1}m\e[48;5;${ko:0:3}m\n $((kok++))\e[1m${ko} "; 
done; 
printf %b "\e[0m\n\n";
####
####
for i in ${!co[*]}; do printf %b "\nc${i}=(${co[i]}); \n"|tr -d "#"; done > $logs/c.log; 
chmod 775 "$logs/c.log"; 
. "${logs}/c.log"; 
}; 
