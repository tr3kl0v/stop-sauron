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
            RUNNER="stop"
            break
            ;;
        "Enable Sauron's eye") 
            WriteLog "You have chosen to enable 'Sauron' and its minions!"
            ACTION="enable"
            LOADER="load"            
            RUNNER="start"
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
            /bin/launchctl $LOADER -w $AIRWATCH_DAEMON_PLIST
            /bin/launchctl $LOADER -w $AIRWATCH_AWCM_PLIST
        fi

        # Check the USER processes from a root viewpoint
        var1=`su - $SUDO_USER -c "ps -A | /bin/launchctl list | grep -m1 'airwatch'"`
        PROCESS=`echo $var1 | awk '{print $1}'`
        # Check if process is a number
        if isNumber; then
            WriteLog "User process ($PROCESS) already running -- skipping"
        else 
            WriteLog "Loading the Workspace ONE Program(s)"
            su - $SUDO_USER -c "/bin/launchctl $LOADER -w $AIRWATCH_AGENT_PLIST"
        fi

    # disable
    else 
        WriteLog "Unloading the Workspace ONE Deamon(s)"
        /bin/launchctl $LOADER -w $AIRWATCH_DAEMON_PLIST
        /bin/launchctl $LOADER -w $AIRWATCH_AWCM_PLIST
        WriteLog "Unloading the Workspace ONE Program(s)"
        su - $SUDO_USER -c "/bin/launchctl $LOADER -w $AIRWATCH_AGENT_PLIST"
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
            /bin/launchctl $LOADER -w $FIRE_EYE_XAGT_PLIST
        fi

        # Check the USER processes from a root viewpoint
        var1=`su - $SUDO_USER -c "ps -A | /bin/launchctl list | grep -m1 'xagt'"`
        PROCESS=`echo $var1 | awk '{print $1}'`
        # Check if process is a number
        if isNumber; then
            WriteLog "User process ($PROCESS) already running -- skipping"
        else 
            WriteLog "Loading the FireEye XAGT Program(s)"
            su - $SUDO_USER -c "/bin/launchctl $LOADER -w $FIRE_EYE_XAGTNOTIF_PLIST"
        fi

    # disable
    else 
        WriteLog "Unloading the FireEye XAGT Deamon(s)"
        /bin/launchctl $LOADER -w $FIRE_EYE_XAGT_PLIST
        WriteLog "Unloading the FireEye XAGT Program(s)"
        su - $SUDO_USER -c "/bin/launchctl $LOADER -w $FIRE_EYE_XAGTNOTIF_PLIST"
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
            /bin/launchctl $LOADER -w $MCAFEE_AGENT_PLIST
            /bin/launchctl $LOADER -w $MCAFEE_AGENT_MCAM_PLIST
            /bin/launchctl $LOADER -w $MCAFEE_AGENT_MACOMPAT_PLIST
            su - $SUDO_USER -c "/bin/launchctl $LOADER -w $MCAFEE_AGENT_AGENTMONITOR_PLIST"
            /bin/launchctl $LOADER -w $MCAFEE_AGENT_SSM_PLIST
            /bin/launchctl $LOADER -w $MCAFEE_AGENT_SCANFACTORY_PLIST
            /bin/launchctl $LOADER -w $MCAFEE_AGENT_SCANMANAGER_PLIST
            /bin/launchctl $LOADER -w $MCAFEE_AGENT_VIRUSSCAN_PLIST
        fi

        # Check the USER processes from a root viewpoint
        var1=`su - $SUDO_USER -c "ps -A | /bin/launchctl list | grep -m1 'mcafee.reporter'"`
        PROCESS=`echo $var1 | awk '{print $1}'`
        # Check if process is a number
        if isNumber; then
            WriteLog "User process ($PROCESS) already running -- skipping"
        else 
            WriteLog "Loading the McAfee Program(s)"
            su - $SUDO_USER -c "/bin/launchctl $LOADER -w $MCAFEE_MENULET_PLIST"
            su - $SUDO_USER -c "/bin/launchctl $LOADER -w $MCAFEE_REPORTER_PLIST"
        fi

    # disable
    else 
        WriteLog "Unloading the McAfee Deamon(s)"
        /bin/launchctl $LOADER -w $MCAFEE_AGENT_PLIST
        /bin/launchctl $LOADER -w $MCAFEE_AGENT_MCAM_PLIST
        /bin/launchctl $LOADER -w $MCAFEE_AGENT_MACOMPAT_PLIST
        su - $SUDO_USER -c "/bin/launchctl $LOADER -w $MCAFEE_AGENT_AGENTMONITOR_PLIST"
        /bin/launchctl $LOADER -w $MCAFEE_AGENT_SSM_PLIST
        /bin/launchctl $LOADER -w $MCAFEE_AGENT_SCANFACTORY_PLIST
        /bin/launchctl $LOADER -w $MCAFEE_AGENT_SCANMANAGER_PLIST
        /bin/launchctl $LOADER -w $MCAFEE_AGENT_VIRUSSCAN_PLIST
        WriteLog "Unloading the McAfee Program(s)"
        su - $SUDO_USER -c "/bin/launchctl $LOADER -w $MCAFEE_MENULET_PLIST"
        su - $SUDO_USER -c "/bin/launchctl $LOADER -w $MCAFEE_REPORTER_PLIST"
    fi

else 
    WriteLog "Can't locate the McAfee agent"
fi
