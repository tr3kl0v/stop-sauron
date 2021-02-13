#!/bin/sh

#------------------------#
# Search for deamons, plists and Installtion file on current systems
#------------------------#
prepare() {
    createLogFile;
    findFiles;
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
        writeLog "-------------------"
        writeLog "[Logfile] - Found on system"
    else        
        writeEcho "[Logfile] - Not found on system"
        writeEcho "[Logfile] - Creating logFile"

        #if isFolder $logLocation; then
        #    writeLog "log folder found"
        #else 
        #    writeLog "log folder not found"
        #    mkdir -p $logLocation;


        # Create new logfile
        echo "$(date) --- [Logfile] - created" > $USER_LOG_FILE
        writeLog "-------------------"

      #fi

    fi
    writeLog "[Session] - Start"
}

#inspectDeamons() {
    
    # PROCESS=$(ps -Ac | /bin/launchctl list | grep -m1 'airwatch' | awk '{print $1}')
    
    # deamonNameArray
#}

findFiles() {
    
    plistArray=()

    for t in ${applicationsArray[@]}; do
        
        writeLog "[Application] - Locate --> $t"
        # loop through sudo- & system Launch folders
        for v in ${plistPathArray[@]}; do

            # find files in folder defined 
            find $v -name "${t}*" -print0 >tmpfile
            while IFS=  read -r -d $'\0'; do
                writeLog "[Plist] - $t --> Found --> $REPLY"
                plistArray+=("$REPLY")
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
}

#inspectInstallationFile(){

#}
