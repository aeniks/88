timme() { while true; do printf %b "\e7\e[14H\e[1J\e[4H"; 
figlet -f Roman -w $COLUMNS -c "$(date +%H:%M)"|bat -ppfljs; 
printf %b "\e[2A\e[K\e8"; sleep 1800; done; }; 
