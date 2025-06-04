#!/bin/bash

# Author        : Dilli Maharjan (maharjan@pythian.com)
# Date          : 2024-01-25
# Description   : Script to validate oracle database service before 
#                 maintenance (Patching) and after the maintenance
#                 completes.



DEBUG=0
HOSTNAME=$(hostname -f)
HOSTNAME_S=$(hostname -s)
WORKING_DIR="$(pwd)"
LOG_DIR="${WORKING_DIR}/logs/${HOSTNAME_S}"
JSON_DIR="${WORKING_DIR}/json/${HOSTNAME_S}"
BACKUP_DIR="${WORKING_DIR}/backup/${HOSTNAME_S}"
CMD_DIR="${WORKING_DIR}/cmd"
LOG_FILE="${LOG_DIR}/oracle_validate_${HOSTNAME}_$(date +%Y%m%d%H%M).log"
OUT_FILE="${LOG_DIR}/oracle_validate_${HOSTNAME}_$(date +%Y%m%d%H%M).out"
LOG=1
SECOND1=$(date +%s)
V_COMPARE=0
V_COMPARE_FILE=""

v_db_version=1


# Read and execute commands from conf file for configurations and lib file for the functions.
source ${WORKING_DIR}/ora_validate.conf
source ${WORKING_DIR}/ora_validate.lib

# Check if the first parameter is compare
if [ "$1" == "compare" ]; then
    V_COMPARE=1
    V_COMPARE_FILE="$2"
    if [ "$V_COMPARE_FILE" == "" ] || [ ! -e "$V_COMPARE_FILE" ]; then
        fn_logMe "Missing or invalid compare file, Please provide the json file to compare" "ERR"
        exit 1 
    fi
fi


# Read if any option is defined in the command line
while getopts ":hd" option; do
   case "$option" in
      h) # display Help
        fn_usage
        ;;
      d) # enable debug mode
        DEBUG=1;;
     \?) # Invalid option
        echo "Error: Invalid option"
        fn_usage
        exit ;;
   esac
done

# Create all required directories
for DIR in "${LOG_DIR}" "${JSON_DIR}" "${BACKUP_DIR}"
do
	if [ ! -e ${DIR} ]; then
    	mkdir -p ${DIR}
    	if [ "$?" -eq 0 ]; then
        	fn_logMe "DIRECTORY: ${DIR} doesnot exists, created" "DEBUG"
    	else
        	fn_logMe "Failed to create ${DIR}, Terminating the process" "DEBUG"
        	exit 1
    	fi
	fi
done


fn_logMe "Oracle Service Validation check started at $(date)." "INFO"
echo -e "\e[96m${v_sidebar}"
fn_display_info "Oracle Service Validation Summary"
fn_copy_template
fn_gen_hostname
fn_gen_date_uptime
fn_gen_kernel_release
fn_gen_memory
fn_gen_CPU
fn_gen_networks
fn_gen_disks
#fn_gen_cluster
fn_gen_database
fn_gen_listener
#fn_gen_oem_agent
fn_gen_patches
fn_display_info "Json file: ${v_json_file}"
echo -e "${v_sidebar}\e[0m"
[ $V_COMPARE -eq 1 ] && fn_compare_json_files "${V_COMPARE_FILE}"
echo -e "\e[96m${v_sidebar}"
fn_display_info "Oracle Service Validation check Completed at $(date), Elapsed time $(($(date +%s)-${SECOND1})) seconds."
echo -e "${v_sidebar}\e[0m"
#cat ${v_json_file}
