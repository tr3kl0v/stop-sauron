#!/bin/sh

[[ $EUID == 0 ]] || {
    echo "Must be run as root."
    exit
}

#------------------------#
# imports
#------------------------#
. configuration.sh
. shared.sh
. init.sh


#------------------------#
# Check flags before doing anyhing else
#------------------------#
debugFlag='false'

while getopts 'x' flag; do
    case "${flag}" in
        x) 
            debugFlag='true' ;;
        *) 
            printGetOptsMenuUsage
        exit 1 ;;
    esac
done

#------------------------#
# Check processes before menu
#------------------------#
prepare;

writeLog "[Session] - Start"
writeLog "[User] - ID --> $SUDO_USER"
writeLog "[User] - Mode --> $LOCAL_USER"

# get greeting
greeting;
writeEcho "Stop Sauron's eye version: ${VERSION}"
writeEcho "${greet} '$SUDO_USER'. What do you have in mind for today?"
 

#------------------------#
# Options menu
#------------------------#
PS3='Please enter your choice: '
options=("Disable" "Enable" "Abort" "Clean logfiles")
select opt in "${options[@]}"; do
    case $opt in
    "Disable")
        writeLog "[Select] - 1 --> Disable"
        writeEcho "You have chosen to disable 'Sauron' and its minions!"
        writeEcho "Processing..."
        ACTION="disable"
        LOADER="unload"
        break
        ;;
    "Enable")
        writeLog "[Select] - 2 --> Enable"
        writeEcho "You have chosen to enable 'Sauron' and its minions!"
        writeEcho "Processing..."
        ACTION="enable"
        LOADER="load"
        break
        ;;
    "Abort")
        writeLog "[Select] - 3 --> Abort"
        writeEcho "Bye!"
        writeLog "[Session] - End"
        writeLog "-------------------"
        exit
        break
        ;;
    "Clean logfiles")
        writeLog "[Select] - 4 --> Clean logfiles"        
        writeEcho "Removing the evidence..."
        deleteLogfiles;
        writeEcho "Done!"
        writeEcho "Bye!"
        exit
        break
        ;;
    *) echo "invalid option $REPLY" ;;
    esac
done



#------------------------#
# The execution
#------------------------#
theExecution() {
    writeLog "[exec] - Start --> The execution"

    arrayAgentsfromBackup=()
    arrayDeamonsfromBackup=()
    COUNTER=0

    # get Agents from backup file
    while IFS= read -r line; do
        if [[ $COUNTER > 0 ]]; then
            arrayAgentsfromBackup+=("$line");
        fi
        let COUNTER++
    done <$PLIST_AGENT_BACKUP
    
    writeLog "[exec] - Array check --> Plist Agent Array from backup file --> size: ${#arrayAgentsfromBackup[@]}"

    # reset counter
    COUNTER=0
    # get Deamons from backup file
    while IFS= read -r line; do
        if [[ $COUNTER > 0 ]]; then
            arrayDeamonsfromBackup+=("$line");
        fi
        let COUNTER++
    done <$PLIST_DEAMON_BACKUP
    
    writeLog "[exec] - Array check --> Plist Deamons Array from backup file --> size: ${#arrayDeamonsfromBackup[@]}"

    # enable
    if [[ $ACTION == "enable" ]]; then
        writeLog "[exec] - $ACTION"

        writeLog "[exec] - Start --> $ACTION Deamons"
        for e in ${arrayDeamonsfromBackup[@]}; do
            # Check if deamons are already running
            # Get path
            dirname="${e%/*}"

            # Get last folder
            basename="${dirname##*/}"

            # Strip path from filename
            filename="$(basename -- $e)"
            
            # Get filename without extension
            filename="${filename%.*}"

            # Get deamon PID
            PROCESS="$(ps -Ac | /bin/launchctl list | grep -m1 "$filename" | awk '{print $1}')"
                
            # Check if process is a number
            if isNumber; then
                writeLog "[exex] - $e --> already running  --> $PROCESS --> skip"
            else
                # take action
                writeLog "[exec] --> $ACTION --> $e"
                /bin/launchctl $LOADER -w $e
            fi
        done
        writeLog "[exec] - Resolved --> $ACTION Deamons"

        writeLog "[exec] - Start --> $ACTION Agents"
        for d in ${arrayAgentsfromBackup[@]}; do
            # Check if agents are already running
            # Get path
            dirname="${d%/*}"

            # Get last folder
            basename="${dirname##*/}"

            # Strip path from filename
            filename="$(basename -- $d)"
            
            # Get filename without extension
            filename="${filename%.*}"

            # Get agent PID
            var1=$(su - $SUDO_USER -c "ps -A | /bin/launchctl list | grep -m1 $filename")
            PROCESS=$(echo $var1 | awk '{print $1}')
                
            # Check if process is a number
            if isNumber; then
                writeLog "[exex] - $d --> already running  --> $PROCESS --> skip"
            else
                # take action
                writeLog "[exec] --> $ACTION --> $d"
                su - $SUDO_USER -c "/bin/launchctl $LOADER -w $d"
            fi
        done
        writeLog "[exec] - Resolved --> $ACTION Agents"

    # disable
    else
        writeLog "[exec] - Disable"

        writeLog "[exec] - Start --> $ACTION Deamons"
        for g in ${arrayDeamonsfromBackup[@]}; do
            writeLog "[exec] --> $ACTION --> $g"
            /bin/launchctl $LOADER -w $g
        done
        writeLog "[exec] - Resolved --> $ACTION Deamons"

        writeLog "[exec] - Start --> $ACTION Agents"
        for h in ${arrayAgentsfromBackup[@]}; do
            writeLog "[exec] --> $ACTION --> $h"
            su - $SUDO_USER -c "/bin/launchctl $LOADER -w $h"
        done
        writeLog "[exec] - Resolved --> $ACTION Agents"

    fi

    writeLog "[exec] - Resolved --> The execution"
}

#------------------------#
# Start the Execution
#------------------------#
theExecution;



#------------------------#
# Teminating messages
#------------------------#
writeEcho "Finished."
writeEcho "Please wait 30 seconds to let all Agents & Deamons finish the $LOADER!"
writeEcho "Bye!"
writeLog "[Session] - End"
writeLog "-------------------"