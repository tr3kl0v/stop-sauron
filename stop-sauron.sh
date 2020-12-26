#!/bin/sh

[[ $EUID == 0 ]] || { echo "Must be run as root."; exit; }

# DEAMONS
AIRWATCH_DAEMON_PLIST="/Library/LaunchDaemons/com.airwatch.airwatchd.plist" # root | AirWatch/hubd process | deamon | unloadable
AIRWATCH_AWCM_PLIST="/Library/LaunchDaemons/com.airwatch.awcmd.plist" # root | AirWatch/awcmd process | deamon | unloadable
FIRE_EYE_XAGT_PLIST="/Library/LaunchDaemons/com.fireeye.xagt.plist"  # root | xagt DEAMON | deamon | unloadable
MCAFEE_AGENT_PLIST="/Library/LaunchDaemons/com.mcafee.agent.ma.plist" # root | McAfee/agent/bin/masvc | Program | unloadable
MCAFEE_AGENT_MCAM_PLIST="/Library/LaunchDaemons/com.mcafee.agent.macmn.plist" # root | McAfee/agent/bin/macmnsv | Program | unloadable
MCAFEE_AGENT_MACOMPAT_PLIST="/Library/LaunchDaemons/com.mcafee.agent.macompat.plist" # root | McAfee/agent/bin/macompatsvc | Program | unloadable
MCAFEE_AGENT_AGENTMONITOR_PLIST="/Library/LaunchDaemons/com.mcafee.agentMonitor.helper.plist" # user | com.mcafee.agentMonitor.helper | service | unloadable
MCAFEE_AGENT_SSM_PLIST="/Library/LaunchDaemons/com.mcafee.ssm.Eupdate.plist" # root | McAfee/AntiMalware/VShieldUpdate | Program | unloadable
MCAFEE_AGENT_SCANFACTORY_PLIST="/Library/LaunchDaemons/com.mcafee.ssm.ScanFactory.plist" # root | McAfee/AntiMalware/VShieldScanner | Program | unloadable
MCAFEE_AGENT_SCANMANAGER_PLIST="/Library/LaunchDaemons/com.mcafee.ssm.ScanManager.plist" # root | McAfee/AntiMalware/VShieldScanManager.app | Program | unloadable
MCAFEE_AGENT_VIRUSSCAN_PLIST="/Library/LaunchDaemons/com.mcafee.virusscan.fmpd.plist" # root | McAfee/fmp/bin64/fmpd | Program | unloadable

# AGENTS
AIRWATCH_AGENT_PLIST="/Library/LaunchAgents/com.airwatch.mac.agent.plist" # user | IntelligentHubAgent.app | Program | unloadable
FIRE_EYE_XAGTNOTIF_PLIST="/Library/LaunchAgents/com.fireeye.xagtnotif.plist" # user | FireEye/xagt/xagtnotif.app | Program | unloadable
MCAFEE_MENULET_PLIST="/Library/LaunchAgents/com.mcafee.menulet.plist" # user | McAfee/MSS/Applications/Menulet.app | Program | not unloadable
MCAFEE_REPORTER_PLIST="/Library/LaunchAgents/com.mcafee.reporter.plist" # user | McAfee Reporter.app | Program | not unloadable
# MCAFEE_UNINSTALL_SYSTEMEXTENSTION_PLIST="/Library/LaunchAgents/com.mcafee.uninstall.SystemExtension.plist" # root | McAfee deactivatesystemextension | Program |  not unloadable

# PROCESS
AIRWATCH_PROCESS="airwatch" 
FIRE_EYE_PROCESS="xagt"

# Users
LOCAL_USER=$USER
SUDO_USER=$SUDO_USER

WriteLog ()
{
	# /bin/echo `date`" "$1 >> $LOG
	/bin/echo `date`" --- "$1
}

isNumber ()
{
    case $PROCESS in
        ''|*[!0-9]*) false ;;
        *) true ;;
    esac 
} 


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
            WriteLog "You have chosen to disable 'Sauron' and it's minions!"
            ACTION="disable"
            LOADER="unload"
            RUNNER="stop"
            break
            ;;
        "Enable Sauron's eye") 
            WriteLog "You have chosen to enable 'Sauron' and it's minions!"
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


#------------------------#
# Stop & unload 
#sudo launchctl unload -w /Library/LaunchDaemons/com.fireeye.xagt.plist
#launchctl stop com.fireeye.xagtnotif
# McAfee
#sudo /usr/local/McAfee/AntiMalware/VSControl stopoas
#sudo /usr/local/McAfee/AntiMalware/VSControl stop



# Check processes:
# ps aux | grep xagt

# 1
# sudo su - root
# while :; do clear; launchctl list | grep mcafee; sleep 2; done

# 2
# while :; do clear; launchctl list | grep mcafee; sleep 2; done

# 3
# sudo su - root
# while :; do clear; launchctl list | grep airwatch; sleep 2; done

# 4
# while :; do clear; launchctl list | grep airwatch; sleep 2; done

# 5
# sudo su - root
# while :; do clear; launchctl list | grep xagt; sleep 2; done

# 6
# while :; do clear; launchctl list | grep xagt; sleep 2; done
