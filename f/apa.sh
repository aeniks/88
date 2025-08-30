
apa() { 
local IFS=$'\n '; 
unset ny sudo; 
hash sudo 2>/dev/null && sudo=sudo; 
[ $PREFIX ] && unset sudo; 
[ $UID = 0 ] && unset sudo; 
# [[ $COLUMNS > 22 ]]&& bw="70%,right";
# pwd="${PWD}"; 
# printf %b "\n.... to update run [apass] ....\n"|bat -ppflc --theme Dracula; 
#cd 
# &>/dev/null; 
FZF_DEFAULT_OPTS='--bind "0:change-preview-window(right,50%|top,20%|top,55%|right,20%|hidden),q:abort" --info inline --inline-info --preview-window "wrap,noborder" --preview "bat -ppf {} 2>/dev/null||ls --color always -pm {}"'
aapp=($(ls $HOME/logs/apts|fzf --query " $1" -i -m --color \
preview-bg:0 --bind "q:abort" --preview 'cat $HOME/logs/apts/{}|tr -s "\n " "\n "|grep -vE "Package|Version|Maintainer|APT-Sources|Download-Size"|sed -e "s/Homepage: //" -e "s/Description: //"|bat -ppfld' --preview-window "wrap,5,noborder,top" --cycle --ansi --inline-info))||\
(printf %b "\n\n"&& cd $pwd &>/dev/null&& return 1;)||\
return 1; cd - &>/dev/null && \
printf %b "\n\n\n\n\e[4A\n"; (printf %b " -- Install: "; 
printf %b "${aapp[*]}"|tr -s "\n" ","; bb=" \b"; 
[[ ${#aapp[*]} == 1 ]]&& unset bb; 
printf %b "$bb ? \e[0m[\e[2mY\e[0m/\e[2mn\e[0m] or [\e[2mr\e[0m]\e[2memove\e[0m ")|bat -ppfljava --theme Nord; 
cd $OLDPWD &>/dev/null; 
read -s -n1 "ny"; if [ -z $ny ]; then cd $OLDPWD; 
printf %b "\e[92m OK\e[0m \n\n"; 
tmux split-window -l "12%" -d -v "$sudo apt update 2>/dev/null|bat -ppfljava --theme DarkNeon; $sudo apt upgrade -y 2>/dev/null|bat -ppfljava --theme DarkNeon; clear; $sudo apt install -y ${aapp[*]}|bat -ppfljava --theme DarkNeon; for i in {1..5}; do printf %b '\e[48;5;21${i}m\e[22S\n\n\e[2A\e[12G\e[0;95;7m gg '; read -n1 -t 1 xx; done; "; 
elif [ $ny = r ]; then tmux split-window -l 5 "$sudo apt remove -y ${aapp[*]}|bat -ppfljava --theme DarkNeon; echo 'ok'; read -t5 -n1 xx;"; 
fi; 
cd $OLDPWD &>/dev/null; 
# printf %b "\n\n -- \${aapp[*]}\n\n"|bat -ppflc --theme Nord; 
printf %b "${aapp[*]}"|tr -s "\n" " "|bat -ppflc --theme Nord; 
echo; echo; 
return 0; 
cd $OLDPWD; 
}; 


# echo; for i in {1..6}; do printf %b "\e[95;4${i}m\e[\u258${i}\e[${COLUMNS}b\n"; sleep .5; done; printf %b "\e[4A\e[?25l\e[4;8;9m\t\t\e[0;96m[ok]"; read -t5 -n1 xx; 

