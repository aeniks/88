#!/bin/bash 
## install config-files 
instart() { 
hash sudo 2>/dev/null && sudo="sudo"; hash sudo 2>/dev/null || alias sudo=' '; 
[ $PREFIX ] && unset sudo; [ $UID = 0 ] && unset sudo && unalias sudo; 
mkdir $HOME/tmp 2>/dev/null; mkdir $HOME/logs 2>/dev/null; 
mkdir $HOME/gh 2>/dev/null; mkdir $HOME/.config 2>/dev/null; 
export tmp=$HOME/tmp; 
#####
#####
local IFS=$'\n\t ' green='\e[32m' dim='\e[2m' re='\e[0m' red='\e[31m' \
cyan='\e[36m' yellow='\e[33m' blue='\e[36m' bold='\e[1m' \
height="$(stty size|cut -f1 -d" ")" width="$(stty size|cut -f2 -d" ")" \
yno='\e[0m[\e[2mY\e[0m/\e[2mn\e[0m]' c2='\e[0m\e[36m--\e[0m' uu="60" \
enter='\e[\e[0m [\e[2mENTER\e[0m] to accept or [\e[2mq\e[0m]\e[2mto Quit \e[0m' x="2>/dev/null"; 
####
####
unalias _loader 2>/dev/null; 
_loader() { 
unset kill; 
printf %b "\e[A\e[K\e[?25l\e[46G${re}"; 
# printf "    [   [${dim}a${re}] to abort"; 
pid="$!"; spin='-\|/'; i=0; 
while kill -0 "$pid" 2>/dev/null; 
do i=$(( (i+1) %4 )); 
printf "${re} \e[46G [${dim}${spin:$i:1} \b${re}] "; 
read -t 0.1 -s -n1 kill; [ $kill ]&& kill $pid; 
# tail -c21 $tmp/in.log; printf %b "\e[u"; 
done; 
printf %b "\n"; 
printf %b "${re}\e[0J \e[46G [${dim}done \b${re}]\e[0J "; 
printf %b "\e[0J"; 
}; 
####
# $sudo apt install -y bat iproute2 nmap lf git \
# gh fzf wget micro bash-completion \
# ssh openssh-server &>/dev/null & disown;
apts_basic=(\
sudo gh git rsync file openssl openssh-sftp-server openssh bsdmainutils \
micro gnupg fzf mediainfo lf bat batcat runsv ncdu2 htop wget \
bash-completion lsd tmux cron texinfo iproute2 mandoc nala 
fortunes fortune fortune-mod figlet w3m nmap net-tools btop \
termux-tools termux-api termux-api cronie mpvb curl \
); 
apts_sec=(\
btop htop ncdu figlet lynx iproute2 net-tools nmap \
links2 fastfetch neofetch wget wget2 curl aria2 iw timg rclone \
); 
apt_termux=(\
termux-tools termux-api termux-api cronie \
); 
apts_more=(\
ffmpegthumbnailer ffmpeg-thumbnailer\
toilet rclone w3m w3m-img googler exiftool aha \
); 
####
apts_extra=(ffmpeg mpv);
########
####
####
####
unalias p1 p2 2>/dev/null; 
p1() { p2=" ${@}"; for i in $(seq ${#p2}); do sleep .04; printf %b "${p2:${i}:1}"; done; }; ## rolling text 
p2() { printf %b "$@"; }; 
# _move() { mv -S "$EPOCHSECONDS" $@ &>/dev/null; }; 
_link() { ln -s $@ 2>/dev/null; }; 
########
_newcolor() { printf %b "\e[38;5;$((uu++))m"; sleep .02; }; 
########
_backup() { mkdir $HOME/tmp 2>/dev/null; tmp=$HOME/tmp; time=$(date +%y%m%d%H%m%S); 
mv -fb --suffix="$time" $@ -t $tmp &>/dev/null; 
}; 
_yno() { 
printf %b ""; 
_ok() { 
printf %b "\e[40G     \e[8D  "; 
p2 "\e[0;1m [\e[0;92m"; p1 "OK"; p2 "\e[0;1m]  \e[0m\n"; }; 
p1() { p2=" ${@}"; for i in $(seq ${#p2}); do sleep .04; printf %b "${p2:${i}:1}"; done; }; ## rolling text 
p2() { printf %b "$@"; }; 
yno='\e[0m[\e[2mY\e[0m/\e[2mn\e[0m]' 
[[ "$1" ]]&& ny=${1}; printf %b "\e[?25h\e[40G\b\b\b\b\b\b\b\b$yno "; 
printf -v _yno_${1} "false"; read -rsn1 ny; 
[[ -z $ny || $ny = y ]] && printf -v _yno_${1} "true"; 
[[ $ny = q ]] && printf %b "\e[?25h\n\n" && _quit && return 0; _ok; 
[[ $ny = q ]] && printf %b "\e[?25h\n\n" && _quit && return 0; 
# printf %b "\n_yno_$1 = $_yno_${1} \n"; 
}; 

# printf %b "$green OK$re\n" && \
####
for i in $(seq $((height - 4))); do printf %b "\e[38;5;$((RANDOM%16 + 111))m$i\n"; sleep .04; done; ## scroll page 
for i in $(seq $((height - 6))); do printf %b "\e[K\e[A\e[2K"; sleep .02; done; 
printf %b "\e[?25l"; 
# printf %b "\n\n\e[2A"
for i in {1..12}; do printf %b "\e[s\e[38;5;$((RANDOM%229))m\e[s\e[98;5;$((RANDOM%22))m\e[4m"; 
echo '  __  __  ______  __      __      ______
 /\ \_\ \/\  ___\/\ \    /\ \    /\  __ \
 \ \  __ \ \  __\\ \ \___\ \ \___\ \ \/\ \
  \ \_\ \_\ \_____\ \_____\ \_____\ \_____\
   \/_/\/_/\/_____/\/_____/\/_____/\/_____/
'; 
# figlet -o -f sub-zero "hello"; 
sleep .1; printf %b "\e[u"; done; printf %b "\e[?25h\e[0m\e[95m"; 
sleep .1; printf %b "\e[0m\e[92m"; echo '  __  __  ______  __      __      ______ '; 
sleep .1; printf %b "\e[0m\e[97m"; echo ' /\ \_\ \/\  ___\/\ \    /\ \    /\  __ \ '; 
sleep .1; printf %b "\e[0m\e[91m"; echo ' \ \  __ \ \  __\\ \ \___\ \ \___\ \ \/\ \ '; 
sleep .1; printf %b "\e[0m\e[95m"; echo '  \ \_\ \_\ \_____\ \_____\ \_____\ \_____\ '
sleep .1; printf %b "\e[0m\e[96m"; echo '   \/_/\/_/\/_____/\/_____/\/_____/\/_____/ 
'; 
# printf %b "\e[20G\b\b\b\b\b\b\b\b${enter[*]}\n\n"; 
# for i in {1..7}; do echo; sleep .1; done; 
####
#### Update system? 
_be_sudo() { 
us=${USER}; [ $UID = 0 ] && us="${SUDO_USER}"; 
p2 " $c2 "; p1 "Become Superuser? "; _yno update; if [[ $_yno_update == true ]]; then _newcolor; 
p2 " $c2 "; p1 "For whom"; printf %b "\e[2m?\e[0m\e[96m\e[1m "; 
read -ep ' ' -ri "${us}" "us"; printf %b "\e[0m"; _ok; 
printf %b "\e[s\e[6;6H"; 
$sudo printf %b "${us} ALL=(ALL) NOPASSWD: ALL\n"|tee -a /etc/sudoers.d/sudo.sh 2>/dev/null; 
_newcolor; printf %b "\e[u"; 
p2 " $c2 "; p1 "$us is now in $(printf %b "${bold}${green}")GOD$(printf %b "${re}") mode . . . ."; 
_newcolor; 
fi; 
printf %b "\e[0m\n"; 
}; 

_update() {
p2 " $c2 "; p1 "Update system? "; _yno update; 
if [[ $_yno_update == true ]]; then _newcolor; 
printf %b "\e[s"; _newcolor; 
$sudo apt update 2>/dev/null;  _newcolor; 
printf %b "\e[u\e[J"; $sudo apt upgrade -y 2>/dev/null; _newcolor; 
printf %b "\e[u\e[J"; 
aps_need=(curl fzf git gh lf gnupg micro); hash ${aps_need[*]} 2>/dev/null || \
(p2 " $c2 "; p1 "Installing... "; printf %b "\e[s"; _newcolor; 

for i in ${aps_need[*]}; do printf %b "\e[38;5$((RANDOM%44 + 66))m \e[u"; done; 
printf %b "\n"; 

$sudo apt install -y $i 2>/dev/null; _newcolor; ); printf %b "\e[u\e[J"; 
printf %b "\e8\e[2A${re} \e[46G [${dim}done \b${re}]\e[0J \n\n"; fi; 
}; 
####
#### Install apps? 
_apt_installer() { 
p2 " $c2 "; p1 "Install apps? "; _yno aptins; if [[ $_yno_aptins == true ]]; then \

printf %b "\n\e[0K Installing: \e[s"; for ap in ${apts_basic[*]}; do _newcolor; 
printf %b "$ap \e[u"; 
$sudo apt install -y $ap --assume-yes &>/dev/null && \
_newcolor && printf %b "\e[4G\e[0m    installed" && \
_newcolor && printf %b " $ap\e[0K"; 
# printf %b " $ap\e8\e[J"; 
done; 
printf %b "\e8\e[A${re} \e[46G [${dim}done \b${re}]\e[0J \n"; sleep .2; 
fi; 
}; 
####
#### Download config files? 
_download() {
p2 " $c2 "; p1 "Download config files? "; _yno download; 
if [[ $_yno_download == true ]]; then \
p2 " $c2 "; p1 "Where to? "; read -ei "$HOME/" "hstart"; printf %b "\e[A"; 
start="${hstart}/start"; sleep .2; export start="${start/\/\///}"; 
_backup $start; _newcolor; 
git clone https://github.com/aeniks/start.git $start &>/dev/null; 
cd $start; git config remote.origin.url git@github.com:aeniks/start.git; 
####
####
#cd $start; git config set remote.origin.url git@github.com:aeniks/start.git; 
#gh config set git_protocol ssh 2>/dev/null; cd -; 
fi; 
# 
# mv $start/.git/config $start/.git/config_old 2>/dev/null; printf %b '\
# [core]\n  repositoryformatversion = 0 \n  filemode = true\n  bare = false
# logallrefupdates = true\n  [remote "origin"]\n  url = git@github.com:aeniks/start.git
# fetch = +refs/heads/*:refs/remotes/origin/*\n  [branch "main"]\n  remote = origin
# merge = refs/heads/main\n  [pull]\n  rebase = true\
# ' > $start/.git/config; 2>/dev/null; cd $start; 
# 
####
}; 
_install_conf() { 
mkdir -p $HOME/logs/apts -m 775 2>/dev/null; 
touch $HOME/logs/bp.log $HOME/logs/aptup.log 2>/dev/null; 
mkdir $HOME/crons -m 775 2>/dev/null; 
ln -s $start/crons/* -t $HOME/crons/ 2>/dev/null; 
$sudo rm $PREFIX/etc/motd -fr 2>/dev/null; ## remove motd 
p2 " $c2 "; p1 "Install config? "; _yno in_conf
if [[ $_yno_in_conf == true ]]; then \
# $sudo mv $PREFIX/etc/lf $tmp/ 2>/dev/null; _newcolor; 
# $sudo ln $start/config/lf $PREFIX/etc/ -s  2>/dev/null; _newcolor; 
mkdir $HOME/.config 2>/dev/null; _newcolor; 
_link $PREFIX/bin/batcat $PREFIX/bin/bat &>/dev/null; 
_link $PREFIX/bin/bat $PREFIX/bin/batcat &>/dev/null; 
####
#### 
_newcolor; printf %b "\e[0m\t\t"; 
touch $HOME/.bashrc; cat $HOME/.bashrc|grep -e "anew.sh" &>/dev/null||\
printf %b "\n. $start/anew.sh;"&>/dev/null >> $HOME/.bashrc 2>/dev/null; 
touch $HOME/.config/tmux_state 2>/dev/null; chmod 775 $HOME/.config/tmux_state; echo; 
####
_backup $HOME/.inputrc; _newcolor; 
_link $start/config/inputrc $HOME/.inputrc; _newcolor; 
##########
_backup $HOME/.tmux.conf $HOME/.tmux.conf.local; _newcolor; 
_link $start/config/tmux/tmux.conf $HOME/.tmux.conf; _newcolor; 
_link $start/config/figlet/figz.sh $HOME/; _newcolor; 
########
_backup $HOME/.tmux_bash.sh; _newcolor; 
_link $start/config/tmux/tmux_bash.sh $HOME/.tmux_bash.sh; _newcolor; 
#########
_backup $HOME/.termux/termux.properties; _newcolor; 
_link $start/config/termux/termux.properties $HOME/.termux/; _newcolor; 
######
_backup $HOME/.config/micro/settings.json; _newcolor; 
_backup $HOME/.config/micro/bindings.json; _newcolor; 
ln -s $start/config/micro/settings.json $start/config/micro/bindings.json -t $HOME/.config/micro/; _newcolor; 
######
###### batcat config 
if [ -n $PREFIX ]; then apt install bat -y 2>/dev/null; 
ln --symbolic $PREFIX/bin/bat $PREFIX/bin/batcat; else $sudo apt install batcat -y 2>/dev/null; 
$sudo ln --symbolic $PREFIX/bin/batcat $PREFIX/bin/bat 2>/dev/null; fi; _newcolor; 
$sudo ln -s $PREFIX/usr/games/fortune $PREFIX/usr/bin/ 2>/dev/null; 
$sudo ln -s $PREFIX/usr/bin/batcat $PREFIX/usr/bin/bat 2>/dev/null; 
######
###### github & ssh - config files 
###### link config files to home 
conf=(micro newsboat bat lf tmux htop glow aichat ranger); 
for q in ${conf[*]}; do 
mkdir -p $HOME/.config/$q 2>/dev/null; 
_backup $HOME/.config/$q/*; _newcolor; 
ln -s $start/config/$q/* -t $HOME/.config/$q/ 2>/dev/null; sleep .2; 
printf %b "\n\e[0m"; p1 "updated"; _newcolor; printf %b " $q"; 
done; echo; cd; _newcolor; 
printf %b "${PATH}:${HOME}/.local/bin" > $HOME/.config/path.sh; chmod 775 $HOME/.config/path.sh; _newcolor; 

printf %b "\n -- added "$PATH" to $HOME/.config/path.sh \n\n "; _newcolor; 
####
$sudo apt install -y figlet 2>/dev/null; 
######## 
. $start/config/figlet/install_fonts.sh 2>/dev/null; 
mkdir -p -m 775 $PREFIX/share/figlet 2>/dev/null||\
$sudo mkdir -p -m 775 $PREFIX/share/figlet 2>/dev/null; 
cp $HOME/start/config/figlet/fonts/* -t $PREFIX/usr/share/figlet/ 2>/dev/null||\
$sudo cp $HOME/start/config/figlet/fonts/* -t $PREFIX/share/figlet/ 2>/dev/null; 
$sudo chmod 775 $PREFIX/share/figlet -R 2>/dev/null; 
####
mkdir -m 775 -p $HOME/.local/bin 2>/dev/null; 
$sudo cp $start/config/ssss.sh $HOME/.local/bin/ssss 2>/dev/null; 
# export PATH=${PATH}:~/.local/bin:$PREFIX/usr/games; 

# cat $HOME/.bashrc|grep 
# printf %b "$PATH" > $PREFIX/.config/path;
# cat ~/.bashrc | grep -e '$HOME/.config/path' || printf %b '\n export PATH=$(cat ${HOME/.config/path}) \n' >> ~/.bashrc; 
# chmod 775 $PREFIX/.config/path; 
# cat $HOME/.config/path|grep "~/.local/bin" || \
# printf %b "${PATH}:~/.local/bin" >> $HOME/.config/path; 
fi; 
####
## crons
}; 
####
#### Authenticates github
_login_gh() {
p2 " $c2 "; p1 "Login to github? "; _yno gh; 
if [[ $_yno_gh == true ]]; then \
shgh=(gnupg gpg ssh openssl openssh-server gh git); 
for sigh in ${shgh[*]}; do printf %b "\b\b\b\b$sigh"; 
$sudo nohup apt install -y ${sigh} &>/dev/null; done; 
####
ghuser="$(id -nu)"; ghmail="$(id -nu)@$(hostname)"; 
gh_aeniks="$start/c/gpg/gh_aeniks.gpg"; 
####
gpg --pinentry-mode loopback -o "gh.txt" -d "$gh_aeniks"; 
gh auth login --with-token < "gh.txt"; printf "$c2 "; rm gh.txt; sleep .2;
gh auth status && \
printf %b "\e[60G      \e[8D  "; p2 "\e[0;1m [\e[0;92m"; p1 "OK"; p2 "\e[0;1m]  \e[0m\n"; sleep .2; 
git config --global user.name $ghuser; 
git config --global user.email $ghmail; 
git config --global init.defaultBranch main; 
# printf %b "\nHost *\nForwardAgent yes\n" >> $HOME/.ssh/config;

[ $(ls $HOME/.ssh/*.pub) ] || [ -r $HOME/.ssh/id_ed25519.pub ] || \
ssh-keygen -N '' -f $HOME/.ssh/id_ed25519; 
chmod 600 $HOME/.ssh/*; chmod 644 $HOME/.ssh/*.pub;

for ss in {ssh,openssl,openssh-server,gh,git} ; do 
hash $ss && echo $ss && break; _newcolor; $sudo apt install -y ${ss}; 
done; 
# [ -e $HOME/.ssh/id_ed25519.pub ] || ssh-keygen -N "" -f $HOME/.ssh/; 
gh config set git_protocol ssh; 
gh ssh-key add $HOME/.ssh/id_ed25519.pub; 
printf %b "\e[96m\u990 \e[0m"; 
ssh -T git@github.com; printf %b "\n"; 
####
# ssh-keygen -N "" -f ~/.ssh/ll_${USER}_${HOSTNAME}_ll; 
# gh ssh-key add ~/.ssh/*.pub; 
cd $start; 
git config remote.origin.url git@github.com:aeniks/start.git 2>/dev/null; cd -; 
# ssh -T git@github.com; 
fi; 
_link $PREFIX/var/spool/cron $HOME/ 2>/dev/null; 
}; 
####
#### Install apps?
_install_apps() {
p2 " $c2 "; p1 "Install apps? "; _yno in_apps
if [[ $_yno_in_apps == true ]]; then \
p2 " $c2 "; p1 "Updating system ..."; echo; echo; _newcolor; 
spin $sudo apt update; _newcolor; spin $sudo apt upgrade -y; _newcolor; echo; 
####
[ -e $HOME/logs/apa.log ] || $sudo apt list|grep -v "static"|cut -f1 -d"/" > $HOME/logs/apa_1.log; 
tail -n+1 $HOME/logs/apa_1.log|cut -f1 -d"/" > $HOME/logs/apa.log; 
####
apts_install=($(for i in ${apts_basic[*]}; do hash $i 2>/dev/null || \
grep $HOME/logs/apa.log -x -e "$i"; done; )); 
####
for i in ${apts_install[*]}; do 
hash $i 2>/dev/null && printf %b "\n$reSkipping $cyan $i$re already installed$green\n"; 
printf %b "\e[38;5;$((uu++))m\n"; 
hash $i 2>/dev/null || (printf %b "\nInstalling $i \e[0;1m"; p1 " ..."; 
printf %b "\n\e[0;2m"; )&& \
hash $i 2>/dev/null || $sudo apt install -y $i &>/dev/null; done; 
for i in {1..6}; do echo; sleep .2; done; 
printf %b "\e[0m\e[4A"; p1 Installation complete!; 
for i in {1..6}; do echo; sleep .2; done; 
fi; 
$sudo ln -s $PREFIX/usr/bin/batcat $PREFIX/usr/bin/bat 2>/dev/null; 
}; 
_apt_get_info() { 


local IFS=$'\n\t '; 
_newcolor; $sudo apt update &>/dev/null; $sudo apt install -y fzf grep &>/dev/null; $sudo apt install -y bat &>/dev/null; $sudo apt install -y batcat &>/dev/null; 

aapp=($(cd $HOME/start/config/apts 2>/dev/null; ls -p|grep -v "/")); 
p2 " $c2 "; p1 "Updating apts ... "; 
_newcolor; $sudo apt update &>/dev/null; 

for i in $((LINES / 2)); do printf %b "\n"; sleep .1; done; 
for i in $((LINES / 2)); do printf %b "\e[A"; sleep .1; done; 

ap="$HOME/logs/ap"; 
printf %b "\n\n\e[s"; 
mkdir -p -m 775 $apfolder 2>/dev/null; 
############
for i in ${aapp[*]}; do _newcolor; 
printf %b "\e[u $i"; 
$sudo apt show $i 2>/dev/null|grep -E 'Installed-Size|Description' -C2 > $ap/$i; 
[ $(wc -c --total=only $ap/$i 2>/dev/null) -lt 2 ] && rm $ap/$i 2>/dev/null; 
done; 
####
apppp=($(cd $HOME/logs/ap 2>/dev/null; fzf --preview "bat -ppfld {}" --height "~100%" --ansi --marker "@" --header '[q]uit  [c-a]select-all [alt-a]toggle-all  [tab]select  [enter] - done  ' --style "minimal" --preview-window "66%,<22(top,12)" --bind "ctrl-a:select-all,alt-a:toggle-all" --inline-info --highlight-line;)); 

p2 " $c2 "; p1 "Install choosen apts? "; _yno apppp; 
if [[ $_yno_apppp == true ]]; then 
for i in ${apppp[*]}; do _newcolor; printf %b "\t$i\n\e[A"; $sudo apt install -y $i &>/dev/null; done; 
fi; 
printf %b "\n\n -- gg\n\n"; 
reset; exec bash; 
# printf %b "\n \e[96m--\e[0m DONE\n"; 
# [ wc -c --total=only $HOME/logs/apts_basic/$i; ]
# cat $HOME/logs/apts/_$i 2>/dev/null|cut -f2- -d" " > $HOME/logs/apts_basic/$i; 

# [ $(wc -l $HOME/logs/apts_basic/_$i|cut -b1-2) -eq 0 ] 2>/dev/null && rm $HOME/logs/apts_basic/$i; 
# rm $HOME/logs/apts_basic/_*; 

}; 
####
####
_quit() { printf %b ""; return 0; }; 
_be_sudo; [[ $ny = q ]] && _quit && return 0; 
_update; [[ $ny = q ]] && _quit && return 0; 
# _aapts; [[ $ny = q ]] && _quit && return 0; 
# _apt_installer; [[ $ny = q ]] && _quit && return 0; 
_download; [[ $ny = q ]] && _quit && return 0; 
_install_conf; [[ $ny = q ]] && _quit && return 0; 
_login_gh; [[ $ny = q ]] && _quit && return 0; 
_apt_get_info; [[ $ny = q ]] && _quit && return 0; 
# _install_apps; [[ $ny = q ]] && _quit && return 0; 
echo; . $start/anew.sh; 
}; 

instart 
