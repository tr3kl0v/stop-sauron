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

getDeviceInformation(){
    
    # get device serial number (e.g. X1X1XX1XXX)
    serialNumber=$(ioreg -c IOPlatformExpertDevice -d 2 | awk -F\" '/IOPlatformSerialNumber/{print $4}')
    serialNumber=$(echo $serialNumber | tr -d '\n')

    #softwareVersionOutput=$(sw_vers)
    #formattedOutput=$(echo "$softwareVersionOutput" | tr -s '	')
    productName=$(sw_vers -productName)
    productVersion=$(sw_vers -productVersion)
    buildVersion=$(sw_vers -buildVersion)

    # get product type (e.g. Macbook18.1)
    productType=$(sysctl hw.model | awk -F ' ' '{print $2}')
    productType=$(echo $productType | tr -d '\n')

    writeLog "[Device] - SerialNumber --> $serialNumber"
    writeLog "[Device] - ProductType: --> $productType"
    writeLog "[Device] - ProductName: --> $productName"
    writeLog "[Device] - ProductVersion: --> $productVersion"
    writeLog "[Device] - BuildVersion: --> $buildVersion"
}
