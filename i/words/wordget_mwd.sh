#!/bin/bash
## word of the day merriam webster 
wordget_mw_com() { 
local IFS=$'\n'; 
echo; 
echo; 
fold="$HOME/logs/words/wordlog"; 
mkdir $fold -p -m 775 2>/dev/null;
date=$(date +%F-%H_%M_%S);
wlog="$HOME/logs/words/tmp/mw_com_$date"; 
########
lynx -width 4000 -nonumbers -nomargins -dump https://www.merriam-webster.com/word-of-the-day | \
sed 's/_*//g' | \
grep -e 'Est. 1828' -m1 -A22 | \
sed -e "/\\/\\//,/*/d" -e 1,5d | \
grep -vE 'What It Means|Prev Next' | \
sed -e 4d -e '5y/\ /\n/' | \
tr -s "\n " "\n " | \
sed -e 's/^[ \t]*//' -e '/^$/d' > $wlog.log;
########
wowo="$(head -n1 $wlog.log)"; 
cat $wlog.log | sed -e '3s/^/[/' -e '3s/$/]/' | tee $fold/$wowo.log; 
echo; echo; 
}; 
########
wordget_mw_com; 
