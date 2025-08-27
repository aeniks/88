#!/bin/bash
## get notes
callist() { termux-notification-list | tee $HOME/logs/callist.json; 
cat $HOME/logs/callist.json|sed -e "s/\\n/\ /g"|tr -s " " " "|grep -e "content" -C1|sed -e /\"\"\,/d|grep -e '",' -A1|cut -f4- -d"\""|tr -d "\""| tee $HOME/logs/callist.log; cat $HOME/logs/callist.log|bat -pfljava --theme Nord; 
}; 
