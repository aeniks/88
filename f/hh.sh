#!/bin/bash
#history but better
#fzf$fzt --height ~88% --tac --inline-info --expect "q" -m -i
unalias hh 2>/dev/null; 
hh() { 
unset -v hh; 
##
[ $TMUX ] && fzt="-tmux -h"; [ -z $tmp ] && \
(tmp="$HOME/tmp"; mkdir -m 775 -p  $tmp 2>/dev/null; ); 
##
h1="$tmp/$(id -nu|tr -d "\n"; date +__%__y%m%d_%H_%M_%S).sh"; touch $h1; 
####
if [ $PREFIX ]; 
####
then \
history -s "$(bat -ppflbash $HISTFILE|tr -s "\n" "\n"|uniq -u|fzf --tac -i -m --wrap --cycle --highlight-line --wrap-sign="" --bind "q:abort" --style="minimal" --info inline; if [ $? != 0 ]; then $(return 1); echo; else history -a; history -n; fi; )" >> $HISTFILE; if [ $? != 0 ]; then echo okok; return 1; else history -a; history -n; fi; 
####
# [ "${hh}" ] && printf %b "\n${hh[*]}\n"|tee -a $HISTFILE; 
####
####
else \
history -s "$(bat -ppfljava $HISTFILE|tr -s "\n" "\n"|uniq -u|fzf --tac -i -m --cycle --bind "q:abort" --scheme history --no-inline-info --no-border || return 1 >> $HISTFILE || return 1; )"; 
fi; 
####
# [ "${hh}" ] && printf %b "${hh}" | tr -s "\n" " "; tee -a $HISTFILE; fi; 
####
####
# history -s "$(printf %b "${hh} \n") "; history -a; history -n; 
# [ -z "${hh}" ] && return 0;
if [ "$(tail -n 1 $HISTFILE)" ]; then 
printf %b "\n-\e[222b\n"; 
tail -n2 $HISTFILE; 
printf %b "\n-\e[222b\n
saved to: $dim$h1$re\n\n\
1) open/edit\n\
2) cp to: \n\
4) gist \n\
5) other \n\n"; 
read -sn1 "ny" && if [ -z $ny ]; 
then echo -e "$h1 $h2"; cat $h1; printf %b "\n\n\e[A${hh[*]}\n"; 
elif [ $ny = 1 ]; then $EDITOR $h1; 
elif [ $ny = 2 ]; then read -ep "cp to: " -i "$HOME/" hhto; cp $h1 $hhto; 
elif [ $ny = 4 ]; then read -ep "name: " -i "$h1" h2; mv $h1 $h2; gh gist create $h2; 
elif [ $ny = 5 ]; then read -ep "cmd: " -i "$PREFIX/bin/" "h2"; $h2 $h1; 
fi;
else printf %b "\n\n -- ok \n\n"; 
fi; 

}; 


