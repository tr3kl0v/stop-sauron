#!/bin/sh

#------------------------#
# Logging
#------------------------#
WriteLog()
{
	/bin/echo `date`" --- "$1
}

#------------------------#
# Validating number
#------------------------#
isNumber()
{
    case $PROCESS in
        ''|*[!0-9]*) false ;;
        *) true ;;
    esac 
} 

#------------------------#
# Check if file exits
#------------------------#
isFile() {
    [ -f "$FILE" ]
}