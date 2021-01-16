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

WriteLog "Hello '$SUDO_USER', as expected you're currently '$LOCAL_USER'!"

#------------------------#
# Check processes before menu
#------------------------#

# TODO New feat

#------------------------#
# Options menu
#------------------------#
PS3='Please enter your choice: '
options=("Disable Sauron's eye" "Enable Sauron's eye" "Cancel")
select opt in "${options[@]}"; do
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
    *) echo "invalid option $REPLY" ;;
    esac
done

#------------------------#
# Handling AirWatch
#------------------------#

# TODO: Doesn't work, when plist's are not existing
#
# val=$(/usr/libexec/PlistBuddy -c "Print ProgramArguments:0" "${airwatchPerUserAgentsArray[0]}")
# if [[ $val == *"Workspace ONE Intelligent Hub"* ]]; then

FILE=${airwatchPerUserAgentsArray[0]}
if isFile $FILE; then

    WriteLog "You've got the Workspace ONE Agent"

    # Catch 1st ROOT process
    PROCESS=$(ps -Ac | /bin/launchctl list | grep -m1 'airwatch' | awk '{print $1}')

    # enable
    if [[ $ACTION == "enable" ]]; then

        # Check if process is a number
        if isNumber; then
            WriteLog "Root process ($PROCESS) already running -- skipping"
        else
            WriteLog "Loading the Workspace ONE Deamon(s)"
            for t in ${airwatchSystemWideDeamonsArray[@]}; do
                # Check if plist exists
                if isFile $t; then
                    /bin/launchctl $LOADER -w $t
                else
                    WriteLog "File not found: $t"
                fi
            done
        fi

        # Check the USER processes from a root viewpoint
        var1=$(su - $SUDO_USER -c "ps -A | /bin/launchctl list | grep -m1 'airwatch'")
        PROCESS=$(echo $var1 | awk '{print $1}')
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
        # Check if root process is a number
        if isNumber; then
            WriteLog "Unloading the Workspace ONE Deamon(s)"

            for t in ${airwatchSystemWideDeamonsArray[@]}; do
                # Check if plist exists
                if isFile $t; then
                    /bin/launchctl $LOADER -w $t
                else
                    WriteLog "File not found: $t"
                fi
            done

            WriteLog "Unloading the Workspace ONE Program(s)"
            for t in ${airwatchPerUserAgentsArray[@]}; do
                # Check if plist exists
                if isFile $t; then
                    su - $SUDO_USER -c "/bin/launchctl $LOADER -w $t"
                else
                    WriteLog "File not found: $t"
                fi
            done
        else
            WriteLog "Root process is not running -- skipping"
        fi
    fi

else
    WriteLog "Can't locate the Workspace ONE Agent"
fi

#------------------------#
# FireEye
#------------------------#

# TODO: Doesn't work, when plist's are not existing
#
# val1=$(/usr/libexec/PlistBuddy -c "Print ProgramArguments:0" "${fireEyeSystemWideDeamonsArray[0]}")
# if [[ $val1 == *"xagt"* ]]; then

FILE=${fireEyeSystemWideDeamonsArray[0]}
if isFile $FILE; then

    WriteLog "You've got the FireEye XAGT Agent"

    # Catch 1st ROOT process
    PROCESS=$(ps -Ac | /bin/launchctl list | grep -m1 'xagt' | awk '{print $1}')

    # enable
    if [[ $ACTION == "enable" ]]; then

        # Check if process is a number
        if isNumber; then
            WriteLog "Root process ($PROCESS) already running -- skipping"
        else
            WriteLog "Loading the FireEye XAGT Deamon(s)"
            # Loop through array of plists
            for t in ${fireEyeSystemWideDeamonsArray[@]}; do
                # Check if plist exists
                if isFile $t; then
                    /bin/launchctl $LOADER -w $t
                else
                    WriteLog "File not found: $t"
                fi
            done
        fi

        # Check the USER processes from a root viewpoint
        var1=$(su - $SUDO_USER -c "ps -A | /bin/launchctl list | grep -m1 'xagt'")
        PROCESS=$(echo $var1 | awk '{print $1}')
        # Check if process is a number
        if isNumber; then
            WriteLog "User process ($PROCESS) already running -- skipping"
        else
            WriteLog "Loading the FireEye XAGT Program(s)"
            for t in ${fireEyeAgentsArray[@]}; do
                # Check if plist exists
                if isFile $t; then
                    su - $SUDO_USER -c "/bin/launchctl $LOADER -w $t"
                else
                    WriteLog "File not found: $t"
                fi
            done
        fi

    # disable
    else
        # Check if root process is a number
        if isNumber; then
            WriteLog "Unloading the FireEye XAGT Deamon(s)"
            for t in ${fireEyeSystemWideDeamonsArray[@]}; do
                # Check if plist exists
                if isFile $t; then
                    /bin/launchctl $LOADER -w $t
                else
                    WriteLog "File not found: $t"
                fi
            done

            WriteLog "Unloading the FireEye XAGT Program(s)"
            for t in ${fireEyeAgentsArray[@]}; do
                # Check if plist exists
                if isFile $t; then
                    su - $SUDO_USER -c "/bin/launchctl $LOADER -w $t"
                else
                    WriteLog "File not found: $t"
                fi
            done
        else
            WriteLog "Root process is not running -- skipping"
        fi
    fi

else

    WriteLog "Can't locate the FireEye XAGT agent"
fi

#------------------------#
# McAfee
#------------------------#

# TODO: Doesn't work, when plist's are not existing
#
# val2=$(/usr/libexec/PlistBuddy -c "Print ProgramArguments:0" "${mcAfeeAgentsArray[0]}")
# if [[ $val2 == *"McAfee"* ]]; then

FILE=${mcAfeeAgentsArray[0]}
if isFile $FILE; then

    WriteLog "You've got the McAfee Agent"

    # Catch 1st ROOT process
    PROCESS=$(ps -Ac | /bin/launchctl list | grep -m1 'mcafee.agent.ma' | awk '{print $1}')

    # enable
    if [[ $ACTION == "enable" ]]; then

        # Check if process is a number
        if isNumber; then
            WriteLog "Root process ($PROCESS) already running -- skipping"
        else
            WriteLog "Loading the McAfee Deamon(s)"
            for t in ${mcAfeeSystemWideDeamonsArray[@]}; do
                # Check if plist exists
                if isFile $t; then
                    /bin/launchctl $LOADER -w $t
                else
                    WriteLog "File not found: $t"
                fi
            done
        fi

        # Check the USER processes from a root viewpoint
        var1=$(su - $SUDO_USER -c "ps -A | /bin/launchctl list | grep -m1 'mcafee.reporter'")
        PROCESS=$(echo $var1 | awk '{print $1}')
        # Check if process is a number
        if isNumber; then
            WriteLog "User process ($PROCESS) already running -- skipping"
        else
            WriteLog "Loading the McAfee Program(s)"
            for t in ${mcAfeeAgentsArray[@]}; do
                # Check if plist exists
                if isFile $t; then
                    su - $SUDO_USER -c "/bin/launchctl $LOADER -w $t"
                else
                    WriteLog "File not found: $t"
                fi
            done
        fi

    # disable
    else
        # Check if root process is a number
        if isNumber; then
            WriteLog "Unloading the McAfee Deamon(s)"
            for t in ${mcAfeeSystemWideDeamonsArray[@]}; do
                # Check if plist exists
                if isFile $t; then
                    /bin/launchctl $LOADER -w $t
                else
                    WriteLog "File not found: $t"
                fi
            done
            WriteLog "Unloading the McAfee Program(s)"
            for t in ${mcAfeeAgentsArray[@]}; do
                # Check if plist exists
                if isFile $t; then
                    su - $SUDO_USER -c "/bin/launchctl $LOADER -w $t"
                else
                    WriteLog "File not found: $t"
                fi
            done
        else
            WriteLog "Root process is not running -- skipping"
        fi
    fi

else
    WriteLog "Can't locate the McAfee agent"
fi

#------------------------#
# Zscaler
#------------------------#

# TODO: Doesn't work, when plist's are not existing
#
# val3=$(/usr/libexec/PlistBuddy -c "Print ProgramArguments:0" "${zscalerSystemWideDeamonsArray[0]}")
# if [[ $val3 == *"zscaler"* ]]; then

FILE=${zscalerSystemWideDeamonsArray[0]}
if isFile $FILE; then

    WriteLog "You've got the Zscaler Agent"

    # Catch 1st ROOT process
    PROCESS=$(ps -Ac | /bin/launchctl list | grep -m1 'zscaler' | awk '{print $1}')

    # enable
    if [[ $ACTION == "enable" ]]; then

        # Check if root process is a number
        if isNumber; then
            WriteLog "Root process ($PROCESS) already running -- skipping"
        else
            WriteLog "Loading the Zscaler Deamon(s)"
            for t in ${zscalerSystemWideDeamonsArray[@]}; do
                # Check if plist exists
                if isFile $t; then
                    /bin/launchctl $LOADER -w $t
                else
                    WriteLog "File not found: $t"
                fi
            done
        fi

        # Check the USER processes from a root viewpoint
        var1=$(su - $SUDO_USER -c "ps -A | /bin/launchctl list | grep -m1 'zscaler'")
        PROCESS=$(echo $var1 | awk '{print $1}')
        # Check if process is a number
        if isNumber; then
            WriteLog "User process ($PROCESS) already running -- skipping"
        else
            WriteLog "Loading the Zscaler Program(s)"
            for t in ${zscalerAgentsArray[@]}; do
                # Check if plist exists
                if isFile $t; then
                    su - $SUDO_USER -c "/bin/launchctl $LOADER -w $t"
                else
                    WriteLog "File not found: $t"
                fi
            done
        fi

    # disable
    else
        # Check if root process is a number
        if isNumber; then
            WriteLog "Unloading the Zscaler Deamon(s)"
            for t in ${zscalerSystemWideDeamonsArray[@]}; do
                # Check if plist exists
                if isFile $t; then
                    /bin/launchctl $LOADER -w $t
                else
                    WriteLog "File not found: $t"
                fi
            done

            WriteLog "Unloading the Zscaler Program(s)"
            for t in ${zscalerAgentsArray[@]}; do
                # Check if plist exists
                if isFile $t; then
                    su - $SUDO_USER -c "/bin/launchctl $LOADER -w $t"
                else
                    WriteLog "File not found: $t"
                fi
            done
        else
            WriteLog "Root process is not running -- skipping"
        fi
    fi

else
    WriteLog "Can't locate the Zscaler Agent"
fi
