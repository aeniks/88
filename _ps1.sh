#!/bin/bash 
################
[ "$PREFIX" ] && . "${HOME}"/88/crons/bat.sh & disown; 
touch $HOME/logs/bp.log; chmod 775 $HOME/logs/bc.log; 
yellow='\e[93m'; cyan='\e[96m'; re='\e[0m'; bc=0; 
wlan="$(cat "$HOME/logs/wlan.sh" 2>/dev/null)"; 
################
_bat() { 
if [ -e "/sys/class/power_supply/BAT0/status" ]; \
then printf -v "batstat" "/sys/class/power_supply/BAT0/status"; \
printf -v "batcap" "/sys/class/power_supply/BAT0/capacity"; 
elif [ -e "/sys/class/power_supply/battery/status" ]; \
then printf -v "batstat" "/sys/class/power_supply/battery/status"; \
printf -v "batcap" "/sys/class/power_supply/battery/capacity"; 
elif [ -e "/sys/class/power_supply/BAT1/status" ]; \
then printf -v "batstat" "/sys/class/power_supply/BAT1/status"; \
printf -v "batcap" "/sys/class/power_supply/BAT1/capacity"; 
else printf -v "batstat" %b "$HOME/logs/battery.log"; 
printf -v "batcap" %b "$HOME/logs/bp.log"; fi; 
printf -v "bs" "\e[0;2m"; 
cat "$batstat" 2>/dev/null|grep -wi "Charging" --quiet && \
printf -v "bs" "\e[0;92m"; 
[ "$bc" ] && printf -v "bc" %b "$(cat "$batcap")"; 
[ "$bc" ] && printf %b "$bc" > "${HOME}"/logs/bpc.log; 
printf -v "bat" %b "\e[${bc}m$bc"; 
[ "$bc" ] && printf %b " ${bs}[$re\e[38;5;${bc:0:1}m${bat}${bs}]$re"; 
}; 
################
[[ "$HOSTNAME" == "localhost" ]] && unset HOSTNAME || \
printf -v "_host" %b "[\e[95m$HOSTNAME\e[0m] "; 
################
_dtime() { hh=1$(date +%H;); mm=1$(date +%M;); ss=1$(date +%S); 
printf %b "\e[38;5;$((hh + 22))m${hh:1:2}$re:\e[38;5;$((mm + 22))m${mm:1:2}$re:\e[38;5;${ss/0/1}m${ss:1:2}\e[0m" 2>/dev/null; }; 
_etime() { printf %b "\e[38;5;$((${EPOCHSECONDS:8:2}))m${EPOCHSECONDS:6:4}\e[0m";  }; 
################
alias gitstats='[ -e $PWD/.git ] && printf -v "gitst" %b "\e[0m[\e[46;97mgit\e[0m]" && (printf %b "${gitst}\t$(git status --short|tr "\n" "\t"|bat -ppfld --theme Coldark-Dark)")'; 
################
. "$HOME/88/i/colors.sh"; 
################

################
PS1=''$re'\e[0m[\e[0;1;38;5;$((2 + $?))m$?'$re'] \
['$re'$(_dtime 2>/dev/null)'$re'] \
['$re'$(_etime)'$re']'$re'$(_bat) \
['$re'\e[0;2m'${wlan%.*}'.\e[0;1m'${w[${wlan/*./}]}'${wlan/*./}'$re'] \
['$re'\e[0m'${w[${wlan/*./}]}'\e[7;47;1m${model:0:12}'$re'] \
['$re$cyan'\u'$re']'$re' '${_host}'['$re$yellow'\w'${re}]' $(gitstats)\e[?25h\e[0m\n'; 
