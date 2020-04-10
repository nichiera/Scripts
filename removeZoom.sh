#!/bin/bash

# This program will uninstall zoom

#################
### Variables ###
#################

# Items at the system level to be removed
systemItems=(
	/Applications/zoom.us.app
	/Library/Internet\ Plug-Ins/ZoomUsPlugIn.plugin
)

# Items at the user level to be removed
userItems=(
	Applications/zoom.us.app
	Library/Application\ Support/zoom.us
	Library/Logs/zoominstall.log
	Library/Logs/zoom.us
	Library/Preferences/us.zoom.xos.plist
	Library/Internet\ Plug-Ins/ZoomUsPlugIn.plugin
	Downloads/Zoom*
)

#################
### Functions ###
#################

function deleteItems()
{
	declare -a toDelete=("${!1}")

	for item in "${toDelete[@]}"
		do
			if [[ ! -z "${2}" ]]
				then
					item=("${2}""${item}")
			fi

			echo "Looking for $item"

			if [ -e "${item}" ]
				then
					echo "Removing $item"
					rm -rf "${item}"
			fi
		done
}

####################
### Main Program ###
####################

# Kill the apps, if they are running
echo "Killing zoom apps"
killall "zoom.us"

# Delete system level items
deleteItems systemItems[@]

# Delete user level items
for dirs in /Users/*/
		do
			deleteItems userItems[@] "${dirs}"
		done

exit 0