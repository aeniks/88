ll=($(timeout 6 termux-location|tr -d '""}{[:alpha:],: ';)); 
[ "$ll" ] && (printf %b "\n--------\n"; date +%c; printf %b "--------\n"; 
curl -sL "https://api.geoapify.com/v1/geocode/reverse?lat=${ll}&lon=${ll[1]}&lang=en&limit=1&format=json&apiKey=ab9bd0f92c7f48b49bf3ba01492b7d08"|jq --indent 0|grep -e "formatted"|cut -f4 -d'"'; printf %b "--------\n\n"; ) \
>> ~/logs/place.log || (
printf %b "\n------\n$(date +%c; ) -- nope\n------\n\n"; ) >> ~/logs/place.log; 
