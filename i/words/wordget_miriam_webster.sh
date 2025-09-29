#!/bin/bash
wordget_miriam() { 
##
mkt="$(mktemp)"; 
td="$HOME/logs/words/wordlog"; 
unset -v words; 
mkdir -p -m 775 $td 2>/dev/null; 
# tf="word_merriam_webster_$(date +%y%m%d_%H%M%S).log"; 
##
w3m -dump https://www.merriam-webster.com/word-of-the-day > "${mkt}"; 
# $td/$tf
#s
# local IFS='%'; 
local IFS=$'\n'; 
words=($(cat "$mkt" | grep -e 'Est. 1828' -A20|tail -n+7|grep -vE 'play|Prev Next|━|What It Means'|sed 2,4"s/\ /\n\n/"|fmt -w999|grep -v '// '|tr -s "\n" "\n")); 

##
printf %b "${words[0]}\n[ ${words[2]} ]\n${words[1]}\n${words[-1]}" > $td/$words.log; 
}; 
##
wordget_miriam; 


# words=($(cat "$mkt" | grep -e 'Est. 1828' -A20|tail -n+7|grep -vE 'play|Prev Next|━|What It Means'|sed 2,4"s/\ /\n/"|sed "a\\\n%\\n"|tr -s " " " "|fmt -w 999|grep -v '// '|tr -d "\n")); 
