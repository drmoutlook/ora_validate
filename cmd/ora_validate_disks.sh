echo -n "\"Disks\":["
mount | egrep -vw 'autofs|tmpfs|cgroup|debugfs|sysfs|proc|devtmpfs|mqueue|securityfs|devpts|hugetlbfs|fusectl|configfs|rpc_pipefs|tracefs|pstore|bpf' |sort | awk '{printf "{#Device#: #"$1"#, #Mount#: #"$3"#, #Type#: #"$5"#}," }' | sed 's/#/\"/g' | sed 's/,$/],/g'
echo ".\"Server\".\"Disks\"[].\"Device\"" >> "ora_validate_compare_objects.conf"