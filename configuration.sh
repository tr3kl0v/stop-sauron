#!/bin/sh
#------------------------#
# Version
#------------------------#
VERSION="1.1.5.30.01.2023"


#------------------------#
# Users
#------------------------#
LOCAL_USER=$USER
SUDO_USER=$SUDO_USER

#------------------------#
# Logfiles
#------------------------#
USER_LOG_FOLDER=".stop-sauron"
USER_LOG_FILE="debug.log"
PLIST_DEAMON_CONF="plist-deamon.backup.conf"
PLIST_DEAMON_BACKUP="plist-deamon.backup.conf.bak"
PLIST_AGENT_CONF="plist-agent.backup.conf"
PLIST_AGENT_BACKUP="plist-agent.backup.conf.bak"

#------------------------#
# Plist paths
#------------------------#
plistPathArray=(
#    "~/Library/LaunchAgents"         # Per-user agents provided by the user.
    "/Library/LaunchAgents"          # Per-user agents provided by the administrator.
    "/Library/LaunchDaemons"         # System wide daemons provided by the administrator.
    "/System/Library/LaunchAgents"   # Mac OS X Per-user agents.
    "/System/Library/LaunchDaemons"  # Mac OS X System wide daemons.
)

#------------------------#
# Software packages
#------------------------#
applicationsArray=(
    "com.airwatch"
    "com.fireeye"
    "com.mcafee"
    "com.zscaler"
    "com.cylance"
    "com.crowdstrike"
)