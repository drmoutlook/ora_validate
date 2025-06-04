arr_interfaces=( $(ls /sys/class/net/ | grep -v virb) )
arr_intefaces_length=${#arr_interfaces[@]}
echo "\"Network\":["
for (( j=0; j<${arr_intefaces_length}; j++ ))
do 
    echo "{\"Device\":\"${arr_interfaces[$j]}\","
    #ifconfig "${arr_interfaces[$j]}" | grep -w inet | awk '{print "\"IP\":\""$2"\",\"Netmask\":\""$4"\","}'
    nmcli device show "${arr_interfaces[$j]}" | grep -w IP4.ADDRESS | awk '{print "\"IP\":\""$2"\","}'
    #ifconfig "${arr_interfaces[$j]}" | grep -w mtu | awk '{print "\"MTU\":\""$NF"\"}"}'
    nmcli device show "${arr_interfaces[$j]}" | grep -w MTU | awk '{print "\"MTU\":\""$NF"\"}"}'
    [ $(($arr_intefaces_length-$j)) -gt 1 ] && echo ","
done
echo "]"
echo ".\"Server\".\"Network\"[]" >> "ora_validate_compare_objects.conf"