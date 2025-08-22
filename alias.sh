#!/bin/bash
# alaaaaais
alias kk='col -xb|bat -pfljava'; 
alias 12alias='$EDITOR ~/88/alias.sh'; 
alias 88='cd ~/88; echo; realpath ~/88|bat -ppfljava; echo; ls --color=always -GghtrAp --group-directories-first; echo; git status'; 
alias 88_pullpush='git commit -a -m "${USER}_${mod}_$(date)" -v; git pull; git push; ls --color=always -trAmp --group-directories-first'; 
# li=$(($(ps -A|wc -l)+6)); [ ${li} -gt ${LINES} ] && li=${LINES}; 
alias bb='if [ "$PREFIX" ]; then \
tmux display-popup -w "98%" -h "98%" "htop"; else \
tmux display-popup -w 98% -h 98% "btop"; fi '
alias qb='ssh aa@ants.ftp.sh "qbittorrent-nox -d" && xdg-open https://qb.aeniks.com'
alias jacketts='/home/aa/gh/jackett/jackett &'
