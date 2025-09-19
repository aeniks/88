apa() { 

# [ -z $PREFIX ] && apa_ubuntu && return 0  2>/dev/null && break 2>/dev/null; 
local IFS=$' \n\t'; 
unset -v ny
# sudo; 
hash sudo 2>/dev/null && sudo=sudo; 
[ $PREFIX ] && unset sudo; 
[ $UID = 0 ] && unset sudo; 
# [[ $COLUMNS > 22 ]]&& bw="70%,right";
# pwd="${PWD}"; 
# printf %b "\n.... to update run [apass] ....\n"|bat -ppflc --theme Dracula; 
#cd 
# &>/dev/null; 
FZF_DEFAULT_OPTS='-m -i --ansi --bind "0:change-preview-window(right,50%|top,20%|top,55%|right,20%|hidden),q:abort" --info inline --inline-info --preview-window "wrap,noborder" --preview "bat -ppf {} 2>/dev/null||ls --color always -pm {}"'
# [ -e "$HOME/logs/apts.log" ]
# sleep 8 & disown; 


local IFS=$' \n\r'; 
printf %b "\e[?25l\n\n\n\n\n\n\e[5A\e[96m -- \e[0mGetting list \e7"; 
apt list 2>/dev/null|tail -n +2|cut -f1 -d"/" > "$HOME/logs/apts.log" & disown; 
printf %b "\e8\e[K"; ae="$!"; (for i in {1..55}; 
do printf %b "\e[38;5;$((RANDOM%222 + 22))m\u25$((RANDOM%99)) "; 
read -t .5 -srn1 "yu"; [ $yu ] && printf %b "\e[?25l\e[0m gg" && break; 
ps|grep -e "$ae" --quiet 2>/dev/null||break; done) 2>/dev/null; 
printf %b "\e[0m\e[?25l \e[42m done \e[0m\n\n"; 


aapp=($(bat -ppfljava "$HOME/logs/apts.log"|fzf --query " $1" -i -m --color \
preview-bg:0 --bind "q:abort" --preview 'apt show {} 2>/dev/null|tr -s "\n " "\n "|grep -vE "Package|Version|Maintainer|APT-Sources|Download-Size"|sed -e "s/Homepage: //" -e "s/Description: //"|bat -ppfld' --preview-window "wrap,66%,noborder,right" --cycle --ansi --inline-info))||\
(cd - &>/dev/null; printf %b "\n\n"&& cd $pwd &>/dev/null&& return 1;)||\
return 1; cd - &>/dev/null && \
printf %b "\n\n\n\n\e[4A\n"; (printf %b " -- Install: "; 
printf %b "${aapp[@]}"|tr -s "\n" ","; bb=" \b"; 
[[ ${#aapp[*]} == 1 ]] && unset bb; 
printf %b "$bb ? \e[0m[\e[1;92mY\e[0m/\e[1;91mn\e[0m] or [\e[1;95mR\e[0m]\e[2memove\e[0m ")|bat -ppfljava --theme Nord; 
cd $OLDPWD &>/dev/null; 
read -s -n1 "ny"; if [ -z $ny ]; then cd $OLDPWD; 
printf %b "\e[92m OK\e[0m \n\n"; 

tmux split-window -e apap="${aapp[*]}" -l "12%" -v '$sudo apt update 2>/dev/null; printf %b "\n\n -- ${apap}\n"; read -t1 -n1 sasa; $sudo apt install -y ${apap[*]}; for i in {1..5}; do printf %b "\e[48;5;21${i}m\e[22S\n\n\e[2A\e[12G\e[0;95;7m gg "; read -n1 -t 1 xx; done; '; 
# $sudo apt upgrade -y 2>/dev/null|bat -ppfljava --theme DarkNeon; clear; 
elif [ $ny = r ]; then tmux split-window -l 5 '$sudo apt remove -y ${aapp[*]}|bat -ppfljava --theme DarkNeon; echo ok; read -t5 -n1 xx;'; 
fi; 
cd $OLDPWD &>/dev/null; 
# printf %b "\n\n -- \${aapp[*]}\n\n"|bat -ppflc --theme Nord; 
printf %b "${aapp[@]}"|tr -s "\n" " "|bat -ppflc --theme Nord; 
echo; echo; 
return 0; 
cd $OLDPWD; 
}; 


# echo; for i in {1..6}; do printf %b "\e[95;4${i}m\e[\u258${i}\e[${COLUMNS}b\n"; sleep .5; done; printf %b "\e[4A\e[?25l\e[4;8;9m\t\t\e[0;96m[ok]"; read -t5 -n1 xx; 

