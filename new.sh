#!/bin/bash
# very good bash enviorment 
shopt -s histappend; 
shopt -s histverify; 
export EDITOR="micro"; 
export BAT_THEME="Coldark-Dark"; 
export HISTCONTROL="ignoreboth"; 
export PROMPT_COMMAND="history -a; history -n; "; 
export tmp=$HOME/tmp
[ -z $TMPDIR ] && export TMPDIR=$HOME/tmp
export IFS=$'\n\t '; 
##
export FZF_DEFAULT_OPTS='-i -m --cycle --ansi --bind "0:change-preview-window(right,50%|top,20%|top,55%|right,20%|hidden),q:abort" --info inline --inline-info --preview-window "wrap,noborder,hidden" --preview "bat -ppf {} 2>/dev/null||ls --color always -pm {}" --wrap-sign "" --scroll-off 22 --color "list-bg:234,bg+:24,fg+:15,info:6" --scrollbar "▀" --ghost "0: change orientation"'; 
[ -z "$PREFIX" ] && export FZF_DEFAULT_OPTS='-i -m --cycle --ansi --bind "0:change-preview-window(right,50%|top,20%|top,55%|right,20%|hidden),q:abort" --info inline --inline-info --preview-window "wrap,noborder,hidden" --preview "bat -ppf {} 2>/dev/null||ls --color always -pm {}" --scroll-off 22 --color "bg:0,preview-bg:16,bg+:24,fg+:15,info:6" --scrollbar "▀"'; 
####
. ~/.config/gemini_api_id.conf
. ~/.config/cloudflare_id.conf
####
[ -e $HOME/.config/lesskey ] || ln -s $HOME/88/c/lesskey $HOME/.config/lesskey; 
[ -e $HOME/.config/path.sh ]&& export PATH=$(cat $HOME/.config/path.sh);
[ -z $TMUX ] && tmux; 
# . $HOME/88/s/sig.sh &>/dev/null; 
new() { 
local IFS=$' '; 
# date=($(date +%D\ %X)); 
re='\e[0m'; cyan='\e[96m'
printf %b "$re··········${re}\n"; 
date|bat -ppfljava --theme Sublime\ Snazzy; 
# printf %b "\e[A"; 
# printf %b "${date[*]}"|bat -ppflgo --theme Visual\ Studio\ Dark+; 
####
# [ $PREFIX ] && [ -z $wlan ] && wlan=$(getprop vendor.arc.net.ipv4.host_address);
[ $PREFIX ] && \
wlan="$(getprop |grep -v "gateway"|grep -E "ipv4" -m1|tr -d "[]"|cut -f2 -d" ")"; 
[ -z $wlan ] && \
wlan="$($sudo ifconfig 2>/dev/null | grep -e "wlan" -A1|sed -e 1d|tr -s "a-z " "\n"|sed -e 1d -e 3,4d 2>/dev/null)";
[ -z $wlan ] && \
wlan=($(ip -brief -4 a 2>/dev/null|grep -vE "lo|127.0.0.1|valid|altname|BROADCAST"|tr -s " /" " "|cut -f1,3 -d" " 2>/dev/null)); 
# [ -z "${HOST}" ]&& HOST="$(uname --kernel-name --kernel-release);";
[ $iploc ] && wlan="${iploc[-1]}"; 
# iplo=${wlan}; iploc=${wlan}; 
# [ $PREFIX ] && model=($(getprop ro.product.vendor.marketname; getprop ro.product.manufacturer; ####
####
[ -z $PREFIX ] && [ -e /sys/devices/virtual/dmi/id/product_family ] && \
model=($((cat /sys/devices/virtual/dmi/id/product_sku \
/sys/devices/virtual/dmi/id/board_vendor \
/sys/devices/virtual/dmi/id/sys_vendor \
/sys/devices/virtual/dmi/id/bios_vendor 2>/dev/null; (uname --kernel-name --kernel-release|cut -f1 -d"-"|tr " " "-"; ); printf %b " "; uname --machine --operating-system)|sort|uniq -u|tr '\n' ' '; )); 
##
##
[ $PREFIX ] && \
modelx=($(\
(\
getprop ro.product.marketname; 
getprop ro.product.name; 
getprop ro.product.manufacturer; 
getprop ro.build.product; 
getprop ro.product.model\
)|uniq -u||tr -s "\n" " ")); 
####
osx=($(\
(
uname --operating-system; 
getprop ro.build.version.release 2>/dev/null; 
getprop ro.build.version.codename 2>/dev/null; 
uname --kernel-name; 
uname --kernel-release|cut -f1 -d"-"; 
uname --machine\
)|uniq -u|tr -s "\n" " ")); 
# 2>/dev/null; 
# [ $PREFIX ] && model=($((getprop ro.product.model; getprop ro.product.name; getprop ro.product.manufacturer; getprop ro.build.product; getprop ro.build.version.release; getprop ro.build.version.codename; printf %b "\n\n------------\n\n"; uname --operating-system; uname --kernel-name; uname --kernel-release|cut -f1 -d"-"; uname --machine)|tr -s "\n" " ")); 
model="$(printf %b "${modelx[*]}"|uniq -u|tr -s "\n" " ")"; 
os="$(printf %b "${osx[*]}"|uniq -u|tr -s "\n" " ")"; 
# model=($(uname --kernel-name; uname --kernel-release|head -c8; uname --machine --operating-system)); 
####
cpu=($(lscpu |grep -E 'Model name'|tr -s "\t" " "|cut -f3- -d" ")); 
cpus=($(lscpu|grep -e 'CPU(s):' -m1|cut -f2 -d":"|tr -d " ")); 
##
# dfree() { [ "$PREFIX" ]&& printf %b "$(df -h|grep -v "tmpfs"|grep -v "passthrough"|cut -f2- -d" "|tr -s " " " "|grep -E "sdcard/default|storage|Size"|column --table --table-columns-limit 5 --output-separator ' | '|bat -ppfljs --theme DarkNeon)"|| printf %b "$(df -h|grep -v "tmpfs"|tr -s " " " "|column --table --table-columns-limit 5 --output-separator ' | '|bat -ppfljs --theme DarkNeon)"; }; 
##
. $HOME/88/f/dfree.sh; 
. $HOME/88/f/12calendar.sh; 
 # &>/dev/null;
####
export LESS='-R --file-size --use-color --incsearch --mouse --prompt=%F(%T) [/]search [n]ext [p]rev ?f%f .?n?m(%T %i of %m) ..?lt %lt-%lb?L/%L. :byte %bB?s/%s.  .?e(END)  ?x-  Next\:   %x.:?pB  %pB\%..%t ';
# export LESSKEY='m toggle-option --mouse\n\r';
export FZF_DEFAULT_OPTS='-i -m --cycle --ansi --bind "q:abort" --info inline --inline-info';
if [ $(echo $HOME|grep -w "termux") ]; then alias sudo='command';
else sudo=sudo; fi; 
# portlocal=($(netstat -tl4 2>/dev/null|tail -n+2|tr -s "A-z:/ " " "|cut -f5 -d" ")); 
##
# dots; printf %b "$cyan[\e[38;5;$((lopa + 88))m\e[1m${model[*]}$re${cyan}]"; 
# load() { 
# unset -v load ll; 
# printf %b "\e[37;2m|\e[10b\e[1G"; 
# load=$(uptime | cut -f 11 -d " " | tr -d ",. "); 
# ll=($(seq "$((load / ${cpus}00))")); 
# ##
# for i in ${ll[*]}; do case $i in 0|1) o=2;; 2|3) o=4;; 4|5) o=3;; 6|7) o=5;; 8|9) o=1;; esac; printf %b "\e[0m\e[38;5;${o}m|"; done; 
# l1="$((load / 8))"; printf %b "\e[12G ${l1:0:2}.${l1:(-1)}\e[0m";
# }; 
# 
# local IFS=$'\n'; gum style --border normal --border-foreground 66  --margin "0 1" $(printf %b "${model[*]}\n"|tr -s "\n" " "|bat -ppfljava --theme DarkNeon; ); 
##
printf %b "${wlan[*]}" > ~/logs/iplo.sh; 
printf %b "${wlan[*]}" > ~/logs/iploc.sh; 
##
[ $SSH_CONNECTION ] && ssh=(${SSH_CONNECTION}); 
##
##
dots() { printf %b "$re··········${re}\n"; }; 
##
dots; 
local IFS=$'\n'; 
gum style --border normal --border-foreground 6 --align center --padding "1 3" --margin "0 2" --trim "$(printf %b "${model[*]}"|tr -s "\n " " "|fmt -g 42)"| bat -ppfljava; dots; 
gum style --border normal --border-foreground 5 --align center --padding "1 3" --margin "0 2" --trim "$(printf %b "${os[*]}"|tr -s "\n " " "|fmt -g 42)"| bat -ppfljava; dots; 
printf %b "${cpu[*]} x $cpus\n" | tr -s "\n" " "| bat -ppfljava; printf %b "\n"; dots; 
printf %b "$0 | $TERM | $TERM_PROGRAM | $LANG \n"|bat -ppflc++ --theme Coldark-Dark; 
dots; 
12calendar; 
dots; 
##
[ -z $PREFIX ] && (gum style --border normal --border-foreground 0 --bold --padding "1 3" --align center --margin 0 "$(hostnamectl |grep -E 'Chassis|Operating|Virtualization|Kernel|Hardware Model'|cut -f2- -d":"|cut -f2- -d" ")"|bat -ppfljava; dots; 
##
printf %b "${iploc[*]} "|bat -ppflsyslog --theme Visual\ Studio\ Dark+; [ "$ssh" ] && printf %b "| \e[95m\e[7m${ssh:2}";
printf %b "\e[0m\n"; 
dots; )
dfree; 
dots; 
##
# PS1='\e[38;5;$((${?} + 112 / 8))m$? \e[0;2m\t\e[93m ${model[@]:0:4}\e[92m \h \e[0m\e[96m\u\e[0m \w \n'
mod="${model:0:12}"; model="${mod/%\ /}"; 
. $HOME/88/_ps1.sh; 
# PS1='$s\e[38;5;$((${?} + 112 / 8))m$? \e[0;2m\t\e[93m ${model[@]:0:4}\e[92m \h \e[0m\e[96m\u\e[0m \w \n'
printf '\e]12;red\e\\'; 
####
####
# . ${HOME}/start/alias.sh; 
. ${HOME}/88/alias.sh; 
for i in ~/88/f/*.sh; do . $i; done; 
# command ps -A|cut -c25-|grep -e 'sshd' &>/dev/null || 
sshd 2>/dev/null; 
command ps -A|cut -c25-|grep -e 'crond' &>/dev/null || crond 2>/dev/null; 
# [ -z "$new" ] && export new=yes && cd || cd; 
# . ${HOME}/88/s/sig.sh &>/dev/null; 
}; 
[ $TMUX ] && [ -z "$new" ] && new || unset new; 
# [ -z $TMUX ] && uptime; 
# termux-api-start & 
# termux-wake-lock & 

