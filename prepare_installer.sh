#!/bin/bash
ROOTDIR="../m041"
INSTALLER_DIR=obj*"/dist/install/sea"

# m041 needs to be parallel, and we just sanity check the main browser target
if [[ -d $ROOTDIR ]] && [[ -d "./browser/branding" ]]; then
    # Create a temporary folder to perform installer operations
    if ! type 7z > /dev/null; then
	{ echo "Cygwin needs the p7zip package installed"; } 2> /dev/null
	exit 1
    else
	mkdir 7zip
	cp $INSTALLER_DIR"/"*installer.exe 7zip/installer.exe
	cd 7zip
	echo "=== Extracting installer"
	7z x installer.exe
	cd ..

	# Copy Resource Hacker files to the installer location
	cp $ROOTDIR"/ResourceHacker/"miff.exe.* 7zip/core
	cp $ROOTDIR"/ResourceHacker/"updater.exe.* 7zip/core
	cp $ROOTDIR"/ResourceHacker/"installer.exe.* 7zip

	# Move to temporary directory and run first RH script
	cd 7zip/core
	echo "=== Applying Resource Hacker script for MiFF"
	cygstart -w "C:/Program Files (x86)/Resource Hacker/ResourceHacker.exe" -open miff.exe.StringTable7.rc -action compile
	cygstart -w "C:/Program Files (x86)/Resource Hacker/ResourceHacker.exe" -open miff.exe.VersionInfo1.rc -action compile
	cygstart -w "C:/Program Files (x86)/Resource Hacker/ResourceHacker.exe" -script miff.exe.script.txt

	echo "=== Applying Resource Hacker script for updater"
	cygstart -w "C:/Program Files (x86)/Resource Hacker/ResourceHacker.exe" -open updater.exe.VersionInfo1.rc -action compile
	cygstart -w "C:/Program Files (x86)/Resource Hacker/ResourceHacker.exe" -script updater.exe.script.txt

	# Make directory for extensions inside core/
	mkdir distribution
	cd ../..
	echo "=== Copying extension files into core/distribution"
	cp -r $ROOTDIR"/extensions/" 7zip/core/distribution

	# Also copy autoconfig files
	echo "=== Copying autoconfig files into core/"
	cp $ROOTDIR"/InstallerFiles/autoconfig.js" 7zip/core
	cp $ROOTDIR"/InstallerFiles/miff.cfg" 7zip/core

	# Gathering files to create self-extracting archive
	echo "=== Copying repackaging script and config file"
	cp other-licenses/7zstub/firefox/7zSD.Win32.sfx 7zip/7zSD.sfx
	cp $ROOTDIR"/InstallerFiles/repackage.bat" 7zip/repackage.bat
	cp $ROOTDIR"/InstallerFiles/config.txt" 7zip/config.txt

	# Clean up core and create a new archive
	rm 7zip/core/miff.exe.* 7zip/core/firefox.exe 7zip/core/updater.exe.*
	rm 7zip/core/updater.exe
	mv 7zip/core/miffupdater.exe 7zip/core/updater.exe
	cd 7zip
	echo "=== Creating tempInstaller.7z"
	7z a tempInstaller.7z core/ MiFFInstaller.exe
	# repackage.bat edits some branding aspects of the installer without breaking the .exe.
	chmod u+x repackage.bat
	echo "=== Running repackage.bat"
	./repackage.bat

	# Run second RH script
	echo "=== Applying Resource Hacker script for installer"
	cygstart -w "C:/Program Files (x86)/Resource Hacker/ResourceHacker.exe" -open installer.exe.VersionInfo1.rc -action compile
	cygstart -w "C:/Program Files (x86)/Resource Hacker/ResourceHacker.exe" -script installer.exe.script.txt

	# Installer changes are done, cleaning up the temp folder
	mv unsignedInstaller.exe ../unsignedInstaller.exe
	cd ..
	rm -rf 7zip
	echo "=== Installer is complete, unsignedInstaller.exe is in your FF root"
	echo "=== Need to sign miff.exe and MiFFInstaller.exe, add back to unsignedInstaller by hand,"
	echo "    then rename/sign unsignedInstaller"
    fi
else
    { echo "You need to be at the root location of the browser, and '../m041' alongside you"; } 2> /dev/null
fi
