#!/bin/bash
wordget_dictionary_com() { 
local IFS=$'\n'; fold="$HOME/logs/words/wordlog"; mkdir $fold -p -m 775 2>/dev/null; 
date=$(date +%F-%H_%M_%S); 
wlog="$HOME/logs/words/tmp/dictionary_com_$date"; 
####
lynx -trim_input_fields -nonumbers -nomargins -trim_blank_lines -dump 'https://www.dictionary.com/e/word-of-the-day/' | \
####
grep -e 'Previous' -m1 -A22 | \
tail -n+9 | \
sed /Look\ it\ up/,//d | \
sed -e 's/\[ /\n/' -e 's/ \]/\n/' | \
tr -s '\n' '\n' | \
sed '/Show IPA/d' > $wlog.log; 
####
wowo="$(head -n1 $wlog.log)"; 
sed -n 1p $wlog.log > $fold/$wowo.log; 
sed -n 3p $wlog.log >> $fold/$wowo.log; 
(printf %b '['; sed -n 2p $wlog.log | tr "\n" "]"; 
printf %b '\n') >> $fold/$wowo.log; 
tail -n+4 $wlog.log >> $fold/$wowo.log; 
}; 
####
wordget_dictionary_com; 


# wowo=($(lynx -width 2400 -dump https://www.dictionary.com/e/word-of-the-day | grep -m 1 -e "Learn More" -B7|sed -e '/^$/d' -e 's/\]\ /\]\n/g' -e 's/^[ \t]*//'|sed -e 4d -e 7d)); 
# ####
# printf %b "${wowo[0]}\n${wowo[1]}\n${wowo[3]}\n${wowo[4]}\n${wowo[2]}" > $fold/${wowo/\ /_}.log; 
