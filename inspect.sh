#!/bin/sh

#------------------------#
# Search for deamons, plists and Installtion file on current systems
#------------------------#
prepare() {

    findFiles;
}

#inspectDeamons() {
    
    # PROCESS=$(ps -Ac | /bin/launchctl list | grep -m1 'airwatch' | awk '{print $1}')
    
    # deamonNameArray
#}

findFiles() {
    for t in ${applicationsArray[@]}; do

        # loop through sudo- & system Launch folders
        for v in ${plistPathArray[@]}; do            

            array=()
            # find files in folder defined 
            find $v -name "${t}*" -print0 >tmpfile
            while IFS=  read -r -d $'\0'; do
                echo $REPLY
                array+=("$REPLY")
            done <tmpfile
            rm -f tmpfile

        done

        # User folder
        # echo $HOME
        # echo find "$HOME/$t" -name "'$t*'" -print
        # CHECK="$(find $v -name '$t*')"
        # echo $CHECK

    done
}

#inspectInstallationFile(){

#}
