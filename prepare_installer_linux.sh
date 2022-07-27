#!/bin/bash
ROOTDIR="../miff"
INSTALLER_DIR="obj-x86_64-pc-linux-gnu/dist"

# The version number is required to name the installer
if [ $# -eq 0 ]; then
    { echo "You need to pass the version number to create the update package"; } 2> /dev/null
    exit 1
fi

# miff needs to be parallel
if [[ -d $ROOTDIR ]] && [[ -d "./browser/branding" ]]; then
    # Create a temporary folder to perform installer operations
    if ! type tar > /dev/null; then
	{ echo "Need tar package installed"; } 2> /dev/null
	exit 1
    else
	echo "=== Creating installer"
	./mach package

	mkdir tar
	cp $INSTALLER_DIR"/"*tar.bz2 tar/installer.tar.bz2
	cd tar
	echo "=== Extracting installer"
	tar -xvf installer.tar.bz2

	echo "=== Copying extension files into firefox/distribution"
	cd firefox
	mkdir distribution
	cd ../..
	cp -r $ROOTDIR"/extensions/" tar/firefox/distribution

	echo "=== Renaming files"
	cd tar/firefox
	mv firefox miff
	mv firefox-bin miff-bin
	cd ..
	mv firefox miff
	
	echo "=== Creating new installer"
	tar -cjvf MiFF-Installer.tar.bz2 miff
	mv MiFF-Installer.tar.bz2 ../../
	cd ..
	rm -rf tar
    fi
else
    { echo "You need to be at the root location of the browser, and '../miff' alongside you"; } 2> /dev/null
fi
