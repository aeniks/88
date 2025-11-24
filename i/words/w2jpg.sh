#!/bin/bash
words2jpg() { 
local IFS=$'\n\t '; 
echo; echo; 
wordfolder="$HOME/logs/words"; 
wordlog="$wordfolder/wordlog"; cd "$wordlog"; 
latest="$(command ls -t1 $wordlog|grep -e '.log$'|head -n1)"; 
word="${latest/.*/}"; ww="$wordlog/$latest"; 
# [ "$1" ] && latest="${1/*\//}"; [ "$1" ] && ww="$1"; 
mkdir -m 775 -p "$wordfolder/wordlog" "$wordfolder/wordimg/story" "$wordfolder/wordimg/post" "$wordfolder/up" 2>/dev/null; 
# local IFS=$'\n\t '; 
####
# gum style --margin "0 2 0 2" --align center --border none "$(sed -n 1p $ww)"
## create file and spacing on top
printf %b "  "|ansifilter -M -F "serif" -s 150 > $wordlog/${word}.htm; 
printf %b "  $(sed -n 1p $ww)  "|ansifilter -M -F "serif" -s 260 >> $wordlog/$word.htm; 
sed -n 3p $ww|bat -ppfld --theme GitHub|ansifilter -M -F "code" -s 60 >> $wordlog/$word.htm; 
sed -n 2p $ww|bat -ppfljs --theme Coldark-Cold|ansifilter -M -F "sans-serif" -s 60 >> $wordlog/$word.htm; 
sed -n 4,6p $ww|fmt -w 48 -g 29|gum style --padding "1 5 5 5" --margin "0 1 0 0"|ansifilter -M -F "monospace" -s 60 >> $wordlog/$word.htm; 
############
# gum style --margin "0 2 2 2" --border hidden --padding "1 2 1 2" --border-foreground "#666666" "$(
# printf %b "  "|ansifilter -M -F "serif" -s 20 >> $wordlog/$word.htm; 
#gum style --margin "0 2 0 2" --align center --border none \
#"$(
#)"
############
############
hexx="$(pastel random -n1|pastel format hex|col -xb)"; 
####
convert -border 4 -bordercolor black -gravity center pango:"$(cat $wordlog/$word.htm|col -xb)" $wordlog/$word.jpg; 

# im=($(mediainfo "$wordfolder/wordimg/$word.2.jpg"|grep -E 'Width|Height'|tr -d "A-z:\t "));

# imh="$((im[1] - im))"; imw="$((im - im[1]))"; [ "$imw" -gt 1 ] && imh=122; 
# $((imh + 222))x$((imw / 2 "+ 222")) 
##
convert -border 444x444 -bordercolor "$hexx" \
"$wordlog/$word.jpg" "$wordfolder/wordimg/post/$word.jpg"; 
##
convert -border 422x1288 -bordercolor "$hexx" \
"$wordlog/$word.jpg" "$wordfolder/wordimg/story/$word.jpg"; 

# "$wordfolder/wordimg/$word.2.jpg" "$wordfolder/wordimg/story/$word.jpg"; 
##
printf %b "
$wordfolder/wordimg/story/${word}.jpg \n
$wordfolder/wordimg/post/${word}.jpg  \n "; 
####
cp "$wordfolder/wordimg/post/${word}.jpg" -t "$wordfolder/up"; 
# mv "$wordfolder/wordlog/${word}.htm" "$wordfolder/wordimg/$word.2.jpg" -t ~/tmp; cd -; 
# mv "$wordlog/${word}.log" -t $HOME/logs/words/up
####
}; 
words2jpg; 
# iw="$(mediainfo pp.jpg | grep 'Width'|tr -d "A-z:\n\t ")"; ih="$(mediainfo pp.jpg | grep 'Height'|tr -d "A-z:\n\t ")"; 

