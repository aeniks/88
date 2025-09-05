dfree() { 
local IFS=$'\n\t '; 
dk=(028 114 151 152 247 143 220 209 200 196); [ $PREFIX ] && \
df=($(df -h|grep -E "sdcard/default|storage|Size"|tr -s " " " "|cut -f2-6 -d" ")) || \
df=($(df -h|grep -vE "tmpfs|\*tmpfs|9p|fonts|none|run| 0 "|tr -s " " " "|cut -f2-6 -d" ")); 
aa=0; kk=0; dflines="$((${#df[*]} / 5))"; 
#####
#####
for i in ${df[*]}; do \
for a in {4,0,1,2,3}; do \
disk=$(printf %b "${df[((a+aa))]} "); [ $disk ] && printf %b "${disk}"\
|bat -ppfljava --theme DarkNeon; ((kk++)); done; 
##
[ $((kk / 5 - 1)) -lt $dflines ] && [ $aa -gt 0 ] && (sa="${df[((a+aa))]}"; 
as=${sa:0:1}; 
case $as in 
0) oc=28;; 
1) oc=64;; 
2) oc=68;; 
3) oc=78;; 
4) oc=80;; 
5) oc=98;; 
6) oc=6;; 
7) oc=162;; 
8) oc=196;; 
9) oc=9;; 
esac; 
####
# printf %b " "; 
printf %b " \e[37;2m▇\e[${as}b\e[0m\e[12D "; 
# for i in {0..9}; do printf %b "\e[37;2m▇\e[0m"; done; 
# printf %b "\e[12D "; 
for i in $(seq $as); 
do printf %b "\e[38;5;${dk[i]}m▇\e[0m"; 
done; ); 
####
#### printf %b " \e[90m#\e[10b\e[12D \e[38;5;${oc}m#\e[${as}b$\e[0m"; );
####
# \u2587
aa=$kk; printf %b "\n"; 
done|column --table --table-columns-limit 6 --output-separator " | "; 
}; 
