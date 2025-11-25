#!/bin/bash
wordget_dictionary_com() { 
sh $HOME/88/i/words/wpre.sh; 
local IFS=$'\n'; echo; echo; 
wordfolder="$HOME/logs/words"; 
fold="$HOME/logs/words/wordlog"; 
date=$(date +%F-%H_%M_%S); 
wlog="$HOME/logs/words/tmp/dictionary_com_$date"; 
####
lynx -trim_input_fields -nonumbers -nomargins -trim_blank_lines -width 800 -dump 'https://www.dictionary.com/e/word-of-the-day/' | \
grep -e 'Previous' -m1 -A22 | tail -n+9 | \
sed /Look\ it\ up/,//d | sed -e 's/\[ /\n/' -e 's/ \]/\n/' | \
tr -s '\n' '\n' | sed '/Show IPA/d' > $wlog.log; 
####
####
word="$(head -n1 $wlog.log)"; 
sed -n 1p $wlog.log >  $fold/$word.log; 
sed -n 3p $wlog.log >> $fold/$word.log; 
(printf %b '['; sed -n 2p $wlog.log | tr "\n" "]"; 
printf %b '\n') >> $fold/$word.log; 
tail -n+4 $wlog.log >> $fold/$word.log; 
printf %b "\n----\n$word\n----\n"
}; 
####
wordget_dictionary_com; 
