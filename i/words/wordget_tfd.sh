#!/bin/bash
wordget_tfdictionary_com() { 
local IFS=$'\n'; 
fold="$HOME/logs/words/wordlog"; 
mkdir $fold -p -m 775 2>/dev/null; 
date=$(date +%F-%H_%M_%S); 
wlog="$HOME/logs/words/tmp/thefreedictionary_com_$date"; 
####
lynx -dump 'https://www.thefreedictionary.com/_/WoD/rss.aspx' -width 800 -nonumbers -nomargins -force_empty_hrefless_a | tr '<>/' '\n' | grep -e 'Definition' | cut -f2 -d" " --complement > $wlog.log; 
###

for i in {1..3}; do sed -n ${i}p $wlog.log | \
tr -s "\n " "\n " | \
sed -e "s/[(]/\n/" -e "s/[)]\ /\n\n/" | sed -e 's/ $//' > $wlog.$i.log; 
####
wowo="$(head -n1 $wlog.$i.log)"; 
cat $wlog.$i.log > $fold/$wowo.log; 
done; 

}; 
wordget_tfdictionary_com; 
