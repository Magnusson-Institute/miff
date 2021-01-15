#!/bin/bash -x
ROOTDIR="../m041"

# m041 needs to be parallel, and we just sanity check the main browser target
if [[ -d $ROOTDIR ]] && [[ -d "./browser/branding" ]]; then
    cp $ROOTDIR/copy_files/setup.ico ./other-licenses/7zstub/firefox/setup.ico
    cp $ROOTDIR/copy_files/icon-logo-settings-preview.png ./browser/fxr/content/assets/icon-logo-settings-preview.png
    cp $ROOTDIR/copy_files/default64.png ./browser/branding/unofficial/default64.png
    cp $ROOTDIR/copy_files/default32.png ./browser/branding/unofficial/default32.png
    cp $ROOTDIR/copy_files/wizWatermark.bmp ./browser/branding/unofficial/wizWatermark.bmp
    cp $ROOTDIR/copy_files/wizHeaderRTL.bmp ./browser/branding/unofficial/wizHeaderRTL.bmp
    cp $ROOTDIR/copy_files/VisualElements_70.png ./browser/branding/unofficial/VisualElements_70.png
    cp $ROOTDIR/copy_files/wizHeader.bmp ./browser/branding/unofficial/wizHeader.bmp
    cp $ROOTDIR/copy_files/firefox.ico ./browser/branding/unofficial/firefox.ico
    cp $ROOTDIR/copy_files/default22.png ./browser/branding/unofficial/default22.png
    cp $ROOTDIR/copy_files/VisualElements_150.png ./browser/branding/unofficial/VisualElements_150.png
    cp $ROOTDIR/copy_files/about-logo.svg ./browser/branding/unofficial/content/about-logo.svg
    cp $ROOTDIR/copy_files/about-logo@2x.png ./browser/branding/unofficial/content/about-logo@2x.png
    cp $ROOTDIR/copy_files/about-logo.png ./browser/branding/unofficial/content/about-logo.png
    cp $ROOTDIR/copy_files/default16.png ./browser/branding/unofficial/default16.png
    cp $ROOTDIR/copy_files/default256.png ./browser/branding/unofficial/default256.png
    cp $ROOTDIR/copy_files/default48.png ./browser/branding/unofficial/default48.png
    cp $ROOTDIR/copy_files/default24.png ./browser/branding/unofficial/default24.png
    cp $ROOTDIR/copy_files/firefox64.ico ./browser/branding/unofficial/firefox64.ico
    cp $ROOTDIR/copy_files/default128.png ./browser/branding/unofficial/default128.png
    cp $ROOTDIR/copy_files/avatar-color.svg ./browser/themes/shared/fxa/avatar-color.svg
else
    # in case you're wondering, this is a trick to not double-echo with '-x'
    { echo "You need to be at the root location of the browser, and '../m041' alongside you"; } 2> /dev/null
fi
