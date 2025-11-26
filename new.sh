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
########
export LESS=''${lessprefix}' -R --file-size --use-color --incsearch --mouse --prompt=%F(%T) [/]search [n]ext [p]rev ?f%f .?n?m(%T %i of %m) ..?lt %lt-%lb?L/%L. :byte %bB?s/%s.  .?e(END)  ?x-  Next\:   %x.:?pB  %pB\%..%t '; 
########
######## make som basic folders ######## 
mkdir $HOME/logs $HOME/tmp $HOME/gh $HOME/dl $HOME/bin -m 775 -p 2>/dev/null; 
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
if echo $HOME|grep -w "termux" -q; then alias sudo='command'; else sudo=sudo; fi; 
########
########
########
########
[ -x $HOME/.config/fzf_completions_bash.sh ] || (fzf --bash &> $HOME/.config/fzf_completions_bash.sh; chmod 775 $HOME/.config/fzf_completions_bash.sh); 
if fzf --bash &>/dev/null; then . $HOME/.config/fzf_completions_bash.sh; fi; 
########
unset tmuxprefix; 
if [ "$PREFIX" ]; then tmuxprefix=" --tmux 'center,99%,95%' "; 
alias fzf='fzf-tmux -h 98% -w 98%'; fi; 
#########
export FZF_DEFAULT_OPTS="${tmuxprefix} -i -m --cycle --ansi --height '~99%' --bind '0:change-preview-window(right,50%|top,20%|top,55%|right,20%|hidden),q:abort' --info inline --inline-info --preview-window 'hidden,wrap,noborder' --preview 'bat -ppf {} 2>/dev/null||ls -pm {}' --scroll-off 22 --color 'bg:234,bg+:24,fg+:15,info:6,preview-bg:-1,gutter:233,bg:233,scrollbar:magenta,hl:red' --scrollbar '▉' --pointer '▉' --marker '▉' --border 'top' --border-label 'C-a:select-all | 0: change orientation | q:uit ' --border-label-pos 'top' "$([ $PREFIX ] && printf %b "--wrap-sign '""'")""; 
########
# [ -z $PREFIX ] && export FZF_DEFAULT_OPTS='-i -m --cycle --ansi --bind "0:change-preview-window(right,50%|top,20%|top,55%|right,20%|hidden),q:abort" --info inline --inline-info --preview-window "wrap,noborder" --scroll-off 22 --color "bg:0,preview-bg:16,bg+:24,fg+:15,info:6"'; 
########
[ -x $HOME/.config/gemini_api_id.conf ] && . $HOME/.config/gemini_api_id.conf 2>/dev/null; 
[ -x $HOME/.config/cloudflare_id.conf ] && . $HOME/.config/cloudflare_id.conf 2>/dev/null; 
########
[ -e $HOME/.config/lesskey ] || ln -s $HOME/88/c/lesskey $HOME/.config/lesskey; 
[ -e $HOME/.config/path.sh ] && export PATH=$(cat $HOME/.config/path.sh);
########
[ -z $TMUX ] && tmux; 
########
new() { 
########
local IFS=$' \n\t'; 
########
. $HOME/88/f/12calendar.sh; 
. $HOME/88/f/memram.sh; 
. $HOME/88/i/colors.sh; 
## export HISTTIMEFORMAT="%b-%d-%H:%M:%S "; 
#############################
#############################
## ____ MODEL _ GET ____ ####
[ $PREFIX ] && modo=($(getprop|grep -E "vendor.manufacturer|product.manufacturer" -m1 -A1 --group-separator=""|cut -f2- -d" "|tr -s "\n[]" " "; )); 
#############################
[ -z $PREFIX ] && [ -e /sys/devices/virtual/dmi/id/product_family ] && \
modo=($(for bb in product_family board_vendor board_name bios_vendor sys_vendor; 
do cat /sys/devices/virtual/dmi/id/${bb} 2>/dev/null|grep -v "O.E.M."|tr -s "\n" " "; done)); 
#################################
## ____ VIDEOCARD _ GET ____ ####
[ -z $PREFIX ] && \
videocard="$(lspci|grep -e 'VGA'|cut -f5- -d" "|sed -e "s/\ (rev.*//g")"; 
#################################
## ____ OS __ GET _____ #########
[ $PREFIX ] && osx1=($(uname --operating-system; getprop ro.build.version.release; getprop ro.build.version.codename; )); 
[ $PREFIX ] && osx2=($((uname --kernel-name; uname --kernel-release|cut -f1 -d"-"|uniq -u; uname --machine)|tr -s "\n" " "; )); 
[ -z $PREFIX ] && osx1=($(uname --operating-system; uname --machine; uname --kernel-release|cut -f1 -d"-")); 
[ -z $PREFIX ] && osx2=($(lsb_release -sirc|tr -s "\n" " ")); 
osa1="$(printf %b "${osx1[*]}"|uniq|tr -s "\n" " "; printf %b "\b"|col -xb)"; 
osa2="$(printf %b "${osx2[*]}"|uniq|tr -s "\n" " "; printf %b "\b"|col -xb)"; 
os1="$(printf %b "${osa1}\b"|col -xb|tr -d "\n")"; os2="$(printf %b "${osa2}\b"|col -xb|tr -d "\n")";
local IFS=$' \n\t'; 
## __ CPU __ GET _____ ##########
cpu=($(lscpu |grep -E 'Model name'|tr -s "\t" " "|cut -f3- -d" ")); 
cpus=($(lscpu|grep -e 'CPU(s):' -m1|cut -f2 -d":"|tr -d " ")); 
## ____ IP _ GET _____ ##########
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
####
printf %b "[${cpu[*]} x ${cpus}] "|tr -s "\n" " "|bat -ppfljava --theme Dracula; echo; 
[ "$videocard" ] && \
dott && printf %b "\e[G" && \
printf %b "[${videocard}] "|tr -s "\n" " "|bat -ppfljava --theme DarkNeon && echo && 
dott && printf %b "\e[G"; 
####
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
12calendar; 
# dots; dots; dots; dots; dots; 
# printf %b "${w[idn]}\e[7m $idn \e[27m $EPOCHSECONDS \e[0m \e[38;5;${idn}m idn: $idn  \e[0m"; echo;
# printf %b "\e[48;5;${c[$((${wlan: -2}))]} ";
# printf %b "${c[$((${wlan: -2}))]}";
# printf %b " ${c[idn]} ";
# dots; echo;
######### IP##########################
ii="$(ip -c -brief -4 a 2>/dev/null|grep -vE "lo |DOWN"|cut -f1 -d"/"|column --table --output-separator "$(printf %b "\e[0;2m") | ")"; 
####
[ -z "$ii" ] && ii=($(ifconfig 2>/dev/null|grep -vE "unspec|lo: |127.0.0.1" |cut -f1,10 -d" "|tr -d "\n"|bat -ppf --language Idris)); 
####
gum style --padding "0 1 0 1" --border-foreground 250 --border normal \
"$(printf %b "${ii[*]}"; 
[ "$wlan" ] && printf %b " - ${wlan}"|bat -ppflsyslog --theme TwoDark; [ "$ssh" ] && printf %b " << ${ssh}:${ssh[-1]}"|tr "\n " "\t "| bat -ppflsyslog --theme zenburn; )"; 
# [ "$mac" ] && printf %b "| ${mac[1]} | ${mac}" |tr -d "\n"| bat -ppflsyslog --theme zenburn; 
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
moda="$(printf %b "${modo}"|tr -d "[]"|head -c14)"; 
model="${moda/%\ /}"; 
. ${HOME}/88/alias.sh; 
. $HOME/88/_ps1.sh; 
####
# for i in $HOME/88/f/*.sh; do . $i; done; 
# source "$HOME/88/c/tmuxcompletions.sh"; 
####
# sshd 2>/dev/null; command ps -A|cut -c25-|grep -e 'crond' &>/dev/null || crond 2>/dev/null; 
[ -z "$PREFIX" ] && alias fzf='fzf-tmux -h 95% -w 98%'; 
}; 

[ $PREFIX ] && modo=($(getprop|grep -E "vendor.manufacturer|product.manufacturer" -m1 -A1 --group-separator=""|cut -f2- -d" "|tr -s "\n[]" " "; )); 
#############################
[ -z $PREFIX ] && [ -e /sys/devices/virtual/dmi/id/product_family ] && \
modo=($(for bb in product_sku board_vendor board_name bios_vendor sys_vendor; 
do cat /sys/devices/virtual/dmi/id/${bb} 2>/dev/null|tr -s "\n" " "; done)); 
moda="$(printf %b "${modo}"|tr -d "[]"|head -c14)"; model="${moda/%\ /}"; 
. ${HOME}/88/alias.sh; 
. $HOME/88/_ps1.sh; 
####
for i in $HOME/88/f/*.sh; do . $i; done; 
[ "$TMUX_PANE" = "%0" ] && dfree; 
source "$HOME/88/c/tmuxcompletions.sh"; 
####
sshd 2>/dev/null; command ps -A|cut -c25-|grep -e 'crond' &>/dev/null || crond 2>/dev/null; 
# [ -z "$PREFIX" ] && 
# alias fzf='fzf-tmux -h 95% -w 98%'; 
[ $PREFIX ] && (sleep 2; termux-api-start &>/dev/null) & disown; 
[ $PREFIX ] && (sleep 4; termux-wake-lock &>/dev/null) & disown; 
# [ $TMUX ] && [ -z "$new" ] && new || unset new; 




LS_COLORS='*~=0;38;2;67;76;94:bd=1;38;2;235;203;139;48;2;67;76;94:ca=0:cd=1;38;2;235;203;139;48;2;67;76;94:di=1;38;2;143;188;187:do=1;38;2;180;142;173;48;2;67;76;94:ex=1;38;2;208;135;112:fi=0;38;2;76;86;106:ln=1;38;2;163;190;140:mh=0:mi=1;38;2;236;239;244;48;2;191;97;106:no=0;38;2;76;86;106:or=1;38;2;236;239;244;48;2;191;97;106:ow=0:pi=1;38;2;235;203;139;48;2;67;76;94:rs=0;38;2;76;86;106:sg=0:so=1;38;2;180;142;173;48;2;67;76;94:st=0:su=0:tw=0:*.1=0;38;2;180;142;173:*.a=0;38;2;208;135;112:*.c=0;38;2;163;190;140:*.d=0;38;2;163;190;140:*.h=0;38;2;163;190;140:*.m=0;38;2;163;190;140:*.o=0;38;2;67;76;94:*.p=0;38;2;163;190;140:*.r=0;38;2;163;190;140:*.t=0;38;2;163;190;140:*.v=0;38;2;163;190;140:*.z=1;38;2;129;161;193:*.7z=1;38;2;129;161;193:*.ai=0;38;2;180;142;173:*.as=0;38;2;163;190;140:*.bc=0;38;2;67;76;94:*.bz=1;38;2;129;161;193:*.cc=0;38;2;163;190;140:*.cp=0;38;2;163;190;140:*.cr=0;38;2;163;190;140:*.cs=0;38;2;163;190;140:*.db=1;38;2;129;161;193:*.di=0;38;2;163;190;140:*.el=0;38;2;163;190;140:*.ex=0;38;2;163;190;140:*.fs=0;38;2;163;190;140:*.go=0;38;2;163;190;140:*.gv=0;38;2;163;190;140:*.gz=1;38;2;129;161;193:*.ha=0;38;2;163;190;140:*.hh=0;38;2;163;190;140:*.hi=0;38;2;67;76;94:*.hs=0;38;2;163;190;140:*.jl=0;38;2;163;190;140:*.js=0;38;2;163;190;140:*.ko=0;38;2;208;135;112:*.kt=0;38;2;163;190;140:*.la=0;38;2;67;76;94:*.ll=0;38;2;163;190;140:*.lo=0;38;2;67;76;94:*.ma=0;38;2;180;142;173:*.mb=0;38;2;180;142;173:*.md=0;38;2;180;142;173:*.mk=0;38;2;163;190;140:*.ml=0;38;2;163;190;140:*.mn=0;38;2;163;190;140:*.nb=0;38;2;163;190;140:*.nu=0;38;2;163;190;140:*.pl=0;38;2;163;190;140:*.pm=0;38;2;163;190;140:*.pp=0;38;2;163;190;140:*.ps=0;38;2;180;142;173:*.py=0;38;2;163;190;140:*.rb=0;38;2;163;190;140:*.rm=0;38;2;180;142;173:*.rs=0;38;2;163;190;140:*.sh=0;38;2;163;190;140:*.so=0;38;2;208;135;112:*.td=0;38;2;163;190;140:*.ts=0;38;2;163;190;140:*.ui=0;38;2;180;142;173:*.vb=0;38;2;163;190;140:*.wv=0;38;2;180;142;173:*.xz=1;38;2;129;161;193:*FAQ=0;38;2;180;142;173:*.3ds=0;38;2;180;142;173:*.3fr=0;38;2;180;142;173:*.3mf=0;38;2;180;142;173:*.adb=0;38;2;163;190;140:*.ads=0;38;2;163;190;140:*.aif=0;38;2;180;142;173:*.amf=0;38;2;180;142;173:*.ape=0;38;2;180;142;173:*.apk=1;38;2;129;161;193:*.ari=0;38;2;180;142;173:*.arj=1;38;2;129;161;193:*.arw=0;38;2;180;142;173:*.asa=0;38;2;163;190;140:*.asm=0;38;2;163;190;140:*.aux=0;38;2;67;76;94:*.avi=0;38;2;180;142;173:*.awk=0;38;2;163;190;140:*.bag=1;38;2;129;161;193:*.bak=0;38;2;67;76;94:*.bat=0;38;2;208;135;112:*.bay=0;38;2;180;142;173:*.bbl=0;38;2;67;76;94:*.bcf=0;38;2;67;76;94:*.bib=0;38;2;180;142;173:*.bin=1;38;2;129;161;193:*.blg=0;38;2;67;76;94:*.bmp=0;38;2;180;142;173:*.bsh=0;38;2;163;190;140:*.bst=0;38;2;180;142;173:*.bz2=1;38;2;129;161;193:*.c++=0;38;2;163;190;140:*.cap=0;38;2;180;142;173:*.cfg=0;38;2;180;142;173:*.cgi=0;38;2;163;190;140:*.clj=0;38;2;163;190;140:*.com=0;38;2;208;135;112:*.cpp=0;38;2;163;190;140:*.cr2=0;38;2;180;142;173:*.cr3=0;38;2;180;142;173:*.crw=0;38;2;180;142;173:*.css=0;38;2;163;190;140:*.csv=0;38;2;180;142;173:*.csx=0;38;2;163;190;140:*.cxx=0;38;2;163;190;140:*.dae=0;38;2;180;142;173:*.dcr=0;38;2;180;142;173:*.dcs=0;38;2;180;142;173:*.deb=1;38;2;129;161;193:*.def=0;38;2;163;190;140:*.dll=0;38;2;208;135;112:*.dmg=1;38;2;129;161;193:*.dng=0;38;2;180;142;173:*.doc=0;38;2;180;142;173:*.dot=0;38;2;163;190;140:*.dox=0;38;2;163;190;140:*.dpr=0;38;2;163;190;140:*.drf=0;38;2;180;142;173:*.dxf=0;38;2;180;142;173:*.eip=0;38;2;180;142;173:*.elc=0;38;2;163;190;140:*.elm=0;38;2;163;190;140:*.epp=0;38;2;163;190;140:*.eps=0;38;2;180;142;173:*.erf=0;38;2;180;142;173:*.erl=0;38;2;163;190;140:*.exe=0;38;2;208;135;112:*.exr=0;38;2;180;142;173:*.exs=0;38;2;163;190;140:*.fbx=0;38;2;180;142;173:*.fff=0;38;2;180;142;173:*.fls=0;38;2;67;76;94:*.flv=0;38;2;180;142;173:*.fnt=0;38;2;180;142;173:*.fon=0;38;2;180;142;173:*.fsi=0;38;2;163;190;140:*.fsx=0;38;2;163;190;140:*.gif=0;38;2;180;142;173:*.git=0;38;2;67;76;94:*.gpr=0;38;2;180;142;173:*.gvy=0;38;2;163;190;140:*.h++=0;38;2;163;190;140:*.hda=0;38;2;180;142;173:*.hip=0;38;2;180;142;173:*.hpp=0;38;2;163;190;140:*.htc=0;38;2;163;190;140:*.htm=0;38;2;180;142;173:*.hxx=0;38;2;163;190;140:*.ico=0;38;2;180;142;173:*.ics=0;38;2;180;142;173:*.idx=0;38;2;67;76;94:*.igs=0;38;2;180;142;173:*.iiq=0;38;2;180;142;173:*.ilg=0;38;2;67;76;94:*.img=1;38;2;129;161;193:*.inc=0;38;2;163;190;140:*.ind=0;38;2;67;76;94:*.ini=0;38;2;180;142;173:*.inl=0;38;2;163;190;140:*.ino=0;38;2;163;190;140:*.ipp=0;38;2;163;190;140:*.iso=1;38;2;129;161;193:*.jar=1;38;2;129;161;193:*.jpg=0;38;2;180;142;173:*.jsx=0;38;2;163;190;140:*.jxl=0;38;2;180;142;173:*.k25=0;38;2;180;142;173:*.kdc=0;38;2;180;142;173:*.kex=0;38;2;180;142;173:*.kra=0;38;2;180;142;173:*.kts=0;38;2;163;190;140:*.log=0;38;2;67;76;94:*.ltx=0;38;2;163;190;140:*.lua=0;38;2;163;190;140:*.m3u=0;38;2;180;142;173:*.m4a=0;38;2;180;142;173:*.m4v=0;38;2;180;142;173:*.mdc=0;38;2;180;142;173:*.mef=0;38;2;180;142;173:*.mid=0;38;2;180;142;173:*.mir=0;38;2;163;190;140:*.mkv=0;38;2;180;142;173:*.mli=0;38;2;163;190;140:*.mos=0;38;2;180;142;173:*.mov=0;38;2;180;142;173:*.mp3=0;38;2;180;142;173:*.mp4=0;38;2;180;142;173:*.mpg=0;38;2;180;142;173:*.mrw=0;38;2;180;142;173:*.msi=1;38;2;129;161;193:*.mtl=0;38;2;180;142;173:*.nef=0;38;2;180;142;173:*.nim=0;38;2;163;190;140:*.nix=0;38;2;180;142;173:*.nrw=0;38;2;180;142;173:*.obj=0;38;2;180;142;173:*.obm=0;38;2;180;142;173:*.odp=0;38;2;180;142;173:*.ods=0;38;2;180;142;173:*.odt=0;38;2;180;142;173:*.ogg=0;38;2;180;142;173:*.ogv=0;38;2;180;142;173:*.orf=0;38;2;180;142;173:*.org=0;38;2;180;142;173:*.otf=0;38;2;180;142;173:*.otl=0;38;2;180;142;173:*.out=0;38;2;67;76;94:*.pas=0;38;2;163;190;140:*.pbm=0;38;2;180;142;173:*.pcx=0;38;2;180;142;173:*.pdf=0;38;2;180;142;173:*.pef=0;38;2;180;142;173:*.pgm=0;38;2;180;142;173:*.php=0;38;2;163;190;140:*.pid=0;38;2;67;76;94:*.pkg=1;38;2;129;161;193:*.png=0;38;2;180;142;173:*.pod=0;38;2;163;190;140:*.ppm=0;38;2;180;142;173:*.pps=0;38;2;180;142;173:*.ppt=0;38;2;180;142;173:*.pro=0;38;2;163;190;140:*.ps1=0;38;2;163;190;140:*.psd=0;38;2;180;142;173:*.ptx=0;38;2;180;142;173:*.pxn=0;38;2;180;142;173:*.pyc=0;38;2;67;76;94:*.pyd=0;38;2;67;76;94:*.pyo=0;38;2;67;76;94:*.qoi=0;38;2;180;142;173:*.r3d=0;38;2;180;142;173:*.raf=0;38;2;180;142;173:*.rar=1;38;2;129;161;193:*.raw=0;38;2;180;142;173:*.rpm=1;38;2;129;161;193:*.rst=0;38;2;180;142;173:*.rtf=0;38;2;180;142;173:*.rw2=0;38;2;180;142;173:*.rwl=0;38;2;180;142;173:*.rwz=0;38;2;180;142;173:*.sbt=0;38;2;163;190;140:*.sql=0;38;2;163;190;140:*.sr2=0;38;2;180;142;173:*.srf=0;38;2;180;142;173:*.srw=0;38;2;180;142;173:*.stl=0;38;2;180;142;173:*.stp=0;38;2;180;142;173:*.sty=0;38;2;67;76;94:*.svg=0;38;2;180;142;173:*.swf=0;38;2;180;142;173:*.swp=0;38;2;67;76;94:*.sxi=0;38;2;180;142;173:*.sxw=0;38;2;180;142;173:*.tar=1;38;2;129;161;193:*.tbz=1;38;2;129;161;193:*.tcl=0;38;2;163;190;140:*.tex=0;38;2;163;190;140:*.tga=0;38;2;180;142;173:*.tgz=1;38;2;129;161;193:*.tif=0;38;2;180;142;173:*.tml=0;38;2;180;142;173:*.tmp=0;38;2;67;76;94:*.toc=0;38;2;67;76;94:*.tsx=0;38;2;163;190;140:*.ttf=0;38;2;180;142;173:*.txt=0;38;2;180;142;173:*.typ=0;38;2;180;142;173:*.usd=0;38;2;180;142;173:*.vcd=1;38;2;129;161;193:*.vim=0;38;2;163;190;140:*.vob=0;38;2;180;142;173:*.vsh=0;38;2;163;190;140:*.wav=0;38;2;180;142;173:*.wma=0;38;2;180;142;173:*.wmv=0;38;2;180;142;173:*.wrl=0;38;2;180;142;173:*.x3d=0;38;2;180;142;173:*.x3f=0;38;2;180;142;173:*.xlr=0;38;2;180;142;173:*.xls=0;38;2;180;142;173:*.xml=0;38;2;180;142;173:*.xmp=0;38;2;180;142;173:*.xpm=0;38;2;180;142;173:*.xvf=0;38;2;180;142;173:*.yml=0;38;2;180;142;173:*.zig=0;38;2;163;190;140:*.zip=1;38;2;129;161;193:*.zsh=0;38;2;163;190;140:*.zst=1;38;2;129;161;193:*TODO=1;38;2;180;142;173:*hgrc=0;38;2;163;190;140:*.avif=0;38;2;180;142;173:*.bash=0;38;2;163;190;140:*.braw=0;38;2;180;142;173:*.conf=0;38;2;180;142;173:*.dart=0;38;2;163;190;140:*.data=0;38;2;180;142;173:*.diff=0;38;2;163;190;140:*.docx=0;38;2;180;142;173:*.epub=0;38;2;180;142;173:*.fish=0;38;2;163;190;140:*.flac=0;38;2;180;142;173:*.h264=0;38;2;180;142;173:*.hack=0;38;2;163;190;140:*.heif=0;38;2;180;142;173:*.hgrc=0;38;2;163;190;140:*.html=0;38;2;180;142;173:*.iges=0;38;2;180;142;173:*.info=0;38;2;180;142;173:*.java=0;38;2;163;190;140:*.jpeg=0;38;2;180;142;173:*.json=0;38;2;180;142;173:*.less=0;38;2;163;190;140:*.lisp=0;38;2;163;190;140:*.lock=0;38;2;67;76;94:*.make=0;38;2;163;190;140:*.mojo=0;38;2;163;190;140:*.mpeg=0;38;2;180;142;173:*.nims=0;38;2;163;190;140:*.opus=0;38;2;180;142;173:*.orig=0;38;2;67;76;94:*.pptx=0;38;2;180;142;173:*.prql=0;38;2;163;190;140:*.psd1=0;38;2;163;190;140:*.psm1=0;38;2;163;190;140:*.purs=0;38;2;163;190;140:*.raku=0;38;2;163;190;140:*.rlib=0;38;2;67;76;94:*.sass=0;38;2;163;190;140:*.scad=0;38;2;163;190;140:*.scss=0;38;2;163;190;140:*.step=0;38;2;180;142;173:*.tbz2=1;38;2;129;161;193:*.tiff=0;38;2;180;142;173:*.toml=0;38;2;180;142;173:*.usda=0;38;2;180;142;173:*.usdc=0;38;2;180;142;173:*.usdz=0;38;2;180;142;173:*.webm=0;38;2;180;142;173:*.webp=0;38;2;180;142;173:*.woff=0;38;2;180;142;173:*.xbps=1;38;2;129;161;193:*.xlsx=0;38;2;180;142;173:*.yaml=0;38;2;180;142;173:*stdin=0;38;2;67;76;94:*v.mod=0;38;2;163;190;140:*.blend=0;38;2;180;142;173:*.cabal=0;38;2;163;190;140:*.cache=0;38;2;67;76;94:*.class=0;38;2;67;76;94:*.cmake=0;38;2;163;190;140:*.ctags=0;38;2;67;76;94:*.dylib=0;38;2;208;135;112:*.dyn_o=0;38;2;67;76;94:*.gcode=0;38;2;163;190;140:*.ipynb=0;38;2;163;190;140:*.mdown=0;38;2;180;142;173:*.patch=0;38;2;163;190;140:*.rmeta=0;38;2;67;76;94:*.scala=0;38;2;163;190;140:*.shtml=0;38;2;180;142;173:*.swift=0;38;2;163;190;140:*.toast=1;38;2;129;161;193:*.woff2=0;38;2;180;142;173:*.xhtml=0;38;2;180;142;173:*Icon\r=0;38;2;67;76;94:*LEGACY=0;38;2;180;142;173:*NOTICE=0;38;2;180;142;173:*README=0;38;2;180;142;173:*go.mod=0;38;2;163;190;140:*go.sum=0;38;2;67;76;94:*passwd=0;38;2;180;142;173:*shadow=0;38;2;180;142;173:*stderr=0;38;2;67;76;94:*stdout=0;38;2;67;76;94:*.bashrc=0;38;2;163;190;140:*.config=0;38;2;180;142;173:*.dyn_hi=0;38;2;67;76;94:*.flake8=0;38;2;163;190;140:*.gradle=0;38;2;163;190;140:*.groovy=0;38;2;163;190;140:*.ignore=0;38;2;163;190;140:*.matlab=0;38;2;163;190;140:*.nimble=0;38;2;163;190;140:*COPYING=0;38;2;180;142;173:*INSTALL=0;38;2;180;142;173:*LICENCE=0;38;2;180;142;173:*LICENSE=0;38;2;180;142;173:*TODO.md=1;38;2;180;142;173:*VERSION=0;38;2;180;142;173:*.alembic=0;38;2;180;142;173:*.desktop=0;38;2;180;142;173:*.gemspec=0;38;2;163;190;140:*.mailmap=0;38;2;163;190;140:*Doxyfile=0;38;2;163;190;140:*Makefile=0;38;2;163;190;140:*TODO.txt=1;38;2;180;142;173:*setup.py=0;38;2;163;190;140:*.DS_Store=0;38;2;67;76;94:*.cmake.in=0;38;2;163;190;140:*.fdignore=0;38;2;163;190;140:*.kdevelop=0;38;2;163;190;140:*.markdown=0;38;2;180;142;173:*.rgignore=0;38;2;163;190;140:*.tfignore=0;38;2;163;190;140:*CHANGELOG=0;38;2;180;142;173:*COPYRIGHT=0;38;2;180;142;173:*README.md=0;38;2;180;142;173:*bun.lockb=0;38;2;67;76;94:*configure=0;38;2;163;190;140:*.gitconfig=0;38;2;163;190;140:*.gitignore=0;38;2;163;190;140:*.localized=0;38;2;67;76;94:*.scons_opt=0;38;2;67;76;94:*.timestamp=0;38;2;67;76;94:*CODEOWNERS=0;38;2;163;190;140:*Dockerfile=0;38;2;180;142;173:*INSTALL.md=0;38;2;180;142;173:*README.txt=0;38;2;180;142;173:*SConscript=0;38;2;163;190;140:*SConstruct=0;38;2;163;190;140:*.cirrus.yml=0;38;2;163;190;140:*.gitmodules=0;38;2;163;190;140:*.synctex.gz=0;38;2;67;76;94:*.travis.yml=0;38;2;163;190;140:*INSTALL.txt=0;38;2;180;142;173:*LICENSE-MIT=0;38;2;180;142;173:*MANIFEST.in=0;38;2;163;190;140:*Makefile.am=0;38;2;163;190;140:*Makefile.in=0;38;2;67;76;94:*.applescript=0;38;2;163;190;140:*.fdb_latexmk=0;38;2;67;76;94:*.webmanifest=0;38;2;180;142;173:*CHANGELOG.md=0;38;2;180;142;173:*CONTRIBUTING=0;38;2;180;142;173:*CONTRIBUTORS=0;38;2;180;142;173:*appveyor.yml=0;38;2;163;190;140:*configure.ac=0;38;2;163;190;140:*.bash_profile=0;38;2;163;190;140:*.clang-format=0;38;2;163;190;140:*.editorconfig=0;38;2;163;190;140:*CHANGELOG.txt=0;38;2;180;142;173:*.gitattributes=0;38;2;163;190;140:*.gitlab-ci.yml=0;38;2;163;190;140:*CMakeCache.txt=0;38;2;67;76;94:*CMakeLists.txt=0;38;2;163;190;140:*LICENSE-APACHE=0;38;2;180;142;173:*pyproject.toml=0;38;2;163;190;140:*CODE_OF_CONDUCT=0;38;2;180;142;173:*CONTRIBUTING.md=0;38;2;180;142;173:*CONTRIBUTORS.md=0;38;2;180;142;173:*.sconsign.dblite=0;38;2;67;76;94:*CONTRIBUTING.txt=0;38;2;180;142;173:*CONTRIBUTORS.txt=0;38;2;180;142;173:*requirements.txt=0;38;2;163;190;140:*package-lock.json=0;38;2;67;76;94:*CODE_OF_CONDUCT.md=0;38;2;180;142;173:*.CFUserTextEncoding=0;38;2;67;76;94:*CODE_OF_CONDUCT.txt=0;38;2;180;142;173:*azure-pipelines.yml=0;38;2;163;190;140'; 

export "LS_COLORS"; 
