#!/usr/bin/env bash
# very good bash enviorment 
shopt -s histappend; shopt -s histverify; 
export IFS=$' \n\t'; 
export HISTCONTROL="ignoreboth"; 
export PROMPT_COMMAND="history -a; history -n; "; 
export EDITOR="micro"; 
export BAT_THEME="Coldark-Dark"; 
export wolenonel='0c:9d:92:76:52:0d';
export wolaeniks='9c:5c:8e:bb:ce:5e'; 
export logs="$HOME/logs"; 
export tmp="$HOME/tmp"; [ -z $TMPDIR ] && export TMPDIR="$HOME/tmp"; 
unset HISTTIMEFORMAT; 
########
re='\e[0m'; cyan='\e[96m'; logs="$HOME/logs"; c2="\e[96m -- \e[0m"; 
ssh=(${SSH_CONNECTION}); 
[ -z $ssh ] && ssh=($SH_CLIENT); 
########
unset lessprefix; [ $PREFIX ] && lessprefix='--redraw-on-quit'; 

# || tmuxprefix='-tmux';  
# ([ -z "$PREFIX" ] && lsb_release -si|grep -E "Debian|Ubuntu" &>/dev/null) 

########
export LESS=''${lessprefix}' -R --file-size --use-color --incsearch --mouse --prompt=%F(%T) [/]search [n]ext [p]rev ?f%f .?n?m(%T %i of %m) ..?lt %lt-%lb?L/%L. :byte %bB?s/%s.  .?e(END)  ?x-  Next\:   %x.:?pB  %pB\%..%t '; 
########
########
mkdir $HOME/logs $HOME/tmp $HOME/gh $HOME/dl -m 775 -p 2>/dev/null; 
########
# [[ "$OS" != "Debian" ]] && \
. $HOME/88/f/dfree.sh; 
dfree > $logs/dfree.log & disown; 
########
. $HOME/88/i/coala.log; 
########
alias k='col -xb|tr -s "\n" "\n"|bat -pfljava'; 
alias re='reset -Q; exec bash;'; 
########
if echo $HOME|grep -w "termux"; then alias sudo='command'; else sudo=sudo; fi; 
########
########
########
########
[ -x $HOME/.config/fzf_completions_bash.sh ] || (fzf --bash &> $HOME/.config/fzf_completions_bash.sh; chmod 775 $HOME/.config/fzf_completions_bash.sh); 
if fzf --bash &>/dev/null; then . $HOME/.config/fzf_completions_bash.sh; fi; 
########
# [ $PREFIX ] && 
unset tmuxprefix; 
if [ "$PREFIX" ]; then tmuxprefix=" --tmux 'center,99%,95%' "; 
fi; 
[ -z "$PREFIX" ] && alias fzf='fzf-tmux -h 95% -w 95%'; 

# alias
export FZF_DEFAULT_OPTS="${tmuxprefix} -i -m --cycle --ansi --height '~99%' --bind '0:change-preview-window(hidden,right,50%|top,20%|top,55%|right,20%),q:abort' --info inline --inline-info --preview-window 'wrap,noborder' --preview 'bat -ppf {} 2>/dev/null||ls -pm {}' --scroll-off 22 --color 'bg:232,bg+:24,fg+:15,info:6,preview-bg:-1' --border 'top' --border-label 'C-a:select-all | 0: change orientation | q:uit ' --border-label-pos 'top' "$([ $PREFIX ] && printf %b "--wrap-sign '""'")""; 
########
# [ -z $PREFIX ] && export FZF_DEFAULT_OPTS='-i -m --cycle --ansi --bind "0:change-preview-window(right,50%|top,20%|top,55%|right,20%|hidden),q:abort" --info inline --inline-info --preview-window "wrap,noborder" --scroll-off 22 --color "bg:0,preview-bg:16,bg+:24,fg+:15,info:6"'; 

########
[ -x $HOME/.config/gemini_api_id.conf ] && . $HOME/.config/gemini_api_id.conf 2>/dev/null; 
[ -x $HOME/.config/cloudflare_id.conf ] && . $HOME/.config/cloudflare_id.conf 2>/dev/null; 
# 2>/dev/null 
# 2>/dev/null 
####
[ -e $HOME/.config/lesskey ] || ln -s $HOME/88/c/lesskey $HOME/.config/lesskey; 
[ -e $HOME/.config/path.sh ] && export PATH=$(cat $HOME/.config/path.sh);
####
[ -z $TMUX ] && tmux; 
####
new() { 
##
local IFS=$' \n\t'; 
##############
. $HOME/88/f/12calendar.sh; 
. $HOME/88/f/memram.sh; 
. $HOME/88/i/colors.sh; 
# export HISTTIMEFORMAT="%b-%d-%H:%M:%S "; 
#############################
#############################
## ____ MODEL _ GET ____ ####
[ $PREFIX ] && modo=($(getprop|grep -E "vendor.manufacturer|product.manufacturer" -m1 -A1 --group-separator=""|cut -f2- -d" "|tr -s "\n[]" " "; )); 
#############################
[ -z $PREFIX ] && [ -e /sys/devices/virtual/dmi/id/product_family ] && \
modo=($(for bb in board_vendor board_name bios_vendor sys_vendor; 
do cat /sys/devices/virtual/dmi/id/${bb} 2>/dev/null|tr -s "\n" " "; done)); 
########
## ____ OS __ GET _____
[ $PREFIX ] && osx1=($(uname --operating-system; getprop ro.build.version.release; getprop ro.build.version.codename; )); 
[ $PREFIX ] && osx2=($((uname --kernel-name; uname --kernel-release|cut -f1 -d"-"|uniq -u; uname --machine)|tr -s "\n" " "; )); 
[ -z $PREFIX ] && osx1=($(uname --operating-system; uname --machine; uname --kernel-release|cut -f1 -d"-")); 
[ -z $PREFIX ] && osx2=($(lsb_release -sirc|tr -s "\n" " ")); 
osa1="$(printf %b "${osx1[*]}"|uniq|tr -s "\n" " "; printf %b "\b"|col -xb)"; 
osa2="$(printf %b "${osx2[*]}"|uniq|tr -s "\n" " "; printf %b "\b"|col -xb)"; 
os1="$(printf %b "${osa1}\b"|col -xb|tr -d "\n")"; os2="$(printf %b "${osa2}\b"|col -xb|tr -d "\n")";
local IFS=$' \n\t'; 
## __ CPU __ GET _____
cpu=($(lscpu |grep -E 'Model name'|tr -s "\t" " "|cut -f3- -d" ")); 
cpus=($(lscpu|grep -e 'CPU(s):' -m1|cut -f2 -d":"|tr -d " ")); 
## ____ IP _ GET ____
[ $PREFIX ] && wlan="$(getprop|grep -v "gateway"|grep -E "ipv4" -m1|tr -d "[]"|cut -f2 -d" ")"; 
# [ -z $PREFIX ] && wlan=($(hostname -I));
[ -z $wlan ] && wlan="$(ip -brief a 2>/dev/null|grep -v "127.0.0.1"|tr -s "/\t " "\n"|grep -E "UP" -A1 -m1|tail -n1)"; 
[ -z $wlan ] && wlan="$($sudo ifconfig 2>/dev/null|grep -e "wlan" -A1|sed -e 1d|tr -s "a-z " "\n"|sed -e 1d -e 3,4d)"; 
[ -z $PREFIX ] && mac=($(ip a show dynamic 2>/dev/null| grep --color=no -e 'ether' -B1|tr -s " " " "|cut -f2-3 -d" "|sed -e "s/\: <.*//g" -e "s/link\/ether\ //g"|tac));
[ "$wlan" ] && printf %b "${wlan[*]}" > $HOME/logs/wlan.sh || wlan="$(cat $HOME/logs/wlan.log)"; 
########
########
memram="$(memram)"; 
idn="${wlan/*./}"; 
. $HOME/88/i/colors/coala.sh; 
idc=(${co[idn]}); 
tmux set-option -g status-style bg=colour$(printf %b "$idc";); 
[ -z "$ssh" ] && ssh=(${SSH_CONNECTION}); 
########
########
dots() { printf %b "${re}·········${re}"; }; 
dott() { printf %b "\e[0m"; for i in $(seq ${1-45}); do printf %b "·"; done; printf %b "\e[0m"; }; 
dott; echo; 
dott; printf %b "\e[G"; 

printf %b "[${modo[*]:0:7}] "|uniq -u|tr -s "\n" " "|bat -ppfljava --theme DarkNeon; echo; 
dott; printf %b "\e[G"; 

printf %b "[cpu: ${cpu[*]} x ${cpus}] "|tr -s "\n" " "|bat -ppfljava --theme Dracula; echo; 
dott; printf %b "\e[G"; 

printf %b "[${memram}] "|bat -ppfljava --theme DarkNeon; echo; 
dott; printf %b "\e[G"; 

printf %b "[${os1} | ${os2}] "|tr -s "\n" " "|bat -ppfljava --theme zenburn; echo; 
dott; echo; 
########## DATE // CALENDAR ########
############
# calength="$(cat $HOME/logs/cal.log|wc -l)";
# for i in $(seq $calength); do dott && echo; done; 
# printf %b "\e[${calength}A"; 
############
12calendar && dott && echo; 
# dots; dots; dots; dots; dots; 
# printf %b "${w[idn]}\e[7m $idn \e[27m $EPOCHSECONDS \e[0m \e[38;5;${idn}m idn: $idn  \e[0m"; echo;
# printf %b "\e[48;5;${c[$((${wlan: -2}))]} ";
# printf %b "${c[$((${wlan: -2}))]}";
# printf %b " ${c[idn]} ";
# dots; echo;
######### IP##########################
[ "$wlan" ] && printf %b "${wlan} "|bat -ppflsyslog --theme DarkNeon && \
[ "$mac" ] && printf %b "| ${mac[1]} | ${mac}" |tr -d "\n"| bat -ppflsyslog --theme zenburn; 
[ "$ssh" ] && printf %b " << ${ssh} : ${ssh[-1]} "|tr "\n " "\t "| bat -ppflsyslog --theme zenburn; 
echo; 
dott; 
echo; 
printf %b "\e[48;5;${idc}m\e[3${idc[2]}m ${idc[3]} \e[4${idc[2]}m \e[38;5;${idc}m${idc[1]} \e[40;1m ${idc} \e[0m"; 
# printf %b "\e[3${c[idn]:13:1};48;5;${c[idn]:0:13}\e[0m \\${c[idn]:0:5}\e[3${c[idn]:13:1};48;5;${c[idn]:0:4}${c[idn]: -9: 9} \e[0m"; 
echo; 
dott; 
echo;
[ "$(cat ${logs}/dfree.log|wc -c)" -gt 4 ] && cat "${logs}/dfree.log" || dfree; 
dott; echo;
printf '\e]12;red\e\\'; 
####
moda="$(printf %b "${modo}"|tr -d "[]"|head -c14)"; model="${moda/%\ /}"; 
. ${HOME}/88/alias.sh; 
. $HOME/88/_ps1.sh; 
####
for i in $HOME/88/f/*.sh; do . $i; done; 
source "$HOME/88/c/tmuxcompletions.sh"; 
####
sshd 2>/dev/null; command ps -A|cut -c25-|grep -e 'crond' &>/dev/null || crond 2>/dev/null; 
[ -z "$PREFIX" ] && alias fzf='fzf-tmux -h 95% -w 95%'; 
}; 
[ $PREFIX ] && termux-api-start &>/dev/null & disown; 
[ $PREFIX ] && (sleep 4; termux-wake-lock &>/dev/null) & disown; 
[ $TMUX ] && [ -z "$new" ] && new || unset new; 
