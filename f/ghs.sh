
ghs() { [ -z $1 ]&& read -rep ' -- repo: ' "ghs"||ghs=($@); IFS=$'\n'; oo=($(gh search repos ${ghs[*]}|sed -e s/\\t/\ /g)); rm $tmp/ghs/*; mkdir -p $tmp/ghs 2>/dev/null; for i in ${oo[*]}; do printf %b "$i" > $tmp/ghs/$(printf %b "${i/\ */}"|sed -e 's/\//@/';); done; ghss=($(command ls $tmp/ghs/ -tr| fzf -i -m --preview 'clear; cat $tmp/ghs/{}|bat -ppflzig' --preview-window '6,top,wrap' --bind 'q:abort' --cycle --info inline --border none; )); cd ~/gh; for a in ${ghss[*]}; do gh repo clone ${a/@//}; done; printf %b "\e[96m${ghss[*]/@//}\e[0m\n"; ls --color=always --classify -shG ${ghss[*]/*@/}; }; 
####
alias 12githubsearch='ghs'; 
