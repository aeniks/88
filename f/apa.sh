
apa() { 
local IFS=$'\n '; 
unset ny sudo; 
hash sudo 2>/dev/null && sudo=sudo; 
[ $PREFIX ] && unset sudo; 
[ $UID = 0 ] && unset sudo; 
# [[ $COLUMNS > 22 ]]&& bw="70%,right";
# pwd="${PWD}"; 
printf %b "\n.... to update run [apass] ....\n"|\
bat -ppflc --theme Dracula; 
#cd 
# &>/dev/null; 
aapp=($(ls $HOME/logs/apts|fzf --query " $1" -i -m --color \
preview-bg:0 --bind "q:abort" --preview 'cat $HOME/logs/apts/{}|grep -Ev "Package|Version|Maintainer|APT-Sources|Download-Size"|sed -e "s/Homepage: //" -e "s/Description: //"|bat -ppfld' --preview-window "wrap,12,noborder,top" --cycle --ansi --inline-info))||\
(printf %b "\n\n"&& cd $pwd &>/dev/null&& return 1;)||\
return 1; cd - &>/dev/null && \
printf %b "\n\n"; (printf %b " -- Install: "; 
printf %b "${aapp[*]}"|tr -s "\n" ","; bb=" \b"; 
[[ ${#aapp[*]} == 1 ]]&& unset bb; 
printf %b "$bb ? [Y/n] ")|bat -ppflc --theme Nord; 
cd $OLDPWD &>/dev/null; 
read -s -n1 "ny"; if [ -z $ny ]; then cd $OLDPWD; 
printf %b "\e[92m OK\e[0m \n\n"; 
$sudo nala update; #>/dev/null|bat -ppflc --theme Dracula; 
$sudo nala upgrade -y; # 2>/dev/null|bat -ppflc --theme Dracula; 
$sudo nala install -y; # ${aapp[*]} 2>/dev/null|bat -ppflc --theme Dracula; 
$sudo nala autoremove -y; # 2>/dev/null|bat -ppflc --theme Dracula; 
fi; 
cd $OLDPWD &>/dev/null; printf %b "\n\n\${aapp[*]}\n\n"; 
printf %b "${aapp[*]}"|tr -s "\n" " ";
echo; echo; 
return 0; 
cd $OLDPWD; 
}; 
