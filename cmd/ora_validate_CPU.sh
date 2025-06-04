echo -n ""CPU": {"
lscpu | awk -F ":" '{printf "#"$1"#: #"$2"#,"}' | sed "s/#/\"/g" | sort | sed "s/\"\ */\"/g" | sed 's/,$/},/g'
lscpu | sort | awk -F ":" '{print ".\"Server\".\"CPU\".\""$1"\""}' >> "ora_validate_compare_objects.conf"