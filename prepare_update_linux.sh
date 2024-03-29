#!/bin/bash
ROOTDIR="../miff"
UPDATE_DIR=obj*linux*"/dist/firefox"

# The version number is required for the MAR commands
if [ $# -eq 0 ]; then
    { echo "You need to pass the version number to create the update package"; } 2> /dev/null
    exit 1
fi

if [[ -e $ROOTDIR/private.pem ]]; then
    { echo "Sanity check the update RSA key is present"; } 2> /dev/null
else
    { echo "Update RSA key not in m041"; } 2> /dev/null
    exit 1
fi

# m041 needs to be parallel, and we just sanity check the main browser target
if [[ -d $ROOTDIR ]] && [[ -d "./browser/branding" ]]; then
    ####################
    # Update Packaging #
    ####################

    mkdir tmp
    cd $UPDATE_DIR
    mv firefox-bin miff-bin
    mv firefox miff
    cd ../../../
    # We need to use signmar to get updatev3.manifest,
    # but we have to use the MAR Python tool to sign
    echo "=== Generating manifest for MAR"
    touch obj*linux*"/dist/firefox/precomplete"
    # make_signed_update.sh is generated by one of our
    # quilt patches, so it doesn't have proper execute
    # permissions
    chmod u+x tools/update-packaging/make_signed_update.sh
    MAR=obj*linux*"/dist/bin/signmar" MAR_CHANNEL_ID=default MOZ_PRODUCT_VERSION=$1 ./tools/update-packaging/make_signed_update.sh tmp.mar obj*"/dist/firefox"
    cp obj*linux*"/dist/firefox.work/"*.manifest tmp/
    cp -r $UPDATE_DIR/* tmp/

    echo "=== Creating MAR"
    cd tmp

    mar -J -c ../MiFF-$1.complete.mar -k "../../miff/private.pem" -H default -V $1 *
    cd ..
    echo "=== MAR complete"
    echo "=== Use these values for linux-update.xml in m021"
    shasum --algorithm 512 MiFF-$1.complete.mar
    stat --format="%s" MiFF-$1.complete.mar
    rm -rf tmp
else
    { echo "You need to be at the root location of the browser, and '../miff' alongside you"; } 2> /dev/null
fi
