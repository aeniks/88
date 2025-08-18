# unalias 12; 
12() { 
for i in ~/start/funcs/*.sh; do . $i; done; 
read -rep 'ls? ' 'ny'; [ -z $ny ] && ls=($(ls ${HOME}/start/funcs|fzf --preview "bat -ppfljava ~/start/funcs/{}")); 
printf %b "\n${ls[*]}\n"; ${ls/.*/}; 
}; 
