
apa_ubuntu() { 
[ -e $HOME/logs/apt_ubuntu.list ] || $sudo apt list 2>/dev/null|cut -f1 -d"/" | tee $HOME/logs/apt_ubuntu.list; 
####
apub=($(cat $HOME/logs/apt_ubuntu.list|fzf -m -i --preview "$sudo apt show {} 2>/dev/null|bat -ppfljava"; )); [ $apub ] && printf %b "\n  -- install: ${apub[*]} ? [Y/n] " && read -srn1 "ny"; [ -z $ny ] && tmux display-popup -e apubt=${apub[*]} -E '$sudo nala update && $sudo nala upgrade -y && $sudo nala install -y ${apubt[*]}; read -n1 aa; '; printf %b "\n  ok  \n ";  }; 
