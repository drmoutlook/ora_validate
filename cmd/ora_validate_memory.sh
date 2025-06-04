echo -n ""Memory": {"
cat /proc/meminfo | egrep 'MemTotal|SwapTotal|HugePages_Total|AnonHugePages' | sort | awk -F ":" '{printf "#"$1"#: #"$2"#,"}' | sed "s/#/\"/g" | sed "s/\"\ */\"/g" | sed 's/,$/},/g'
cat /proc/meminfo | egrep 'MemTotal|SwapTotal|HugePages_Total|AnonHugePages' | sort | awk -F ":" '{print ".\"Server\".\"Memory\".\""$1"\""}' >> "ora_validate_compare_objects.conf"