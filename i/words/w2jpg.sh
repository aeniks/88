#!/bin/bash
words2jpg() { 
local IFS=$'\n\t'; wordlog="$HOME/logs/words/wordlog"; wordimg="$HOME/logs/words/wordimg"; mkdir -m 775 -p "$wordlog" "$wordimg"; 
latest="$(command ls -t1 $wordlog|grep -e '.log$'|head -n1)"; 
ww="$wordlog/$latest"; 
[ "$1" ] && latest="${1/*\//}"; 
[ "$1" ] && ww="$1"; 
word="${latest/.*/}"; local IFS=$'\n\t '; 
####


# gum style --margin "0 2 0 2" --align center --border none "$(sed -n 1p $ww)"
## create file and spacing on top
printf %b "  "| ansifilter -M -F "serif" -s 150 > $wordlog/$word.htm; 
sed -n 1p $ww|ansifilter -M -F "serif" -s 260 >> $wordlog/$word.htm; 
sed -n 3p $ww|bat -ppfld --theme GitHub|ansifilter -M -F "code" -s 60 >> $wordlog/$word.htm; 
sed -n 2p $ww|bat -ppfljs --theme Coldark-Cold|ansifilter -M -F "sans-serif" -s 60 >> $wordlog/$word.htm; 
sed -n 4,8p $ww|fmt -w 48 -g 29|gum style --padding "1 5 2 5" --margin "0 1 2 0"|ansifilter -M -F "monospace" -s 60 >> $wordlog/$word.htm; 
############
# gum style --margin "0 2 2 2" --border hidden --padding "1 2 1 2" --border-foreground "#666666" "$(
# printf %b "  "|ansifilter -M -F "serif" -s 20 >> $wordlog/$word.htm; 
#gum style --margin "0 2 0 2" --align center --border none \
#"$(
#)"
############
############
####
convert -border 4 -bordercolor black -gravity center pango:"$(cat $wordlog/${word}.htm)" "$wordimg/${word}2.jpg"; 

hexx="$(pastel random -n1|pastel format hex|col -xb)"; 

im=($(mediainfo "$wordimg/${word}2.jpg"|grep -E 'Width|Height'|tr -d "A-z:\t ")); 
imh="$((im[1] - im))";
imw="$((im - im[1]))"; [ "$imw" -gt 1 ] && imh=122; 
convert -border ${imh}x$((imw / 2 "+ 122")) -bordercolor "$hexx" "$wordimg/${word}2.jpg" "$wordimg/${word}.jpg"; 

# 6%x29% 
####
cp "$wordimg/${word}.jpg" -t "$HOME/fofo/wordimg"; 
mv "$wordlog/${word}.htm" "$wordimg/${word}2.jpg" -t ~/tmp; 
####
}; 
words2jpg; 


# iw="$(mediainfo pp.jpg | grep 'Width'|tr -d "A-z:\n\t ")"; ih="$(mediainfo pp.jpg | grep 'Height'|tr -d "A-z:\n\t ")"; 

