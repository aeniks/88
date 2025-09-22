tiden() { 
printf %b "\ec"; 
while true; do printf %b "\e[4H\ec"; 

fortune |tee $HOME/.$EPOCHSECONDS|wc -c

figlet -f Roman -w $COLUMNS -c "$(date +%H:%M:%S)" | bat -ppfljs; 
printf %b "\e[$((LINES - 5))H\e[5A"; 

gum style --border normal --border-foreground "$((RANDOM%222))" --margin "1 4" \
"$(gum style --border normal --padding "1 4" --margin "0 4 0 0" --border-foreground "$((RANDOM%222))" "$(while true; do [ "$(fortune|tee ~/.ff|wc -c)" -lt 120 ] && break; done; 
bat -ppfljava ~/.ff|tr -s "\t "  " "; )")";
sleep 8; 
done; 

}; 
tiden

# gum style --border normal --padding "0 2" --margin "1 $((RANDOM%8))" "$(fortune|wc -c|fmt -g 44|bat -ppfljs --theme TwoDark)"; read -sn1 -t12 "kk";  [ "$kk" = q ] && return 0; done; 
