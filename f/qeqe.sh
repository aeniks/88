
qeqe() { [ -z $1 ] && (printf %b "\n\n\n\n\e[4A\n"; read -rep ' -- search: ' 'qe'; )||qe="$@"; printf %b "\n${qe[*]}"; type $qe &>/dev/null && (printf %b " is \e[92mINSTALLED\e[0m\n"; type $qe;) || printf %b " - not installed\n----\n"; $sudo apt show $qe 2>/dev/null|grep -E 'Installed|Description'|cut -f2- -d"-"; printf %b "\n\n"; whatis $qe; printf %b "\n"; } 
