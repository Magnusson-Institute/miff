#!/bin/bash
ROOTDIR="../m041"
INSTALLER_DIR=obj*"/dist/install/sea"
UPDATE_DIR=obj*"/dist/firefox"

# m041 needs to be parallel, and we just sanity check the main browser target
if [[ -d $ROOTDIR ]] && [[ -d "./browser/branding" ]]; then
    if [ $# -eq 0 ]; then
	{ echo "You need to pass the version number to create the update package"; } 2> /dev/null
	exit 1
    else
	####################
	# Update Packaging #
	####################

	# Need to do some of the same resource hacking for the update package
	echo "=== Creating update package"
	cp $ROOTDIR"/ResourceHacker/"miff.exe.* $UPDATE_DIR
	cd $UPDATE_DIR
	echo "=== Applying third Resource Hacker script"
	cygstart -w "C:/Program Files (x86)/Resource Hacker/ResourceHacker.exe" -open miff.exe.StringTable7.rc -action compile
	cygstart -w "C:/Program Files (x86)/Resource Hacker/ResourceHacker.exe" -open miff.exe.VersionInfo1.rc -action compile
	cygstart -w "C:/Program Files (x86)/Resource Hacker/ResourceHacker.exe" -script miff.exe.script.txt
	rm miff.exe.* firefox.exe
	echo "=== You'll need to build/package before running this script again"

	echo "=== Before building a MAR, the branded executable, updater.exe, and maintenanceservice.exe must be signed"
	read -p "=== Press ENTER once you have done this"

	# Now that the browser is branded, create a MAR with it
	cd ../../..
	echo "=== Generating MAR file"
	touch obj*"/dist/firefox/precomplete"

	MAR=obj*"/dist/host/bin/mar.exe" MAR_CHANNEL_ID=default MOZ_PRODUCT_VERSION=$1 ./tools/update-packaging/make_full_update.sh ../complete.mar obj*"/dist/firefox"
	echo "=== Update MAR complete"
    fi
else
    { echo "You need to be at the root location of the browser, and '../m041' alongside you"; } 2> /dev/null
fi
