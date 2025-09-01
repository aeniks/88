#!/bin/bash
12localan() { 
## discover lan w ping & ssh 
#ipt=$(mktemp; ); 
mkdir -p $HOME/logs/iplocal/ 2>/dev/null; rm $HOME/logs/iplocal/* 2>/dev/null;  
printf %b "\n\n\n\n\e[4A\n -- ip ok? "; read -ep '>' -i "${wlan[*]}" "iploc"; 
printf %b "\e[?25l\n -- checking ips ... \t\t [q]uit\n\n\n\n\e[4A\n\n"; 
# ip -4 n
for i in {0..66}; do printf %b "\e[K"; 
ping -c 1 ${iploc%.*}.${i} &>/dev/null && \
printf %b "\n\n$i\e[A" && 
touch $HOME/logs/iplocal/${iploc%.*}.$i & disown; 
# printf %b "\e[K\n${iploc%.*}.$i" && 
printf %b "\e[K\e[A\e[K"; 
read -t 0.05 -n1 -s -p "${iploc%.*}.$i " "ny"; 
[ $ny ]&& printf %b "\n\n\e[?25h" && return 0 && break; done; 
# printf %b "${iploc%.*}.$i\n" >> "$ipt"& disown; \

printf %b "\e[?25h";  
printf %b "\e[K\n--------\n\$iplocal\t$ipt\n\
--------\n\n"; 
# ipends=($(cat $ipt|cut -f4 -d"."; ));
rm $HOME/logs/iplocal/$iploc 2>/dev/null; 
iplocal=($(command ls $HOME/logs/iplocal; )); 
# iplocall=-($iploc);
command ls "$HOME/logs/iplocal"; echo; 
for i in ${iplocal[*]}; do \
nmap --open $i -p 22,8022|grep -e "open"|cut -f1 -d"/" >> \
$HOME/logs/iplocal/$i; done; 
printf %b "\e[?25h"; 
## selection menu 
lomenu() { 
local IFS=$'\n\t ' ops=($2); [ "$2" ]||local ops=($(command ls -1 $HOME/logs/iplocal)); 
# local desc=()
local prompt="$1" index="0" cur="0" count="${#ops[@]}" logs=$HOME/logs/iplocal;
printf "\e[?25l    --$prompt--\n"; ## print prompt
while true; do local index="0"; for o in "${ops[@]}"; ## print option
do if [ "$index" = "$cur" ]; 
then printf %b " > \e[7m ${o}:$(cat $logs/$o) \e[0m\n"; ## mark & highlight the current option
else printf %b "    ${o}:$(cat $logs/$o|tr -d "\n") \e[0m\n"; fi; (( index++ )); done; ## list all options (option list is zero-based)
read -srn1 key; ## wait for user to key in arrows or ENTER
if [[ $key == A ]]; then printf %b "\e[K"; (( cur-- )); (( cur < 0 ))&& (( cur = 0 )); printf %b "\e[K"; 
elif [[ $key = B ]]; then printf %b "\e[K"; (( cur++ )); (( cur >= count ))&& (( cur = count - 1 )); printf %b "\e[K"; 
elif [[ $key == "" ]]; then break; elif [[ $key == "q" ]]; \
then printf %b "\n\n\e[?25h"; return 0; break; fi; # enter
printf %b "\e[K\e[${count}A"; done; # go up to the beginning to re-render
printf -v sel "${ops[$cur]}"; 
printf %b "\e[?25h\n\n\n\n\e[2A  user: "; 
read -re "u"; [ -z $u ]&& u=$UID; 
printf %b "\e[?25h  connecting to: \e[7m ${u}@${sel} -p $(cat $logs/$o) \e[0m\n\n"; 
echo; 
sshlatest=( -p $(cat $logs/$sel) $sel -l $u ); 
printf %b "ssh ${sshlatest[*]}"|tr -s "\n" " " | tee -a $HISTFILE > $logs/$sel
sleep .5; 
# printf %b "ssh ${sshlatest[*]}" >> ~/.bash_history; 
history -s "ssh ${sshlatest[*]} "; 
ssh ${sshlatest[*]}; 
}; 
lomenu " open lan ip:s "
}; 
