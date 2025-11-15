#!/bin/bash
words2jpg() { 
local IFS=$'\n\t'; 
wordlog="$HOME/logs/words/wordlog"; 
wordimg="$HOME/logs/words/wordimg"; 
mkdir -m 775 -p "$wordlog" "$wordimg"; 
w="$(command ls -t1 $wordlog|grep -e '.log$'|head -n1)"; 
ww="$wordlog/$w"; 
word="${w/.*/}"; 
# words=($(cat $wordlog/$word.log)); 
local IFS=$'\n\t '; 
####
printf %b "  "|ansifilter -M -F "serif" -s 90 > $wordlog/$word.htm; 
 
gum style --margin "0 2 0 2" --align center --border none \
"$(sed -n 1p $ww)"|ansifilter -M -F "serif" -s 160 >> $wordlog/$word.htm; 
printf %b "  "|ansifilter -M -F "serif" -s 20 >> $wordlog/$word.htm; 

gum style --margin "0 2 0 2" --align center --border none \
"$(sed -n 2p $ww|bat -ppfld --theme GitHub)"|ansifilter -M -F "code" -s 60 >> $wordlog/$word.htm; 

gum style --margin "0 2 0 2" --align center --border none --foreground "#888888" \
"$(sed -n 3p $ww)"|ansifilter -M -F "monospace" -s 60 >> $wordlog/$word.htm; 

gum style --margin "0 2 2 2" --border hidden --padding "1 2 1 2" --border-foreground "#666666" \
"$(sed -n 4,8p $ww|fmt -w 55 -g 40|bat -ppflc++ --theme Coldark-Cold)"|ansifilter -M -F "monospace" -s 60 >> $wordlog/$word.htm; 
# gum style --margin "0 2 0 2" --align center --border none --foreground "#bbbbbb" "$(printf %b "${words[2]}")"|ansifilter -M -F "sans-serif" -s 40 >> $wordlog/$word.htm; 


# gum style --margin "0 2 1 2" --padding "1 2 1 2" --align center --border normal --border-foreground "#bbbbbb" "$(printf %b "${words[3]}"|fmt -w 44 -g 25|bat -ppfljava)"|ansifilter -M -F "monospace" -s 40 >> $wordlog/$word.htm; 
####
convert -border 2 -bordercolor black -gravity center pango:"$(cat $wordlog/${word}.htm)" "$wordimg/${word}2.jpg"; 
####
hexx="$(pastel random -n1|pastel format hex|col -xb)"; 
####
convert -border 16%x22% -bordercolor "$hexx" "$wordimg/${word}2.jpg" "$wordimg/${word}.jpg"; 
####
rm "$wordlog/${word}.htm" "$wordimg/${word}2.jpg"; 
}; 
words2jpg; 
