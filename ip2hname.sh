#!/bin/bash

logFile=$1
while read line
do
        for word in $line
        do
        # if word is ip address change to hostname
        if [[ $word =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]
        then
            a=`host $word | cut -d' ' -f 5 | sed 's/.$//'` 
	    if [[ "$a" == "3(NXDOMAIN" ]]
	    then
		echo "$word"
	    else
		echo -n `host $word | cut -d' ' -f 5 | sed 's/.$//'`
                echo
	    fi
#	echo -n " "
        else
            echo -n "$word"
            echo -n " "
        fi
        done
        
done < "$logFile"
