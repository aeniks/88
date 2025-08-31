#!/bin/bash
#history but better
#fzf$fzt --height ~88% --tac --inline-info --expect "q" -m -i
unalias hh 2>/dev/null; 
hh() { [ $TMUX ] && fzt="-tmux -h"; [ "$TMPDIR" ]||(mkdir $HOME/tmp 2>/dev/null; 
TMPDIR="$HOME/tmp"; ); h1="$TMPDIR/$(id -nu|tr -d "\n"; date +__%__y%m%d_%H_%M_%S).sh"; touch $h1; 
if [ $PREFIX ]; then bat -ppflbash $HISTFILE|tr -s "\n" "\n"|uniq -u|fzf --tmux "center,99%,99%" --tac -i -m --wrap --cycle --highlight-line --wrap-sign="" --bind "1:abort" --style="minimal" --info inline|tee $h1 -a $HISTFILE || exit 0; 
else 
cat $HISTFILE|tr -s "\n" "\n"|uniq -u|fzf-tmux -h --tac -i -m --cycle --bind "q:abort" --scheme history --no-inline-info --no-border|tee $h1 -a $HISTFILE; fi && (printf %b "
saved to: $dim$h1$re\n\n\
1) open/edit\n\
2) cp to: \n\
4) gist \n\
5) other \n\n" && read -sn1 "ny" && if [ -z $ny ]; then echo -e "$h1 $h2"; cat $h1; 
elif [ $ny = 1 ]; then $EDITOR $h1; 
elif [ $ny = 2 ]; then read -ep "cp to: " -i "$HOME/" hhto; cp $h1 $hhto; 
elif [ $ny = 4 ]; then read -ep "name: " -i "$h1" h2; mv $h1 $h2; gh gist create $h2; 
elif [ $ny = 5 ]; then read -ep "cmd: " -i "$PREFIX/bin/" "h2"; $h2 $h1; 
fi; ); 

}; 


