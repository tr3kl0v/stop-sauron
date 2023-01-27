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

#------------------------#
# Greetings
#------------------------#
greeting;

writeEcho "Stop Sauron's eye version: ${VERSION}"
writeEcho "${greet} '$SUDO_USER'. What do you have in mind for today?"
echo ""
 

#------------------------#
# Options menu
#------------------------#
PS3='Please enter your choice: '
options=("Stop Sauron's eye" "Start Sauron's eye" "Clean the logs" "Remove the config" "Create lifesaver" "Exit")
COLUMNS=20
select opt in "${options[@]}"; do
    case $opt in
    "Stop Sauron's eye")
        writeLog "[Select] - 1 --> Disable"
        writeEcho "You have chosen to disable 'Sauron' and its minions!"
        writeEcho "Processing..."
        ACTION="disable"
        LOADER="unload"
        break
        ;;
    "Start Sauron's eye")
        writeLog "[Select] - 2 --> Enable"
        writeEcho "You have chosen to enable 'Sauron' and its minions!"
        writeEcho "Processing..."
        ACTION="enable"
        LOADER="load"
        break
        ;;
    "Clean the logs")
        writeLog "[Select] - 3 --> Clean the logs"
        writeEcho "Removing the evidence..."
        deleteLogfiles;
        writeEcho "Done!"
        writeEcho "Bye!"
        exit;
        break
        ;;
    "Remove the config")
        writeLog "[Select] - 4 --> Remove the config"
        writeEcho "Starting Sauron's eye to prevent trouble (back to the original state)..."
        ACTION="enable"
        LOADER="load"
        writeEcho "Removing the configuration"
        RESET_CONFIG="true"
        writeEcho "Done!"
        writeEcho "Bye!"
        break
        ;;
    "Create lifesaver")
        writeLog "[Select] - 5 --> Create lifesaver"
        writeEcho "Securing your original configuration in case of the unexpected"
        createBackupfiles;
        writeEcho "Done!"
        writeEcho "Bye!"
        exit
        break
        ;;
    "Exit")
        writeLog "[Select] - 6 --> Exit"
        writeEcho "Bye!"
        writeLog "[Session] - End"
        writeLog "-------------------"
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

    arrayAgentsfromConfig=()
    arrayDeamonsfromConfig=()
    COUNTER=0

    # get Agents from config file
    while IFS= read -r line; do
        if [[ $COUNTER > 0 ]]; then
            arrayAgentsfromConfig+=("$line");
        fi
        let COUNTER++
    done <$PLIST_AGENT_CONF
    
    writeLog "[exec] - Array check --> Plist Agent Array from config file --> size: ${#arrayAgentsfromConfig[@]}"

    # reset counter
    COUNTER=0
    # get Deamons from config file
    while IFS= read -r line; do
        if [[ $COUNTER > 0 ]]; then
            arrayDeamonsfromConfig+=("$line");
        fi
        let COUNTER++
    done <$PLIST_DEAMON_CONF
    
    writeLog "[exec] - Array check --> Plist Deamons Array from config file --> size: ${#arrayDeamonsfromConfig[@]}"

    # enable
    if [[ $ACTION == "enable" ]]; then
        writeLog "[exec] - $ACTION"

        writeLog "[exec] - Start --> $ACTION Deamons"
        for e in ${arrayDeamonsfromConfig[@]}; do
            # Check if deamons are already running

            # Get filename
            getFileName $e

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
        for d in ${arrayAgentsfromConfig[@]}; do
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
        for g in ${arrayDeamonsfromConfig[@]}; do
            writeLog "[exec] --> $ACTION --> $g"
            /bin/launchctl $LOADER -w $g
        done
        writeLog "[exec] - Resolved --> $ACTION Deamons"

        writeLog "[exec] - Start --> $ACTION Agents"
        for h in ${arrayAgentsfromConfig[@]}; do
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

if [[ $RESET_CONFIG == "true" ]]; then
    
    writeLog "[Reset Conf] - Start --> Removing the configuration"
    removeConfigfiles;
    writeLog "[Reset Conf] - Resolved --> Removing the configuration"
fi


#------------------------#
# Teminating messages
#------------------------#
writeEcho "Finished."
writeEcho "Please wait 30 seconds to let all Agents & Deamons finish the $LOADER!"
writeEcho "Bye!"
writeLog "[Session] - End"
writeLog "-------------------"