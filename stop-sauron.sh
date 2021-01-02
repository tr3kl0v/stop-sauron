#!/bin/sh

[[ $EUID == 0 ]] || { echo "Must be run as root."; exit; }

#------------------------#
# imports
#------------------------#
. configuration.sh
. shared.sh


WriteLog "Hello '$SUDO_USER', as expected you're currently '$LOCAL_USER'!"

#------------------------#
# Options menu
#------------------------#
PS3='Please enter your choice: '
options=("Disable Sauron's eye" "Enable Sauron's eye" "Cancel")
select opt in "${options[@]}"
do
    case $opt in
        "Disable Sauron's eye")
            WriteLog "You have chosen to disable 'Sauron' and its minions!"
            ACTION="disable"
            LOADER="unload"
            break
            ;;
        "Enable Sauron's eye") 
            WriteLog "You have chosen to enable 'Sauron' and its minions!"
            ACTION="enable"
            LOADER="load"            
            break
            ;;
        "Cancel")
            WriteLog "Quiting .."
            exit
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

#------------------------#
# Handling AirWatch
#------------------------#
val=$(/usr/libexec/PlistBuddy -c "Print ProgramArguments:0" "${AIRWATCH_AGENT_PLIST}")
if [[ $val == *"Workspace ONE Intelligent Hub"* ]]; then
    WriteLog "You've got the Workspace ONE Agent"

    # enable
    if [[ $ACTION == "enable" ]]; then

        # Check ROOT processes on loading
        PROCESS=`ps -Ac | /bin/launchctl list | grep -m1 'airwatch' | awk '{print $1}'`
    
        # Check if process is a number
        if isNumber; then
            WriteLog "Root process ($PROCESS) already running -- skipping"
        else 
            WriteLog "Loading the Workspace ONE Deamon(s)"
            for t in ${airwatchSystemWideDeamonsArray[@]}; do
                /bin/launchctl $LOADER -w $t
            done
        fi

        # Check the USER processes from a root viewpoint
        var1=`su - $SUDO_USER -c "ps -A | /bin/launchctl list | grep -m1 'airwatch'"`
        PROCESS=`echo $var1 | awk '{print $1}'`
        # Check if process is a number
        if isNumber; then
            WriteLog "User process ($PROCESS) already running -- skipping"
        else 
            WriteLog "Loading the Workspace ONE Program(s)"
            for u in ${airwatchPerUserAgentsArray[@]}; do
                su - $SUDO_USER -c "/bin/launchctl $LOADER -w $u"
            done
        fi

    # disable
    else 
        WriteLog "Unloading the Workspace ONE Deamon(s)"

        for t in ${airwatchSystemWideDeamonsArray[@]}; do
            /bin/launchctl $LOADER -w $t
        done

        WriteLog "Unloading the Workspace ONE Program(s)"
        for u in ${airwatchPerUserAgentsArray[@]}; do
            su - $SUDO_USER -c "/bin/launchctl $LOADER -w $u"
        done
    fi

else 
    WriteLog "Can't locate the Workspace ONE Agent"
fi

#------------------------#
# FireEye
#------------------------#
val=$(/usr/libexec/PlistBuddy -c "Print ProgramArguments:0" "${FIRE_EYE_XAGT_PLIST}")
if [[ $val == *"xagt"* ]]; then
    WriteLog "You've got the FireEye XAGT Agent"
 
   # enable
    if [[ $ACTION == "enable" ]]; then

        # Check ROOT processes on loading
        PROCESS=`ps -Ac | /bin/launchctl list | grep -m1 'xagt' | awk '{print $1}'`

        # Check if process is a number
        if isNumber; then
            WriteLog "Root process ($PROCESS) already running -- skipping"
        else 
            WriteLog "Loading the FireEye XAGT Deamon(s)"
            for t in ${fireEyeSystemWideDeamonsArray[@]}; do
                /bin/launchctl $LOADER -w $t
            done
        fi

        # Check the USER processes from a root viewpoint
        var1=`su - $SUDO_USER -c "ps -A | /bin/launchctl list | grep -m1 'xagt'"`
        PROCESS=`echo $var1 | awk '{print $1}'`
        # Check if process is a number
        if isNumber; then
            WriteLog "User process ($PROCESS) already running -- skipping"
        else 
            WriteLog "Loading the FireEye XAGT Program(s)"
            for t in ${fireEyeAgentsArray[@]}; do
                su - $SUDO_USER -c "/bin/launchctl $LOADER -w $t"
            done
        fi

    # disable
    else 
        WriteLog "Unloading the FireEye XAGT Deamon(s)"
        for t in ${fireEyeSystemWideDeamonsArray[@]}; do
            /bin/launchctl $LOADER -w $t
        done

        WriteLog "Unloading the FireEye XAGT Program(s)"
        for t in ${fireEyeAgentsArray[@]}; do
            su - $SUDO_USER -c "/bin/launchctl $LOADER -w $t"
        done
    fi


else 
    WriteLog "Can't locate the FireEye XAGT agent"
fi

#------------------------#
# McAfee
#------------------------#
val=$(/usr/libexec/PlistBuddy -c "Print ProgramArguments:0" "${MCAFEE_MENULET_PLIST}")
if [[ $val == *"McAfee"* ]]; then
    WriteLog "You've got the McAfee Agent"
 
   # enable
    if [[ $ACTION == "enable" ]]; then

        # Check ROOT processes on loading
        PROCESS=`ps -Ac | /bin/launchctl list | grep -m1 'mcafee.agent.ma' | awk '{print $1}'`

        # Check if process is a number
        if isNumber; then
            WriteLog "Root process ($PROCESS) already running -- skipping"
        else 
            WriteLog "Loading the McAfee Deamon(s)"
            for t in ${mcAfeeSystemWideDeamonsArray[@]}; do
                /bin/launchctl $LOADER -w $t
            done
        fi

        # Check the USER processes from a root viewpoint
        var1=`su - $SUDO_USER -c "ps -A | /bin/launchctl list | grep -m1 'mcafee.reporter'"`
        PROCESS=`echo $var1 | awk '{print $1}'`
        # Check if process is a number
        if isNumber; then
            WriteLog "User process ($PROCESS) already running -- skipping"
        else 
            WriteLog "Loading the McAfee Program(s)"
            for t in ${mcAfeeAgentsArray[@]}; do
               su - $SUDO_USER -c "/bin/launchctl $LOADER -w $t"
            done
        fi

    # disable
    else 
        WriteLog "Unloading the McAfee Deamon(s)"
        for t in ${mcAfeeSystemWideDeamonsArray[@]}; do
            /bin/launchctl $LOADER -w $t
        done
        WriteLog "Unloading the McAfee Program(s)"
        for t in ${mcAfeeAgentsArray[@]}; do
            su - $SUDO_USER -c "/bin/launchctl $LOADER -w $t"
        done
    fi

else 
    WriteLog "Can't locate the McAfee agent"
fi
