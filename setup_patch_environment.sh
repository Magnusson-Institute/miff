#!/usr/bin/bash
PYTHON="python3.8.exe"
ROOTDIR=$1

if [[ -d $ROOTDIR ]]; then
    mkdir -p .pc
    ${PYTHON} ./setup_patch_environment.py $ROOTDIR
else
    echo "First parameter must be the root directory of your Moz Firefox source code tree"
fi

