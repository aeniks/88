memram() { 
local IFS=$'\n\t '; 
printf %b "\e[98;2mmem: \e[0m"; (free -h|rg -v "total"|tr -s " " " "|cut -f 2 -d" "|sed -e s/\:\ /\:/g -e s/i\ /mem\(/g -e s/i//g|tr -s "\n" "\t\t"; printf %b "\n";)|column --table --output-separator " + "|bat -ppflc --theme zenburn; }; 
# free -h|rg -v "total"|tr -s " " " "|cut -f -3,4,7 -d" "|sed -e 0s/\ /memory\ / -e 1s/Mem/ram/ -e s/S/s/ -e s/i//g|column --table --output-separator " | "|bat -ppflc --theme zenburn; 

