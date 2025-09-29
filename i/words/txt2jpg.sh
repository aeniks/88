#!/bin/bash
word22jpg() { 
####
local IFS=$'\n\t'; 
wordfolder="$HOME/logs/words/wordlog"; 
wordimg="$HOME/logs/words/wordimg"; 
mkdir -m 775 -p "$wordfolder" "$wordimg"; 
word="$(command ls -t1 $wordfolder|grep -e '.log$'|head -n1|sed -e 's/\.log//g')"; 
words=($(cat $wordfolder/$word.log)); 
####
####
# [ $1 ] && word="$(printf %b "$1"|sed -e 's/\.log//g')"; 
# [ $1 ] && words=($(cat $1)); 
####
####
local IFS=$'\n\t '; 
gum style --margin "1 2 0 2" --align center --border none "$(printf %b "${words[0]}"|bat -ppfljava)"|ansifilter -M -F "serif" -s 40 > $wordfolder/$word.htm; 
gum style --margin "0 2 0 2" --align center --border none "$(printf %b "${words[1]}"|bat -ppfljava)"|ansifilter -M -F "code" -s 28 >> $wordfolder/$word.htm; 
gum style --margin "0 2 0 2" --align center --border none --foreground "#bbbbbb" "$(printf %b "${words[2]}")"|ansifilter -M -F "sans-serif" -s 25 >> $wordfolder/$word.htm; 
gum style --margin "0 2 1 2" --padding "0 2 0 2" --align center --border normal --border-foreground "#bbbbbb" "$(printf %b "${words[3]}"|fmt -w 40 -g 28|bat -ppfljava)"|ansifilter -M -F "monospace" -s 28 >> $wordfolder/$word.htm; 


# $HOME/logs/words/cous.tff
####
convert -border 1 -bordercolor black -gravity center pango:"$(cat $wordfolder/${word}.htm)" "$wordimg/${word}2.jpg"; 
####
hexx="$(pastel random -n1|pastel format hex|col -xb)"; 

convert -border 6%x22% -bordercolor "$hexx" "$wordimg/${word}2.jpg" "$wordimg/${word}.jpg"; 
####
rm "$wordfolder/${word}.htm" "$wordimg/${word}2.jpg"; 
}; 


# convert -border 1 -bordercolor black -gravity center -background "red" wordimg/ethereal.jpg dd.jpg; convert -border 5%x22% -bordercolor "#558899" dd.jpg dd2.jpg; kola dd2.jpg




word22jpg; 
