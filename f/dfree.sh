dfree() { 
local IFS=$'\n\t '; 
[ $PREFIX ] && df=($(df -h|grep -E "sdcard/default|storage|Size"|tr -s " " " "|cut -f2-6 -d" ")); 
[ -z $PREFIX ] && df=($(df -h|grep -vE "tmpfs"|tr -s " " " "|cut -f2-6 -d" ")); 
aa=0; kk=0; dflines="$((${#df[*]} / 5))"; 
for i in ${df[*]}; do for a in {4,0,1,2,3}; 
do p=$(printf %b "${df[((a+aa))]} "); 
[ $p ] && printf %b "${p}"|tail -c 25|bat -ppfljava --theme DarkNeon; 
((kk++)); done; 
[ $((kk / 5 - 1)) -lt $dflines ] && [ $aa -gt 0 ] && (sa="${df[((a+aa))]}"; 
as=${sa:0:1}; 
case $as in 
0) oc=28;; 
1) oc=64;; 
2) oc=68;; 
3) oc=100;; 
4) oc=94;; 
5) oc=130;; 
6) oc=160;; 
7) oc=166;; 
8) oc=196;; 
9) oc=9;; 
esac; 
printf %b " \e[90m\u25ac\e[10b\e[12D \e[38;5;${oc}m\u25ac\e[${as}b\e[0m"; ); 
aa=$kk; printf %b "\n"; 
done|column --table --table-columns-limit 5 --output-separator " | "; 

}; 
