#!/boldIntensityn/sh

# Users
LOCAL_USER=$USER
SUDO_USER=$SUDO_USER

#------------------------#
# Logfile
#------------------------#
USER_LOG_FOLDER=".stop-sauron"
USER_LOG_FILE="debug.log"

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
# Colours
#------------------------#
colorOff='\033[0m'       # Text Reset

# Regular Colors
black='\033[0;30m'        # Black
red='\033[0;31m'          # Red
green='\033[0;32m'        # Green
yellow='\033[0;33m'       # Yellow
blue='\033[0;34m'         # Blue
purple='\033[0;35m'       # Purple
cyan='\033[0;36m'         # Cyan
white='\033[0;37m'        # White

# Bold
boldBlack='\033[1;30m'       # Black
boldRed='\033[1;31m'         # Red
boldGreen='\033[1;32m'       # Green
boldYellow='\033[1;33m'      # Yellow
boldBlue='\033[1;34m'        # Blue
boldPurple='\033[1;35m'      # Purple
boldCyan='\033[1;36m'        # Cyan
boldWhite='\033[1;37m'       # White

# Underline
underlineBlack='\033[4;30m'       # Black
underlineRed='\033[4;31m'         # Red
underlineGreen='\033[4;32m'       # Green
underlineYellow='\033[4;33m'      # Yellow
underlineBlue='\033[4;34m'        # Blue
underlinePurple='\033[4;35m'      # Purple
underlineCyan='\033[4;36m'        # Cyan
underlineWhite='\033[4;37m'       # White

# Background
onBlack='\033[40m'       # Black
onRed='\033[41m'         # Red
onGreen='\033[42m'       # Green
onYellow='\033[43m'      # Yellow
onBlue='\033[44m'        # Blue
onPurple='\033[45m'      # Purple
onCyan='\033[46m'        # Cyan
onWhite='\033[47m'       # White

# High Intensity
intensityBlack='\033[0;90m'       # Black
intensityRed='\033[0;91m'         # Red
intensityGreen='\033[0;92m'       # Green
intensityYellow='\033[0;93m'      # Yellow
intensityBlue='\033[0;94m'        # Blue
intensityPurple='\033[0;95m'      # Purple
intensityCyan='\033[0;96m'        # Cyan
intensityWhite='\033[0;97m'       # White

# Bold High Intensity
boldIntensityBlack='\033[1;90m'      # Black
boldIntensityRed='\033[1;91m'        # Red
boldIntensityGreen='\033[1;92m'      # Green
boldIntensityYellow='\033[1;93m'     # Yellow
boldIntensityBlue='\033[1;94m'       # Blue
boldIntensityPurple='\033[1;95m'     # Purple
boldIntensityCyan='\033[1;96m'       # Cyan
boldIntensityWhite='\033[1;97m'      # White

# High Intensity backgrounds
onIntensityBlack='\033[0;100m'   # Black
onIntensityRed='\033[0;101m'     # Red
onIntensityGreen='\033[0;102m'   # Green
onIntensityYellow='\033[0;103m'  # Yellow
onIntensityBlue='\033[0;104m'    # Blue
onIntensityPurple='\033[0;105m'  # Purple
onIntensityCyan='\033[0;106m'    # Cyan
onIntensityWhite='\033[0;107m'   # White
