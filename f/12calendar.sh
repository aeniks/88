#!/bin/bash
## calll
12calendarget() { 
(curl -sL "https://script.google.com/macros/s/AKfycbwSft4XmNq-lCW38uuBjihWM8pKMGrm-1uDmwusW7uksz0uN3WIEobzOt-0NQUgDOASqQ/exec" && printf %b "\n\nEPOCH_$EPOCHSECONDS") > $HOME/logs/calendar.json; 
}; 
####
####
12calendar() { 
[ -e $HOME/logs/calendar.json ] || 12calendarget; 
cat  $HOME/logs/calendar.json|grep -e "EPOCH" --quiet||12calendarget; 
####
_epoch_h="$((EPOCHSECONDS / 3600))"; 
_epoch_h_cal="$(($(tail -c10 $HOME/logs/calendar.json) / 3600))"; 
####
[ $((_epoch_h - _epoch_h_cal)) -gt 2 ] && 12calendarget;
####
head -n-1 $HOME/logs/calendar.json|jq|sed -e "s/\ \ //g"|grep -vE 'description|end_date|call'|cut -f1 -d+|tr -d '"{}[],\t'|sed -e "s/summary\:\ /\n\ %/g"|tr -d "\n"|tr -s "%" "\n"|sed -e "s/start_date_time............./\ \%\ /g" -e "s/start_date\:/\ \%/g" -e s/start_date_time\:/\%\ /g|tr -s " " " "|column --separator "%" --table --output-width "$COLUMNS" --output-separator '|' --table|bat -ppflr --theme Visual\ Studio\ Dark+; 
}; 
####
## && printf %b "\nEPOCH_$EPOCHSECONDS " >> $HOME/logs/calc.sh; 
####
# gum style --border normal --padding "0 1"|
## sed -e "s/{/{\n/g" -e "s/}/\n}\n/g" -e "s/,/,\n/g" -e "s/\[/\[\n/g"
####
##cat $HOME/logs/calendar.json|col -xb|jq --indent 0|grep -vE 'description|end_date|call'|cut -f1 -d+|tr -d '"{}[],\t'|sed -e "s/summary:\ /\n%/g"|tr -d "\n"|tr "%" "\n"|sed -e "s/start_date_time............./\%\ /g" -e "s/start_date\:/\ \%/g" -e s/start_date_time\:/\ \%/g|column --separator "%" --output-width "$COLUMNS" --output-separator '|' --table|bat -ppflr --theme Visual\ Studio\ Dark+ ; }; 
########
########


