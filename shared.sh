#!/bin/sh

#------------------------#
# Logging
#------------------------#
writeLog() {
     if [[ "$debugFlag" == "true" ]]; then
        /bin/echo $(date)" - "$1 >> $USER_LOG_FILE
    fi
}

writeEcho() {
    /bin/echo $(date)" - "$1
}

#------------------------#
# Validating number
#------------------------#
isNumber() {
    case $PROCESS in
    '' | *[!0-9]*) false ;;
    *) true ;;
    esac
}

#------------------------#
# Check if file exits
#------------------------#
isFile() {
    [ -f "$FILE" ]
}

#------------------------#
# Check if folder exits
#------------------------#
isFolder() {
    [  -d "$FOLDER" ]
}


#------------------------#
# Greeting message
#------------------------#
greeting() {
    hour=`date +%H`

    if [ $hour -lt 12 ]; then
        greet="Good morning"
    elif [ $hour -lt 18 ]; then
        greet="Good afternoon"
    else
        greet="Good evening"
    fi
}

#------------------------#
# Print GetOps Menu uasage message
#------------------------#
printGetOptsMenuUsage() {
    
    echo "Stop Sauron - To stop the all seeing eye of Sauron and make your MacBook operate as it should be."
    echo " "
    echo "Stop Sauron [options] application [arguments]"
    echo " "
    echo "options:"
    # echo "-h, --help                show brief help"
    echo "-x, --debugFlag=true       enable debug logging"
    # echo "-o, --output-dir=DIR      specify a directory to store output in"

}

#------------------------#
# Check if folder exits
#------------------------#
deleteLogfiles() {
    rm $USER_LOG_FILE
    rm $PLIST_PROCESS_BACKUP
}

