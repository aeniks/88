dfree() { 
local IFS=$'\n\t '; 
if [ $PREFIX ]; 
then df=($(df -h|rg -e "sdcard/default|storage|Size"|tr -s " " " "|cut -f2-6 -d" ")); 
else df=($(df -h|rg -v "tmpfs|\*tmpfs|9p|fonts|none|run| 0 "|tr -s " " " "|cut -f2-6 -d" ")); 
fi; 
plup='■'; 
aa=0; kk=0; a=0; dflines="$((${#df[*]} / 5))"; 
dk=(028 114 151 152 247 143 220 209 200 196); 
#####
#####
for i in ${df[*]}; do \
for a in {4,0,2,1,3}; do \
disk="$(printf %b "${df[((a+aa))]}")"; 
[ ${disk} ] && printf %b "${disk} "|bat -ppfljs;  
((kk++)); done; 
# | bat -ppfljava --theme DarkNeon; 
##
[ $((kk / 5 - 1)) -lt $dflines ] && [ $aa -gt 0 ] && (sa="${df[((a+aa))]}"; 
as=${sa:0:1}; ## percent in number
####
# printf %b " "; 
# printf %b "\e[37;2m"; 
# for p in {0..9}; do printf %b "$plup"; done; printf %b "\e[0m\e[10D"; 
# for i in {0..9}; do printf %b "\e[37;2m▇\e[0m"; done; 
# printf %b "\e[12D "; 
printf %b "\e[2m■■■■■■■■■■\e[0m\e[10D"; 
for i in $(seq $as); do 
printf %b "\e[38;5;${dk[as]}m${plup}\e[0m"; 
done; ); 
####
aa=$kk; printf %b "\n"; done | 
column --separator=" " --table --table-columns-limit 6 \
--output-separator "$(printf %b "\e[37;2m | \e[0m")";
# | bat -ppfljava; 
}; 


