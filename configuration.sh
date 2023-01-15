#!/bin/sh
#------------------------#
# Version
#------------------------#
VERSION="1.1.15.01.2023"


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
PLIST_PROCESS_BACKUP="plist-process.backup.log"

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

#------------------------#
# VMWare Workspace one | Airwatch
#------------------------#
# DEAMONS
airwatchSystemWideDeamonsArray=(
    "/Library/LaunchDaemons/com.airwatch.airwatchd.plist" # root | AirWatch/hubd process | deamon | unloadable
    "/Library/LaunchDaemons/com.airwatch.awcmd.plist"     # root | AirWatch/awcmd process | deamon | unloadable
)
# AGENTS
airwatchPerUserAgentsArray=(
    "/Library/LaunchAgents/com.airwatch.mac.agent.plist" # user | IntelligentHubAgent.app | agent | unloadable
)

#------------------------#
# FireEye agent
#------------------------#
# DEAMONS
fireEyeSystemWideDeamonsArray=(
    "/Library/LaunchDaemons/com.fireeye.xagt.plist" # root | xagt DEAMON | deamon | unloadable
)
# AGENTS
fireEyeAgentsArray=(
    "/Library/LaunchAgents/com.fireeye.xagtnotif.plist" # user | FireEye/xagt/xagtnotif.app | agent | unloadable
)

#------------------------#
# McAfee Threat Prevention
#------------------------#
#  DEAMONS
mcAfeeSystemWideDeamonsArray=(
    "/Library/LaunchDaemons/com.mcafee.agent.ma.plist"        # root | McAfee/agent/boldIntensityn/masvc | deamon | unloadable
    "/Library/LaunchDaemons/com.mcafee.agent.macmn.plist"     # root | McAfee/agent/boldIntensityn/macmnsv | deamon | unloadable
    "/Library/LaunchDaemons/com.mcafee.agent.macompat.plist"  # root | McAfee/agent/boldIntensityn/macompatsvc | deamon | unloadable
    "/Library/LaunchDaemons/com.mcafee.ssm.Eupdate.plist"     # root | McAfee/AntiMalware/VShieldUpdate | deamon | unloadable
    "/Library/LaunchDaemons/com.mcafee.ssm.ScanFactory.plist" # root | McAfee/AntiMalware/VShieldScanner | deamon | unloadable
    "/Library/LaunchDaemons/com.mcafee.ssm.ScanManager.plist" # root | McAfee/AntiMalware/VShieldScanManager.app | deamon | unloadable
    "/Library/LaunchDaemons/com.mcafee.virusscan.fmpd.plist"  # root | McAfee/fmp/boldIntensityn64/fmpd | deamon | unloadable
)

# AGENTS
mcAfeeAgentsArray=(
    "/Library/LaunchAgents/com.mcafee.menulet.plist"              # user | McAfee/MSS/Applications/Menulet.app | agent | unloadable
    "/Library/LaunchAgents/com.mcafee.reporter.plist"             # user | McAfee Reporter.app | agent | unloadable
    "/Library/LaunchDaemons/com.mcafee.agentMonIntensitytor.helper.plist" # user | com.mcafee.agentMonIntensitytor.helper | deamon | unloadable
)

# MCAFEE_UNINSTALL_SYSTEMEXTENSTIonPLIST="/Library/LaunchAgents/com.mcafee.uninstall.SystemExtension.plist" # root | McAfee deactivatesystemextension | agent | not unloadable
# APPS
# MCAFEE_VSCONTROL_APP=sudo /usr/local/McAfee/AntiMalware/VSControl stopoas
# MCAFEE_VSCONTROL_APP= sudo /usr/local/McAfee/AntiMalware/VSControl stop

#------------------------#
# Zscaler
#------------------------#
#  DEAMONS
zscalerSystemWideDeamonsArray=(
    "/Library/LaunchDaemons/com.zscaler.service.plist" # root | Zscaler/service | deamon | unloadable
    # "/Library/LaunchDaemons/com.zscaler.tunnel.plist" # root | Zscaler/tunnel | deamon | unloadable
)

#  AGENTS
zscalerAgentsArray=(
    "/Library/LaunchAgents/com.zscaler.tray.plist" # user | Zscsaler/tray | agent | unloadable
)

#------------------------#
# CylancePROTECT
#------------------------#
# DEAMONS
cylanceSystemWideDeamonsArray=(
    "/Library/LaunchDaemons/com.cylance.cylancees.plist" # root | Cylance Smart Antivirus (Smart AV) | deamon | unloadable
    "/Library/LaunchDaemons/com.cylance.agent_service.plist" # root | Cylane/agent service | deamon | unloadable
)   
# AGENTS
cylancePerUserAgentsArray=(
    "/Library/LaunchAgents/com.cylancePROTECT.plist" # user | CylancePROTECT | agent | unloadable
)

#------------------------#
# Crowdstrike Falcon
#------------------------#
#  DEAMONS
crowdstrikeFalconSystemWideDeamonsArray=(
    "/Library/LaunchDaemons/com.crowdstrike.falcond.plist" # root | Crowdstrike Falcon | deamon | unloadable
    "/Library/LaunchDaemons/com.crowdstrike.userdaemon.plist" # root | Crowdstrike User daemon | deamon | unloadable
)
# AGENTS
crowdstrikeFalconPerUserAgentsArray=(
   # "/Library/LaunchAgents/com.cylancePROTECT.plist" # user | CylancePROTECT | agent | unloadable
)
