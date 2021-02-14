#!/bin/sh

#------------------------#
# Logging
#------------------------#
writeLog() {
    /bin/echo $(date)" - "$1 >> $USER_LOG_FILE
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
# Greating
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