#!/bin/sh

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