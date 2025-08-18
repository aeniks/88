#!/bin/bash
## calll
12cal() { cat ~/logs/calendar.json|col -xb|jq --indent 0|grep -vE 'description|end_date|call'|cut -f1 -d+|tr -d '"{}[],\t'|sed -e "s/summary:\ /\n%/g"|tr -d "\n"|tr "%" "\n"|sed -e "s/start_date_time............./\%\ /g" -e "s/start_date\:/\ \%/g" -e s/start_date_time\:/\ \%/g|column --separator "%" --output-width "$COLUMNS" --output-separator '|' --table|bat -ppflr --theme Visual\ Studio\ Dark+ ; printf %b "\e[A"; };
