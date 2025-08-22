#!/bin/bash
# alaaaaais
alias kk='sed -e "s/\ \ //g"|bat -pfljava'; 
alias 12alias='$EDITOR ~/88/alias.sh'; 
alias 88='cd ~/88; echo; realpath ~/88|bat -ppfljava; echo; ls --color=always -GghtrAp --group-directories-first; echo; git status'; 
alias 88_pullpush='git commit -a -m "${USER}_${mod}_$(date)" -v; git pull; git push; ls --color=always -trAmp --group-directories-first'; 
