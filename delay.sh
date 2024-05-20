var1=$(uptime -s | awk -F":" {'print ($2 % 10) * 60 + $3'})
sleep $var1
