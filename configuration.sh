#!/bin/sh

# Users
LOCAL_USER=$USER
SUDO_USER=$SUDO_USER

# PROCESS
AIRWATCH_PROCESS="airwatch" 
FIRE_EYE_PROCESS="xagt"


#------------------------#
# Software packages
#------------------------#
#------------------------#
# VMWare Workspace one | Airwatch
#------------------------#
# DEAMONS
AIRWATCH_DAEMON_PLIST="/Library/LaunchDaemons/com.airwatch.airwatchd.plist" # root | AirWatch/hubd process | deamon | unloadable
AIRWATCH_AWCM_PLIST="/Library/LaunchDaemons/com.airwatch.awcmd.plist" # root | AirWatch/awcmd process | deamon | unloadable
# AGENTS
AIRWATCH_AGENT_PLIST="/Library/LaunchAgents/com.airwatch.mac.agent.plist" # user | IntelligentHubAgent.app | agent | unloadable

#------------------------#
# FireEye agent
#------------------------#
# DEAMONS
FIRE_EYE_XAGT_PLIST="/Library/LaunchDaemons/com.fireeye.xagt.plist"  # root | xagt DEAMON | deamon | unloadable
# AGENTS
FIRE_EYE_XAGTNOTIF_PLIST="/Library/LaunchAgents/com.fireeye.xagtnotif.plist" # user | FireEye/xagt/xagtnotif.app | agent | unloadable

#------------------------#
# McAfee Threat Prevention
#------------------------#
#  DEAMONS
MCAFEE_AGENT_PLIST="/Library/LaunchDaemons/com.mcafee.agent.ma.plist" # root | McAfee/agent/bin/masvc | deamon | unloadable
MCAFEE_AGENT_MCAM_PLIST="/Library/LaunchDaemons/com.mcafee.agent.macmn.plist" # root | McAfee/agent/bin/macmnsv | deamon | unloadable
MCAFEE_AGENT_MACOMPAT_PLIST="/Library/LaunchDaemons/com.mcafee.agent.macompat.plist" # root | McAfee/agent/bin/macompatsvc | deamon | unloadable
MCAFEE_AGENT_AGENTMONITOR_PLIST="/Library/LaunchDaemons/com.mcafee.agentMonitor.helper.plist" # user | com.mcafee.agentMonitor.helper | deamon | unloadable
MCAFEE_AGENT_SSM_PLIST="/Library/LaunchDaemons/com.mcafee.ssm.Eupdate.plist" # root | McAfee/AntiMalware/VShieldUpdate | deamon | unloadable
MCAFEE_AGENT_SCANFACTORY_PLIST="/Library/LaunchDaemons/com.mcafee.ssm.ScanFactory.plist" # root | McAfee/AntiMalware/VShieldScanner | deamon | unloadable
MCAFEE_AGENT_SCANMANAGER_PLIST="/Library/LaunchDaemons/com.mcafee.ssm.ScanManager.plist" # root | McAfee/AntiMalware/VShieldScanManager.app | deamon | unloadable
MCAFEE_AGENT_VIRUSSCAN_PLIST="/Library/LaunchDaemons/com.mcafee.virusscan.fmpd.plist" # root | McAfee/fmp/bin64/fmpd | deamon | unloadable
# AGENTS
MCAFEE_MENULET_PLIST="/Library/LaunchAgents/com.mcafee.menulet.plist" # user | McAfee/MSS/Applications/Menulet.app | agent | unloadable
MCAFEE_REPORTER_PLIST="/Library/LaunchAgents/com.mcafee.reporter.plist" # user | McAfee Reporter.app | agemt | unloadable
# MCAFEE_UNINSTALL_SYSTEMEXTENSTION_PLIST="/Library/LaunchAgents/com.mcafee.uninstall.SystemExtension.plist" # root | McAfee deactivatesystemextension | agent | not unloadable
# APPS
# MCAFEE_VSCONTROL_APP=sudo /usr/local/McAfee/AntiMalware/VSControl stopoas
# MCAFEE_VSCONTROL_APP= sudo /usr/local/McAfee/AntiMalware/VSControl stop
