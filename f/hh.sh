#!/bin/bash
#history but better
#fzf$fzt --height ~88% --tac --inline-info --expect "q" -m -i
unalias hh 2>/dev/null; 
hh() { unset -v hh; [ $TMUX ] && fzt="-tmux -h"; [ -z $tmp ] && (tmp="$HOME/tmp"; mkdir -m 775 -p  $tmp 2>/dev/null; ); h1="$tmp/$(id -nu|tr -d "\n"; date +__%__y%m%d_%H_%M_%S).sh"; touch $h1; 
if [ $PREFIX ]; then hh="$(bat -ppflbash $HISTFILE|tr -s "\n" "\n"|uniq -u|fzf --tmux "center,99%,99%" --tac -i -m --wrap --cycle --highlight-line --wrap-sign="" --bind "q:abort" --style="minimal" --info inline)"; [ "${hh}" ] && printf %b "${hh[*]}"|tee $h1 -a $HISTFILE || echo gg && return 0; 
else 
hh="$(bat -ppfljava $HISTFILE|tr -s "\n" "\n"|uniq -u|fzf-tmux -h 99% -w 99% --tac -i -m --cycle --bind "q:abort" --scheme history --no-inline-info --no-border)"; [ "${hh}" ] && printf %b "${hh}" | tee $h1 -a $HISTFILE || (echo gg && return 1;)||return 0; fi; 
# [ -z "${hh}" ] && return 0;
printf %b "
saved to: $dim$h1$re\n\n\
1) open/edit\n\
2) cp to: \n\
4) gist \n\
5) other \n\n" && read -sn1 "ny" && if [ -z $ny ]; then echo -e "$h1 $h2"; cat $h1; 
elif [ $ny = 1 ]; then $EDITOR $h1; 
elif [ $ny = 2 ]; then read -ep "cp to: " -i "$HOME/" hhto; cp $h1 $hhto; 
elif [ $ny = 4 ]; then read -ep "name: " -i "$h1" h2; mv $h1 $h2; gh gist create $h2; 
elif [ $ny = 5 ]; then read -ep "cmd: " -i "$PREFIX/bin/" "h2"; $h2 $h1; 
fi; 

}; 


