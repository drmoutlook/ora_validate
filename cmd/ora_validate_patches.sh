. oraenv <<< $(ps -ef | grep pmon | grep -v grep | awk -F "_" '{print $NF}'| head -n1) > /dev/null
$ORACLE_HOME/OPatch/opatch lspatches | egrep -v "^$|OPatch succeeded."  | sort | awk -F ";" '{if($2==""){printf "{#"$1"#: #NA#},"}else {printf "{#"$1"#: #"$2"#},"}}' | sed 's/\"//g' | sed 's/#/\"/g' | sed 's/,$//g'
echo ".\"Patches\"[]" >> "ora_validate_compare_objects.conf"