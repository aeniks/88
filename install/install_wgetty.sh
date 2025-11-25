#!/bin/bash
## install ssl; 
####
sudo apt update; 
sudo apt install -y build-essential curl python; 
####
curl -sL https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash && source ~/.profile; 
nvm install 20; 
####
mkdir ~/.ssl 2>/dev/null; 
####
openssl req -x509 -nodes -days 1095 -newkey ec:<(openssl ecparam -name secp384r1) -subj "/C=GB/ST=None/L=None/O=None/OU=None/CN=None" -out ~/.ssl/wetty.crt -keyout ~/.ssl/wetty.key; 
####
chmod 700 ~/.ssl; 
chmod 644 ~/.ssl/wetty.crt; 
chmod 600 ~/.ssl/wetty.key; 
####
ssh-keygen -q -C "wetty-keyfile" -t ed25519 -N '' -f ~/.ssh/wetty 2>/dev/null <<< y >/dev/null
####
cat ~/.ssh/wetty.pub >> ~/.ssh/authorized_keys
####
chmod 700 ~/.ssh; 
chmod 644 ~/.ssh/authorized_keys; 
chmod 600 ~/.ssh/wetty; 
####
mkdir ~/bin 2>/dev/null && source ~/.profile; 
####
npm -g i wetty --prefix ~/; 
printf %b "\ndone\n"; 
####


