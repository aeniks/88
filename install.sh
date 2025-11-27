#!/bin/bash
## installer 
install88() {
hash sudo 2>/dev/null && sudo="sudo"; hash sudo 2>/dev/null || alias sudo=' ';
[ "$PREFIX" ] && unset sudo; [ $UID = 0 ] && unset sudo && unalias sudo; 
mkdir $HOME/{tmp,logs,gh,backup,.config} 2>/dev/null; 
export tmp=$HOME/tmp time=$(date +%y%m%d%H%m%S) bu=$HOME/backup; 
#####
local IFS=$' \n\t' start=$HOME/88 green='\e[32m' dim='\e[2m' re='\e[0m' red='\e[31m' cyan='\e[36m' yellow='\e[33m' blue='\e[36m' bold='\e[1m' height="$(stty size|cut -f1 -d" ")" width="$(stty size|cut -f2 -d" ")" yno='\e[0m[\e[2mY\e[0m/\e[2mn\e[0m]' c2='\e[0m\e[36m--\e[0m' uu="60" enter='\e[\e[0m [\e[2mENTER\e[0m] to accept or [\e[2mq\e[0m]\e[2mto Quit \e[0m' x="2>/dev/null"; 
#####
# unalias p1 p2 2>/dev/null; 
# p1() { p2=" ${@}"; for i in $(seq ${#p2}); do sleep .04; printf %b "${p2:${i}:1}"; done; }; p2() { printf %b "$@"; }; 
####
_quit() { [[ "$ny" = "q" ]] && printf %b "\n\n\e[2A" && return 2; }; 
####
p1() { p2=" ${@}"; for i in $(seq ${#p2}); do sleep .04; printf %b "${p2:${i}:1}"; done; }; ## rolling text 
p2() { printf %b "$@"; }; 
####
_link() { ln -s $@ 2>/dev/null; }; 
########
_newcolor() { printf %b "\e[38;5;$((uu++))m"; sleep .02; }; 
########
_backup() { mv -fb --suffix="$time" $@ -t $bu &>/dev/null; }; 
_yno() { _ok() { printf %b "\e[40G     \e[8D  "; p2 "\e[0;1m [\e[0;92m"; p1 "OK"; p2 "\e[0;1m]  \e[0m\n"; }; yno='\e[0m[\e[2mY\e[0m/\e[2mn\e[0m]'; [ "$1" ]&& ny=${1}; printf %b "\e[?25h\e[40G\b\b\b\b\b\b\b\b$yno "; 
printf -v _yno_${1} "false"; read -rsn1 ny; 
[[ -z $ny || $ny = y ]] && printf -v _yno_${1} "true"; 
[[ $ny = q ]] && printf %b "\e[?25h\nqok\n" && _quit && exit 0; _ok; 
[[ $ny = q ]] && printf %b "\e[?25h\nok\n" && _quit && return 2; }; 
########
for i in $(seq $((height / 2))); do printf %b "\e[38;5;$((RANDOM%16 + 111))m$i\n"; sleep .01; done; for i in $(seq $((height / 2 - 5))); do printf %b "\e[K\e[A\e[2K"; sleep .02; done; printf %b "\e[?25l"; 






_prompt() { [[ "$ny" = "q" ]] && return 1; p2 " $c2 "; p1 "$@"; _yno prompt; if [[ $_yno_prompt == true ]]; then _newcolor; else return 1; fi; }; 

####
_prompt "update system? " && ($sudo apt update && $sudo apt upgrade -y); 
####

_prompt "install basic apps? " && (echo ok; for i in $(ls -1 $HOME/88/install/ap); do rr="$((RANDOM%222))";  printf %b "\ec\e[0m -- \e[48;5;${rr}m ${i} \e[0m --\n\e[38;5;${rr}m "; $sudo apt install -y $i; done; printf %b "\n\n\e[0m -- \e[48;5;196m DONE \e[0m --\n\n"; ) || echo no; 

_prompt "download config-files? " && (p2 " $c2 "; p1 "where to? "; 
read -ei "$HOME/" "hstart"; start="${hstart}/88"; sleep .2; 
export start="${start/\/\///}"; 
_backup "$start"; _newcolor; 
git clone https://github.com/aeniks/88.git $start &>/dev/null; 
cd "$start"; git config remote.origin.url git@github.com:aeniks/88.git) || echo no; 
####
_prompt "install config-files? " && (
####
_backup $HOME/.inputrc; _newcolor; 
_link $start/c/inputrc $HOME/.inputrc; _newcolor; 
####
conf=(micro newsboat bat lf tmux htop glow aichat ranger); 
for q in ${conf[*]}; do 
mkdir -p $HOME/.config/$q 2>/dev/null; 
_backup $HOME/.config/$q/*; _newcolor; 
ln -s $start/c/$q/* -t $HOME/.config/$q/ 2>/dev/null; sleep .2; 
printf %b "\n\e[0m"; p1 "updated"; _newcolor; printf %b " $q"; 
done; echo; cd; _newcolor; 
printf %b "${PATH}:${HOME}/.local/bin" > $HOME/.config/path.sh; chmod 775 $HOME/.config/path.sh; _newcolor; 
####
printf %b "\n -- added "PATH" to ~/.config/path.sh \n\n "; _newcolor; 
##########
); 
####
_prompt "login to github(aeniks) ? " && (
####
ghuser="$(id -nu)"; ghmail="$(id -nu)@$(hostname)"; gh_aeniks="$start/c/gpg/gh_aeniks.gpg"; 
####
for ss in {ssh,openssl,openssh-server,gh,git} ; do hash $ss && echo $ss && break; _newcolor; $sudo apt install -y ${ss}; done; 
####
printf %b "\n\n\e[A\e[96m -- \e[0m"; 
gpg --pinentry-mode loopback -o "gh.txt" -d "$gh_aeniks"; 
gh auth login --with-token < "gh.txt"; printf "$c2 "; rm gh.txt; sleep .2;
gh auth status && printf %b "\e[60G      \e[8D  "; p2 "\e[0;1m [\e[0;92m"; p1 "OK"; p2 "\e[0;1m]  \e[0m\n"; 
git config --global user.name $ghuser; git config --global user.email $ghmail; git config --global init.defaultBranch main; 
####
[ $(ls $HOME/.ssh/*.pub) ] || [ -r $HOME/.ssh/id_ed25519.pub ] || ssh-keygen -N '' -f $HOME/.ssh/id_ed25519; chmod 600 $HOME/.ssh/*; chmod 644 $HOME/.ssh/*.pub;
####
gh config set git_protocol ssh; gh ssh-key add $HOME/.ssh/id_ed25519.pub; 
printf %b "\e[96m\u990 \e[0m"; ssh -T git@github.com; printf %b "\n"; 
####
cd $start; git config remote.origin.url git@github.com:aeniks/88.git 2>/dev/null; cd -; 
####
); 



}; 

install88; 
#!/bin/bash
## install tmux

# file
# mediainfo
# bat
# batcat
# ncdu

####
## apt install -y autoconf libevent ncurses pkg-config automake; 
## mkdir $HOME/gh 2>/dev/null; cd $HOME/gh; gh repo clone tmux/tmux
####
