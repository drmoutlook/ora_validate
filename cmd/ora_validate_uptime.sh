echo -n "\"Date\": \"$(date)\","
uptime | sed "s/,//g" | awk '{print "#Uptime#:#"$3" "$4", "$5" "$6"#,"}'| sed 's/#/"/g'