import os
import sys

# PSM - ok this stuff isn't used yet, so don't import
# import quilt
# from quilt.push import quilt.push
# from quilt import push

PATCH_DIR = os.getcwd() + "/patches"

# The argument should be the directory of the Firefox source code
SOURCE_DIR = os.getcwd() + "/" + sys.argv[1]

# Open existing patches, change mozilla-release to the given source code 
# directory, and make new patch files in a new patch directory.
patchlist = os.listdir(PATCH_DIR)
patchlist = [n for n in patchlist if ".diff" in n and '~' not in n]

# If there isn't an existing patch directory for the given argument, make one
os.makedirs(SOURCE_DIR+"_patches", exist_ok=True)

for n in patchlist:
    fin = open(PATCH_DIR+"/"+n, "r")
    fout = open(SOURCE_DIR+"_patches/"+n, "w")
    for line in fin:
        fout.write(line.replace('mozilla-release', sys.argv[1]))
    fin.close
    fout.close

# Copy the series file into the new directory

series = [n for n in os.listdir(PATCH_DIR) if "series" in n]
fin = open(PATCH_DIR+"/"+series[0], "r")
fout = open(SOURCE_DIR+"_patches/"+series[0], "w")
for line in fin:
    fout.write(line)
fin.close
fout.close

# Edit the quilt_patch file to point to the new patch directory
QUILT_DIR = os.getcwd() + "/.pc"
fout = open(QUILT_DIR + "/.quilt_patches", "w")
fout.write(sys.argv[1]+"_patches")
fout.close


# Apply the patches with Quilt

#push = quilt.push(os.getcwd(), QUILT_DIR, SOURCE_DIR+"_patches")
#try:
#    push.apply_all()
#except:
#    print("Error when applying patches")
