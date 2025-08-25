
apa_ubuntu() { apub=($(cat $HOME/logs/apt_ubuntu.list|fzf --preview "$sudo apt show {} 2>/dev/null|bat -ppfld"; )); printf %b "\n  -- install: ${apub[*]} ? [Y/n] "; read -srn1 "ny"; [ -z $ny ] && $sudo apt update && $sudo apt upgrade -y && $sudo apt install -y ${apub[*]}; printf %b "\n  ok  \n ";  }
