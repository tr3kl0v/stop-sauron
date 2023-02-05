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
    
    echo "Stop Sauron [-hxop] [arguments]"
    echo " "
    echo "Syntax: stop-sauron [-h|x|o|p]"
    echo "options:"
    echo "-h,   Print this brief help"
    echo "-x,   Enable logging for debug purpose"
    echo "-o,   Pass integer [1-2] to automate the script"

}

#------------------------#
# Check if folder exits
#------------------------#
deleteLogfiles() {

    # logfile
    if [ -f $USER_LOG_FILE ]; then
        rm $USER_LOG_FILE
    fi
    
}

#------------------------#
# Create backup
#------------------------#
createBackupfiles() {
    writeLog "[Backup] - Start --> Creating backup configuration files"

    if [ -f $PLIST_DEAMON_CONF ]; then
        writeLog "[Backup] - found --> $PLIST_DEAMON_CONF"
        if [ -f $PLIST_DEAMON_BACKUP ]; then
            writeLog "[Backup] - found --> $PLIST_DEAMON_BACKUP --> skipping backup"
            writeEcho "[Backup] - found --> $PLIST_DEAMON_BACKUP --> skipping backup. Please remove this previous backup file manually"
        else
            cp $PLIST_DEAMON_CONF $PLIST_DEAMON_BACKUP
            writeLog "[Backup] - created --> $PLIST_DEAMON_BACKUP"
        fi
    fi
    
    if [ -f $PLIST_AGENT_CONF ]; then
        writeLog "[Backup] - found --> $PLIST_AGENT_CONF"
        if [ -f $PLIST_AGENT_BACKUP ]; then
            writeLog "[Backup] - found --> $PLIST_AGENT_BACKUP --> skipping backup"
            writeEcho "[Backup] - found --> $PLIST_AGENT_BACKUP --> skipping backup. Please remove this previous backup file manually"
        else
            cp $PLIST_AGENT_CONF $PLIST_AGENT_BACKUP
            writeLog "[Backup] - created --> $PLIST_AGENT_BACKUP"
        fi
    fi
    writeLog "[Backup] - Resolved --> Creating backup configuration files"
    
}

#------------------------#
# Remove configuration
#------------------------#
removeConfigfiles() {

    # Config
    if [ -f $PLIST_DEAMON_CONF ]; then
        writeLog "[Reset Conf] - Found --> $PLIST_DEAMON_CONF"
        rm $PLIST_DEAMON_CONF
        writeLog "[Reset Conf] - Removed --> $PLIST_DEAMON_CONF"
    fi
    
    if [ -f $PLIST_AGENT_CONF ]; then
        writeLog "[Reset Conf] - Found --> $PLIST_AGENT_CONF"
        rm $PLIST_AGENT_CONF
        writeLog "[Reset Conf] - Removed --> $PLIST_AGENT_CONF"
    fi

    
}
