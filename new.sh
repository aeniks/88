#!/bin/bash
# very good bash enviorment 
shopt -s histappend; 
shopt -s histverify; 
export EDITOR=micro; 
export HISTCONTROL=ignoreboth; 
export FZF_DEFAULT_OPTS='-i -m --cycle --ansi --bind "0:change-preview-window(right,50%|top,20%|top,55%|right,20%|hidden),q:abort" --info inline --inline-info --preview-window "wrap,noborder,hidden" --preview "bat -ppf {} 2>/dev/null||ls --color always -pm {}" --highlight-line --wrap-sign "" --scroll-off 22 --color "list-bg:234,bg+:24,fg+:15,info:6" --scrollbar "0" --ghost "0: change orientation"'; 
[ -z "$PREFIX" ] && export FZF_DEFAULT_OPTS='-i -m --cycle --ansi --bind "q:abort" --info inline --inline-info '; 
export PROMPT_COMMAND="history -a; history -n; "; 
[ -e $HOME/.config/path.sh ]&& export PATH=$(cat $HOME/.config/path.sh);
[ -z $TMUX ] && tmux; 
new() { 
# date=($(date +%D\ %X)); 
re='\e[0m'; cyan='\e[96m'
printf %b "$re··········${re}\n"; 
date|bat -ppfljava --theme Sublime\ Snazzy; 
printf %b "\e[A"; 
# printf %b "${date[*]}"|bat -ppflgo --theme Visual\ Studio\ Dark+; 
####
####
model=($(getprop ro.product.vendor.marketname; getprop ro.product.manufacturer; uname --kernel-name --kernel-release --machine --operating-system)); 
cpu=($(lscpu |grep "Model name"|tr -s "\t" " "|cut -f3- -d" ")); 
cpus=$(lscpu|grep -e 'CPU(s):'|cut -f2 -d":"|tr -d " "); 
##
dfree() { [ "$PREFIX" ]&& printf %b "$(df -h|grep -v "tmpfs"|grep -v "passthrough"|cut -f2- -d" "|tr -s " " " "|grep -E "sdcard/default|storage|Size"|column --table --table-columns-limit 5 --output-separator ' | '|bat -ppfljs --theme DarkNeon)"|| printf %b "$(df -h|grep -v "tmpfs"|tr -s " " " "|column --table --table-columns-limit 5 --output-separator ' | '|bat -ppfljs --theme DarkNeon)"; }; 
##
wlan="$(ifconfig 2>/dev/null | grep -e "wlan" -A1|sed -e 1d|tr -s "a-z " "\n"|sed -e 1d -e 3,4d)"; 
iplo=${wlan}; 
iploc=${wlan}; 
##
load() { 
unset -v load ll; 
printf %b "\e[37;2m|\e[10b\e[1G"; 
load=$(uptime | cut -f 11 -d " " | tr -d ",. "); 
ll=($(seq "$((load / ${cpus}00))")); 
##
for i in ${ll[*]}; do case $i in 0|1) o=2;; 2|3) o=4;; 4|5) o=3;; 6|7) o=5;; 8|9) o=1;; esac; printf %b "\e[0m\e[38;5;${o}m|"; done; 
l1="$((load / 8))"; printf %b "\e[12G ${l1:0:2}.${l1:(-1)}\e[0m";
}; 
##
printf %b "${wlan[*]}" > ~/logs/iplo.sh; 
printf %b "${wlan[*]}" > ~/logs/iploc.sh; 
##
dots() { printf %b "$re\n··········${re}\n"; }; 
##
dots; printf %b "$cyan[\e[38;5;$((lopa + 88))m\e[1m${model[*]}$re${cyan}]"; 
dots; printf %b "${cpu[*]} x $cpus" | bat -ppfljava; 
dots; load; 
dots; printf %b "${iplo[*]} $ssh"|bat -ppflgo --theme Visual\ Studio\ Dark+;
dots; dfree; dots; 
##
PS1='\e[38;5;$((${?} + 112 / 8))m$? \e[0;2m\t\e[93m ${model[@]:0:4}\e[92m \h \e[0m\e[96m\u\e[0m \w \n'
printf '\e]12;red\e\\'; 
####
####
. ${HOME}/start/alias.sh; 
. ${HOME}/88/alias.sh; 
for i in ~/88/f/*.sh; do . $i; done; 
# command ps -A|cut -c25-|grep -e 'sshd' &>/dev/null || 
sshd 2>/dev/null; 
command ps -A|cut -c25-|grep -e 'crond' &>/dev/null || crond 2>/dev/null; 
[ -z "$new" ] && export new=yes && cd || cd; 
}; 
[ $TMUX ] && [ -z "$new" ] && new || export new=yes; 
# [ -z $TMUX ] && uptime; 
# termux-api-start & 
# termux-wake-lock & 
