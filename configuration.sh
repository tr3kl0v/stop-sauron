#!/bin/bash
#------------------------#
# Version
#------------------------#
VERSION="1.1.7.19.04.2026"
LAUNCHCTL_BIN="${STOP_SAURON_LAUNCHCTL_BIN:-/bin/launchctl}"
INSTALL_LOG_FILE="${STOP_SAURON_INSTALL_LOG:-/private/var/log/install.log}"


#------------------------#
# Users
#------------------------#
LOCAL_USER="${LOCAL_USER:-$USER}"
SUDO_USER="${SUDO_USER:-$LOCAL_USER}"

#------------------------#
# State
#------------------------#
STATE_DIR="${STOP_SAURON_STATE_DIR:-.}"

#------------------------#
# Logfiles
#------------------------#
USER_LOG_FOLDER=".stop-sauron"
USER_LOG_FILE="${STATE_DIR}/debug.log"
PLIST_DEAMON_CONF="${STATE_DIR}/plist-deamon.backup.conf"
PLIST_DEAMON_BACKUP="${STATE_DIR}/plist-deamon.backup.conf.bak"
PLIST_AGENT_CONF="${STATE_DIR}/plist-agent.backup.conf"
PLIST_AGENT_BACKUP="${STATE_DIR}/plist-agent.backup.conf.bak"

#------------------------#
# Plist paths
#------------------------#
if [[ -n "${STOP_SAURON_PLIST_PATHS:-}" ]]; then
    IFS=':' read -r -a plistPathArray <<< "$STOP_SAURON_PLIST_PATHS"
else
    plistPathArray=(
    #    "~/Library/LaunchAgents"         # Per-user agents provided by the user.
        "/Library/LaunchAgents"          # Per-user agents provided by the administrator.
        "/Library/LaunchDaemons"         # System wide daemons provided by the administrator.
        "/System/Library/LaunchAgents"   # Mac OS X Per-user agents.
        "/System/Library/LaunchDaemons"  # Mac OS X System wide daemons.
    )
fi

#------------------------#
# Software packages
#------------------------#
if [[ -n "${STOP_SAURON_APPLICATIONS:-}" ]]; then
    IFS=':' read -r -a applicationsArray <<< "$STOP_SAURON_APPLICATIONS"
else
    applicationsArray=(
        "com.airwatch"
        "com.fireeye"
        "com.mcafee"
        "com.zscaler"
        "com.cylance"
        "com.crowdstrike"
        "com.rapid7"
    )
fi
