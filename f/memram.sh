#!/bin/bash
memram() { local IFS=$'\n\t '; ( free -h | rg -v "total" | tr -s " " " " | cut -f 2,3 -d" " | sed -e s/i\ /\ \(/g -e "s/i/\)\t/" | tr "\n\t" " "); printf %b "\b\b"; }; 


# memram() { 
# local IFS=$'\n\t '; 
# printf %b "["; 
# (free -h|rg -v "total"|tr -s " " " "|cut -f 2,3 -d" "|sed -e s/\:\ /\:/g -e s/i\ /\(/g -e "s/i/\)/"|tr -s "\n" " "; 
# printf %b "\b]\n";)|column --table --table-columns-limit 2 --output-separator "+("; }; 
# free -h|rg -v "total"|tr -s " " " "|cut -f -3,4,7 -d" "|sed -e 0s/\ /memory\ / -e 1s/Mem/ram/ -e s/S/s/ -e s/i//g|column --table --output-separator " | "|bat -ppflc --theme zenburn; 
