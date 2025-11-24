
##
wol="$HOME/logs/words/wordlog"
wob="$HOME/logs/words/wordlog/wobrit_$(date +%y%m%d)"; 

##
lynx -nomargins -nonumbers -nolist -width 800 -justify -dump "https://www.britannica.com/dictionary/eb/word-of-the-day"|grep -e '(BUTTON)' -A20 > $wob.log; 
##
##
wobb="$(sed -n 7p $wob.log)"; 
echo; 
echo "--------"; 
sed -n 7p $wob.log|tee $wob.sh; 
sed -n 9p $wob.log|tee -a $wob.sh; 
##
(printf %b "[ $(sed -n 8p $wob.log|tr -d "\n/") ]\n")|tee -a $wob.sh; 
##
echo -e "----"; 
grep -e "count" -A2 $wob.log \
| tr -s "\n " " " \
| sed -e "s/\[count\]\ \:\ //g" \
| tee -a $wob.sh; 
mv $wob.sh ${wol}/$wobb.log; 
mv $wob.log -t $HOME/logs/words/tmp; 
echo; echo "--------"; 
echo; 
##
##
