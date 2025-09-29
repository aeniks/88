#!/usr/bin/env bash
word2jpg() { 
local IFS=$'\n\t '; 
lina() { printf %b "\e[0;2m"; for i in $(seq ${1:-15}); do printf %b "-"; done; printf %b "\e[0m"; }; 

if [ "$1" ]; then wf=$(realpath "${1}") && wd="$(printf %b "${1}"|sed -e 's/\.log//g')"; 

else wf="$HOME/logs/words/wordlog" && wd="$(ls -t1 $wf|grep -e '.log$'|sed -e 's/\.log//g')"; fi; 
####
####
gum style --border hidden --padding "1 2 0 2" --margin "2 2 0 2" --align center \
"$(printf %b "\e[38;2;211;44;162m"; sed -n 1p ${wf}/${wd}.log|tr -d "\n"; printf %b "\e[0m\n"; 
lina 9)" | \
ansifilter -M -s 60 -F "Cutive Mono" > "${wf}/${wd}.html"; 
####
####
(printf %b "\e[1;38;2;244;122;166m"; 
####
sed -n 1p "${wf}/${wd}.log"; printf %b "\e[0m";
sed -n 2p "${wf}/${wd}.log"|bat -ppfljs --theme TwoDark; 
sed -n 3p "${wf}/${wd}.log"|fmt --goal 66|gum style --border hidden --padding "1 2 1 2" --margin "0 2 5 2" --background "#dcdcdc") | \
ansifilter -M -F "Cutive Mono" -s 50 >> "${wf}/${wd}.html"; 
####
####
convert -background "#f4f8fa" -gravity center pango:"$(cat ${wf}/${wd}.html)" ${wf}/${wd}.jpg; 
}; 
word2jpg; 
