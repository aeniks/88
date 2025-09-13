#!/bin/bash 
## ps1 prompt for bash 
# batt() { 
# printf -v bs "\e[0;2m";cat /sys/class/power_supply/BAT0/status|grep -e "Charging"&& printf -v "bs" "\e[0;92m";
# printf -v bc "$(cat /sys/class/power_supply/BAT0/capacity)" \
# > $HOME/logs/bp.log
# # [ -e $HOME/logs/bp.log ] 2>/dev/null &&
# printf -v bc "\e[9$(cat $HOME/logs/bp.log|cut -c1)m" &&
# cat $HOME/logs/bp.log 2>/dev/null && printf %b "\e[0m "; cat "/sys/class/power_supply/BAT0/capacity" 2>/dev/null;
# }; 

# bc=0; 
# HOME="~"
wlan="$(cat "$HOME/logs/wlan.sh" 2>/dev/null)"; 
yellow='\e[93m'; 
cyan='\e[96m'; 
re='\e[0m'; 
[ "$PREFIX" ] && . "${HOME}"/88/crons/bat.sh & disown; 
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
# printf %b " ${bs}[$re\e[38;5;${bc:0:1}m${bat}${bs}]$re" > $HOME/logs/bp.log; 
[ "$bc" ] && printf %b " ${bs}[$re\e[38;5;${bc:0:1}m${bat}${bs}]$re"; 
}; 
# export IFS=$'\n '; 
[[ "$HOSTNAME" == "localhost" ]] && \
unset HOSTNAME || printf -v "_host" %b "[\e[95m$HOSTNAME\e[0m] "; 
# export HOSTNAME="${mod:0:12}"; 
# ['$re$pink'$HOSTNAME'$re']'$re' \
_dtime() { 
hh=1$(date +%H;); mm=1$(date +%M;); ss=1$(date +%S); 
printf %b "\e[38;5;$((hh + 22))m${hh:1:2}$re:\e[38;5;$((mm + 22))m${mm:1:2}$re:\e[38;5;$((ss + 22))m${ss:1:2}"; 
}; 
_etime() { 
printf %b "\e[38;5;$((${EPOCHSECONDS: -2} * 2))m${EPOCHSECONDS}" 2>/dev/null;  
}; 

. "$HOME/88/i/colors.sh"; 
# _ps1() { 
# mod=${model:1:12}
PS1=''$re'\e[0m[\e[0;1;38;5;$((2 + $?))m$?'$re'] \
['$re'$(_dtime)'$re'-$(_etime)'$re']'$re'\
'$re'$(_bat) \
['$re'\e[0;2m'${wlan%.*}'.\e[0;1m'${w[${wlan/*./}]}'${wlan/*./}'$re'] \
['$re'\e[0m'${w[${wlan/*./}]}'\e[7;47;1m${model:0:12}'$re'] \
['$re$cyan'\u'$re']'$re' \
$_host\
['$re$yellow'\w'$re']\e[?25h\e[0m\n'; 
# };

# ['$re'\e[1m\e[38;5;$((RANDOM%88 + 88))m${model:0:12}'$re'] \

