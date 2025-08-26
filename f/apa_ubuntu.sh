
apa_ubuntu() { 
[ -e $HOME/logs/apt_ubuntu.list ] || $sudo apt list 2>/dev/null|cut -f1 -d"/" | tee $HOME/logs/apt_ubuntu.list; 
####
apub=($(cat $HOME/logs/apt_ubuntu.list|fzf --preview "$sudo apt show {} 2>/dev/null|bat -ppfld"; )); printf %b "\n  -- install: ${apub[*]} ? [Y/n] "; read -srn1 "ny"; [ -z $ny ] && $sudo nala update && $sudo nala upgrade -y && $sudo nala install -y ${apub[*]}; printf %b "\n  ok  \n ";  }; 
