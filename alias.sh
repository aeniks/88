#!/bin/bash
# alaaaaais
alias kk='col -xb|bat -pfljava --theme DarkNeon'; 
alias 12alias='$EDITOR ~/88/alias.sh'; 
alias 88='cd ~/88; echo; realpath ~/88|bat -ppfljava; echo; ls --color=always -GghtrAp --group-directories-first; echo; git status'; 
alias 88pullpush='git add ./; git commit -a -m "${USER}_${mod}_$(date)" -v; git pull; git push; ls --color=always -trAmp --group-directories-first'; 
# li=$(($(ps -A|wc -l)+6)); [ ${li} -gt ${LINES} ] && li=${LINES}; 
alias 12_choose_logins_screen='read -n1 -ep "  $c2  g/t  $(systemctl get-default)  " "gt"; if [ $gt == t ]; then sudo systemctl set-default multi-user.target; else sudo systemctl set-default graphical.target; fi ; echo gg'
alias bb='if [ "$PREFIX" ]; then \
tmux display-popup -E -w "98%" -h "98%" "htop"; else \
tmux display-popup -E -w 98% -h 98% "btop"; fi '
alias qb='ssh aa@ants.ftp.sh "qbittorrent-nox -d" && xdg-open https://qb.aeniks.com'
alias jacketts='/home/aa/gh/jackett/jackett &'
[ -z $PREFIX ] && sudo=sudo; 
alias uu='$sudo nala update; $sudo nala upgrade -y'
alias ffff='[ -z $PREFIX ] && neofetch || [ $PREFIX ] && fastfetch --percent-type 2 --logo-position right --logo-padding 2 --bar-border-right "" --bar-border-left "" --disable-linewrap';
