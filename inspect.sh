#!/bin/sh

#------------------------#
# Search for deamons, plists and Installtion file on current systems
#------------------------#
prepare() {
    writeLog "-------------------"
    writeLog "[Prepare] - Start"

    if [[ "$debugFlag" == "true" ]]; then
        createLogFile;
    fi
    findFiles;
    findProcesses;

    writeLog "[Prepare] - Stop"
}

createLogFile() {

    #logLocation="${HOME}/"
    #logLocation+="${USER_LOG_FOLDER}"
    #logFile="${logLocation}/${USER_LOG_FILE}"
    #echo $logLocation
    #echo $logFile
    #if isFile $logFile; then   


    # Check if logfile exits on system
    if [ -f $USER_LOG_FILE ]; then
        writeLog "[Logfile] - File found"
    else        
        writeEcho "[Logfile] - File not found!"
        writeEcho "[Logfile] - Creating logFile"

        #if isFolder $logLocation; then
        #    writeLog "log folder found"
        #else 
        #    writeLog "log folder not found"
        #    mkdir -p $logLocation;


        # Create new logfile
        echo "$(date) --- [Logfile] - created" > $USER_LOG_FILE

      #fi

    fi
}

findProcesses() {
    
    writeLog "[PS] - Start --> Find processes"

    processArray=()

    writeLog "[Plist] - find Deamon process"
    for i in ${plistArray[@]}; do

        # Get path
        dirname="${i%/*}"

        # Get last folder
        basename="${dirname##*/}"

        # Strip path from filename
        filename="$(basename -- $i)"
        
        # Get filename without extension
        filename="${filename%.*}"

        if [[ "$basename" == "LaunchAgents" ]]; then
            # Check the USER processes from a root viewpoint
            var1=$(su - $SUDO_USER -c "ps -A | /bin/launchctl list | grep -m1 $filename")
            PROCESS=$(echo $var1 | awk '{print $1}')

            # su - $SUDO_USER -c "/bin/launchctl list $filename"
            
        else
            # Get Deamon PID
            PROCESS="$(ps -Ac | /bin/launchctl list | grep -m1 "$filename" | awk '{print $1}')"

            # /bin/launchctl list $filename
#
            # find plist files in folder defined and add them to array
            # find $v -name "${t}*" -print0 >tmpfile
            # while IFS=  read -r -d $'\0'; do

            # plistArray+=("$REPLY")
            # writeLog "[Plist] - $t --> found --> $REPLY"
                           
            # done <tmpfile
            # rm -f tmpfile
#
        fi
                
        # Check if process is a number
        if isNumber; then
            processArray+=("$PROCESS")
        else
            processArray+=("0")
        fi

        writeLog "[PS] - $filename --> PID --> $PROCESS"

    done

    writeLog "[PS] - Array --> size: ${#processArray[@]}"
    writeLog "[PS] - Resolved --> Find processes"

}

findFiles() {
    
    writeLog "[Files] - Start --> Find Plists"

    plistArray=()

    for t in ${applicationsArray[@]}; do
        
        writeLog "[Application] - Locate --> $t"
       
        # loop through sudo- & system Launch folders
        for v in ${plistPathArray[@]}; do

            # find plist files in folder defined and add them to array
            find $v -name "${t}*" -print0 >tmpfile
            while IFS=  read -r -d $'\0'; do

            plistArray+=("$REPLY")
            writeLog "[Plist] - $t --> found --> $REPLY"
                           
            done <tmpfile
            rm -f tmpfile

        done

        writeLog "[Plist] - Array --> size: ${#plistArray[@]}"

        # User folder
        # echo $HOME
        # echo find "$HOME/$t" -name "'$t*'" -print
        # CHECK="$(find $v -name '$t*')"
        # echo $CHECK

    done

    writeLog "[Files] - Resolved --> Find Plists"

}

#inspectInstallationFile(){

#}
