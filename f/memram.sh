memram() { free -h|tr -s " " " "|cut -f -3,4,7 -d" "|sed -e 1s/\ /memory\ / -e 2s/Mem/ram/ -e s/S/s/ -e s/i//g|column --table --output-separator " | "|bat -ppflc --theme zenburn; }; 
