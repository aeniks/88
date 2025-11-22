#!/bin/bash
## calll
12calendarget() { 

printf %b "getting cal... " && (curl -sL 'https://script.googleusercontent.com/macros/echo?user_content_key=AehSKLh82D-w6Vdzi3vdjLA0rakIzmnxVaN3TaSRrJjW71ONNO7Zvaq4bE1eONHgmJRX3fWLsQZ9nM4FjNjxtW26dFReTCX30DKPCP_vpZsACkJwAOQUSiRwoB2Lyr-g84HzkExyQ-EcfPci-euFNXYeidSnLTuCfMzcC10j5ZUafNjYlijpNwyWIrHB7FMisJz-7naOIzcrkfUEANLLr3wGW503lM0m6w0CB1X90FVjifOxiSmWyYFgEQrOVblbjO1bxC1Ew5U_BbR4B-UEMR3MTBjBwzkmCA&lib=M72QkDm7CT60m1UNRIr2naUe2CZqY5xWx' && printf %b "\nEPOCH_${EPOCHSECONDS}") > $HOME/logs/calendar.json && printf %b "\e[G"; 
####
((for i in {1..18}; do printf %b "·"; done; printf %b " $(date +%a\ %b\ %d\ %Y\ \|\ %T)\n") |bat -ppfljava --theme DarkNeon ; cat $HOME/logs/calendar.json | tr -s "," "\n" | grep -vE 'EPOCH_|h_|description|end_date' | sed '/start_date_time/{s/.[0-9]*[-T]//g}' | cut -f1 -d "+" | cut -f 2- -d":" | sed 's/"/\n/' | tr -s "\n\"}" "%%\n" | cut -f2-4 -d"%"|col -xb|column --separator "%" --table --output-separator " | " --table-columns "1234567890123456" --table-right 1|tail -n+2 |bat -ppflr --theme Visual\ Studio\ Dark+ ) > $HOME/logs/cal.log; 
}; 
####
####
12calendar() { 
[ -e $HOME/logs/calendar.json ] || 12calendarget; 
cat  $HOME/logs/calendar.json|grep -e "EPOCH" --quiet||12calendarget; 
###
####
printf -v "epoch" %b "$((EPOCHSECONDS / 20000))"; 
printf -v "epcal" %b "$(($(tail -c10 $HOME/logs/calendar.json) / 20000))"; 
[[ "$epoch" -gt "$epcal" ]] && 12calendarget; 
# [ $((_epoch_h - _epoch_h_cal)) -gt 222 ] 
# _epoch_h="$((EPOCHSECONDS / 3600))"; _epoch_h_cal="$(($(tail -c10 $HOME/logs/calendar.json) / 3600))"; 
####
cat $HOME/logs/cal.log; 
# head -n-1 $HOME/logs/calendar.json|sed -e "s/\ \ //g"|grep -vE 'description|end_date|call'|cut -f1 -d+|tr -d '"{}[],\t'|sed -e "s/summary\:\ /\n\ %/g"|tr -d "\n"|tr -s "%" "\n"|sed -e "s/start_date_time............./\ \%\ /g" -e "s/start_date\:/\ \%/g" -e s/start_date_time\:/\%\ /g|tr -s " " " "|column --separator "%" --table --output-width "$COLUMNS" --output-separator '|' --table|bat -ppflr --theme Visual\ Studio\ Dark+; 
}; 

# calle() { cat $HOME/logs/calendar.json |tr -s "," "\n"|grep -vE 'description|end_date'|sed '/start_date_time/{s/.[0-9]*[-T]//g}'|cut -f1 -d "+"|cut -f 2- -d":"|sed 's/"/\n/'|tr -s  "\n\"}" "%%\n"|cut -f2-4 -d"%"|column --separator "%" --table --table-name 1 --output-separator " | " --table-right 1 --table-noextreme 2,3 --table-columns "______ _event,day,time"|grep -vE "_event|EPOCH_"; }; 

# callee() { ((printf %b "\e[0m----------------- "; printf %b "$(date +%a\ %b\ %d\ %Y\ \|\ %T) -----------------\n") |bat -ppfljava --theme DarkNeon ; cat $HOME/logs/calendar.json | tr -s "," "\n" | grep -vE 'EPOCH_|h_|description|end_date' | sed '/start_date_time/{s/.[0-9]*[-T]//g}' | cut -f1 -d "+" | cut -f 2- -d":" | sed 's/"/\n/' | tr -s "\n\"}" "%%\n" | cut -f2-4 -d"%"|col -xb|column --separator "%" --table --output-separator " | " --table-columns "123456789012345" --table-right 1|tail -n+2 |bat -ppflr --theme Visual\ Studio\ Dark+ ) >  $HOME/logs/cal.log; }; 
####
## && printf %b "\nEPOCH_$EPOCHSECONDS " >> $HOME/logs/calc.sh; 
####
# gum style --border normal --padding "0 1"|
## sed -e "s/{/{\n/g" -e "s/}/\n}\n/g" -e "s/,/,\n/g" -e "s/\[/\[\n/g"
####
##cat $HOME/logs/calendar.json|col -xb|jq --indent 0|grep -vE 'description|end_date|call'|cut -f1 -d+|tr -d '"{}[],\t'|sed -e "s/summary:\ /\n%/g"|tr -d "\n"|tr "%" "\n"|sed -e "s/start_date_time............./\%\ /g" -e "s/start_date\:/\ \%/g" -e s/start_date_time\:/\ \%/g|column --separator "%" --output-width "$COLUMNS" --output-separator '|' --table|bat -ppflr --theme Visual\ Studio\ Dark+ ; }; 
########
########


# https://script.google.com/macros/s/AKfycbwSft4XmNq-lCW38uuBjihWM8pKMGrm-1uDmwusW7uksz0uN3WIEobzOt-0NQUgDOASqQ/exec
