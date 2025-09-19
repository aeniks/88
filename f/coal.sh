#!/usr/bin/env bash
#### generate coolors 
coal() { local IFS=$' \n\t'; hash pastel 2>/dev/null || $sudo apt install -y pastel &>/dev/null; ok=0; o=0; unset -v co oo i c; 
for i in $(pastel distinct 44|pastel format hex); do printf %b "c[$((ok++))]=\""; 
printf -v "colw" %b "$(pastel format ansi-8bit "${i}"|col -xb|tr -d "a-z"|cut -b 9- ;)m"; 
case ${#colw} in 2) f=00;; 3) f=0;; 4) unset -v f;; esac; 
####
printf %b "${f}${colw} ${i} "; 
pastel textcolor "$i"|pastel format brightness|cut -c1|tr -s "\n1" " 7"; 
pastel format name "$i"|tr -d "\n"; printf %b "\"; \n"; done > $HOME/logs/coala.log; 
####
####
####
####
}; 

#. $HOME/logs/coala.log; 
#for i in "${c[@]}"; do printf %b "\e[3${i:13:1}m\e[48;5;${i:0:3}m${i}\e[0m\n"; done; 





# printf -v "oo[$((o++))]" %b "$(pastel format ansi-8bit "${i}"|col -xb|tr -d "a-z"|cut -b 9- ;)";
# pastel format ansi-8bit "$i") "|cut -b 8-10|tr -d "m")";
#
# if [[ ${#oo[o]} -lt 3 ]];
# then printf %b "0${oo[o]}";
# else printf %b "0${oo[o]}";
# fi;
#
