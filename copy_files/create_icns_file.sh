#!/bin/sh -x

# if you need to re-create the "firefox.icns" file, this is the place to start
# we're not version controlling the intermediate png files, just this script
# together with the final result (firefox.icns)

# you need 'brew install imagemagick' first

# Apple documentation (more info than you need) is here:
# https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/HighResolutionOSX/Optimizing/Optimizing.html

# the png files are assembled in a directory
mkdir -p firefox.iconset

# 'about-logo.svg' is our browser icon in vector
convert about-logo.svg -resize 256x256 firefox.iconset/firefox

# these are sizes needed by mac builds
convert about-logo.svg -resize 16x16 firefox.iconset/icon_16x16.png
convert about-logo.svg -resize 32x32 firefox.iconset/icon_32x32.png
convert about-logo.svg -resize 128x128 firefox.iconset/icon_128x128.png
convert about-logo.svg -resize 256x256 firefox.iconset/icon_256x256.png
convert about-logo.svg -resize 512x512 firefox.iconset/icon_512x512.png

# these are 2x versions needed for retina displays
convert about-logo.svg -resize 32x32 firefox.iconset/icon_16x16@2x.png
convert about-logo.svg -resize 64x64 firefox.iconset/icon_32x32@2x.png
convert about-logo.svg -resize 256x256 firefox.iconset/icon_128x128@2x.png
convert about-logo.svg -resize 512x512 firefox.iconset/icon_256x256@2x.png
convert about-logo.svg -resize 1024x1024 firefox.iconset/icon_512x512@2x.png

# now run magical conversion:
iconutil -c icns firefox.iconset
