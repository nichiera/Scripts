#!/bin/bash
#
# Check computer name is set properly and if not change it
# Created by Chase Garcia 
# 4/8/2020
#
# Variables for serial number and current computer name
sn=$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}')
currentCN=$(/usr/sbin/scutil --get ComputerName)
currentHN=$(/usr/sbin/scutil --get HostName)
currentLHN=$(/usr/sbin/scutil --get LocalHostName)

# Check to see if current name matches serial number
if [[ "$currentCN" != "$sn" || "$currentHN" != "$sn" || "$currentLHN" != "$sn" ]]; then
	echo "One or more values are set wrong: Serialnumber is $sn, Computername is $currentCN, Hostname is $currentHN, LocalHostname is $currentLHN"
# Check each one again and fix ones not set correctly	
	if [[ "$currentCN" != "$sn" ]]; then
		echo "Fixing computer name"
		/usr/sbin/scutil --set ComputerName $sn
	fi
		if [[ "$currentHN" != "$sn" ]]; then
			echo "Fixing host name"
			/usr/sbin/scutil --set HostName $sn
		fi
			if [[ "$currentLHN" != "$sn" ]]; then
				echo "Fixing local host name"
				/usr/sbin/scutil --set LocalHostName $sn
			fi
else
	echo "All names set correctly. Exiting"
fi

exit 0