v_agent=$(grep ^agent /etc/oratab  | head -n1 | awk -F ":" '{print $1}') > /dev/null
[ "$v_agent" == "" ] && exit 0
export ORACLE_SID="${v_agent}"
export ORAENV_ASK=NO
. oraenv > /dev/null
export ORAENV_ASK=YES
#. oraenv <<< $(grep ^agent /etc/oratab  | head -n1 | awk -F ":" '{print $1}')  > /tmp/aalu
$ORACLE_HOME/bin/emctl status agent | egrep -w 'Agent Version|OMS Version|Protocol Version|Agent Home|Agent Log Directory|Agent Binaries|Core JAR Location|Agent URL|Repository URL|Started by user|Operating System|Number of Targets' | awk -F ": " '{print "#"$1"#:#"$2"#,"}' | sort | sed 's/ *#/#/g' | sed 's/#/\"/g'
arr_key=( "Agent Version" "OMS Version" "Protocol Version" "Agent Home" "Agent Log Directory" "Agent Binaries" "Core JAR Location" "Agent URL" "Repository URL" "Started by user" "Operating System" "Number of Targets" )
for v_key in "${arr_key[@]}"
do
    echo ".\"OEM AGENT\".\"${v_key}\"" >> "ora_validate_compare_objects.conf"