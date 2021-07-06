# MiFF build - with patches

## Win10 build setup

When installing, the following workloads must be checked:

* “Desktop development with C++” (under the Windows group)

* “Game development with C++” (under the Mobile & Gaming group)

In addition, go to the Individual Components tab and make sure the
following components are selected under the “SDKs, libraries, and
frameworks” group:

* “Windows 10 SDK” (at least version 10.0.17134.0)

* “C++ ATL for v142 build tools (x86 and x64)” (also select ARM64 if
  you’ll be building for ARM64)


### Set up Cygwin

In Windows, we work in either Moz Shell for all the build tools from Mozilla (see
below), and Cygwin64 for all of our own tooling (git, quilt, various
shellscripts, etc).

Install the following packages in Cygwin:

* git
* quilt
* p7zip

## Ubuntu build setup

First, install Python (3.6 or later): ```sudo apt install python3 python3-dev```

The Firefox documentation recommends downloading Mercurial through pip, but apt works as well. Run either command:

```
python3 -m pip install --user mercurial
sudo apt install mercurial
```

You will also need to install yasm and libgtk2.0-dev through ```apt```.

The rest of the process is similar to a Windows setup, but all commands can be done from the Ubuntu terminal.


## Check out with Mercurial

Work environment is in "/mozilla-source" (MozDev "/c/mozilla-source"
and Cygwin "/cygdrive/c/mozilla-source"

Mozilla Firefox release tags are here, if you want a specific
(release) version:

https://hg.mozilla.org/releases/mozilla-release/tags

Or just take the head:

```
mkdir /c/mozilla-source
cd /c/mozilla-source
hg clone https://hg.mozilla.org/releases/mozilla-release/
```

Then 'bootstrap' all the tools and configurations needed, follow
instructions along these lines:

```shell
cd /c/mozilla-source/mozilla-release
./mach bootstrap
./mach build
./mach run
```

Once the above works, you have a dev environment (Mozilla
tooling). That confirms a working build environment. However, the toolchains
are specific to the *latest* version. If you are working with a tarball more
than a few versions behind the release head, you may have issues building the
tarball. Furthermore, on Windows 'bootstrap' is very dependent on your Visual
Studio install. Updating Visual Studio tends to break the build command
entirely, and you will have to run 'bootstrap' again (which, if you haven't
pulled from the mozilla-release head recently, will probably lead back to the
first problem).

For future - check out "hg help -e fsmonitor")

## Take a specific tarball

Now grab a specific version that we have patch support for.  Currently
that is only 84.0.2:

archive.mozilla.org/pub/firefox/releases/84.0.2/source/

And download the compressed (xz) tar ball.  Untar it alongside
mozilla-release and move 'm041' right next to it, should eventually
get something like this

```
/c/mozilla-source/bootstrap.py
/c/mozilla-source/mozilla-release/
/c/mozilla-source/firefox-84.0.2/
/c/mozilla-source/m041/
```

Next, go to the specific release (84.0.2 in this case) and build it
clean:

```
cd /c/mozilla-source/firefox-84.0.2
./mach build
./mach run
```

That should be analogous to the mozilla-release setup, note that you
don't need to do "bootstrap".

Note also, you need to pick a matching m041 "release"; for 84.0.2, as
in this example, then this (tagged) version would be the correct
patch tarball to start with:

https://github.com/Magnusson-Institute/m041/archive/refs/tags/v84.0.2.4.tar.gz

## MiFF patches / changes

There are two sources of changes:

* File patches, these are encompassed by the `m041/patches/*.diff`
  files, and managed with `quilt`.

* Replacement files.  These are listed in `m041/copy_files/` and are
  copied over with `copy_files.sh` into the firefox source tree.

If you're just applying changes and patches and re-building, do
something like this:

```
cd /c/mozilla-source/firefox-84.0.2
../m041/copy_files.sh
ln -s ../m041/patches .
quilt push -a
./mach build
./mach run
```

### Working with the update patch (patch #12)

If you have not run ```./mach build``` before, quilt will fail trying
to apply 12_updates.diff. The build process creates several generated
files on a first run, including the certificates for update validation.
You will need to run ```./mach build``` first, then apply patch 12 and
beyond.

There is an additional step if you are not working in a Windows
environment. The first build creates an obj-\* folder, where all the
generated files live. The name of this folder is different on each OS.
For non-Windows systems, create a symbolic link to your platform's
obj-\* folder named ```obj-x86_64-pc-mingw32``` and the patch will
apply correctly.

### Working with the release patch (patch #99)

The final patch in the series is used to disable debug features and to
track the version number. If you are working on development you will want
to leave this patch unapplied. Before creating a release/update, set the
appropriate version number in this patch and create a matching tag on Github.

And you should have a working, re-branded Firefox.

# To make modifications yourself

First make sure you've done the above steps. 'm041' needs to be
alongside your build directory, you need a symbolic link to 'patches',
etc.

For example, if you want to start making changes to 'aboutDialog.ftl'.
First, apply patches and file replacements as per above. Then:

```bash
cd /mozilla-source/firefox-84.0.2
quilt new NN_description_of_changes.diff
quilt add browser/locales/en-US/browser/aboutDialog.ftl 
```

Where 'NN' is a new (higher) patch number than what is already in
`m041/patches/series`. Quilt will only track changes made *after* a file is added to a patch.

Now make some edits to this file (aboutDialog.ftl). Then refresh the patch file:

```bash
quilt refresh
```

That will create an 'NN' patch file.

### To work with an existing patch / set of changes

You will need to selectively 'quilt push' until you are at the patch
file you want to be using to cluster your changes.  Make sure the
file(s) you are working with are referenced in that patch file (if not
add them with `quilt add <filename>`.


### Some principles

* Try labeling changes with the "MagIns NN" string
  where 'NN' is the patch (diff) file
  (it will be unique, does not exist in FF source code)
* Try not just deleting or replacing things, but comment out the
  old code, so that when continuing to work with the resulting
  modified files, you can see what's been done (roughly)


## Set up on Mac OS X (m1)

_(This is under development)_

Very similar to Ubuntu, obviously, but enough differences that this will be self-contained:

_(It's (currently) unclear if FF on m1 should be built native or
cross-platform. One confusion is in trying between these, the
"~/.mozbuild" probably gets populated with conflicting tools?
This is currently being done on an 'x86' environment/terminal.)_

First, create a working directory where you want to work, here we'll call it "~/dev/ff01"; create it and bootstrap:

```
mkdir ~/dev/ff01
cd ~/dev/ff01
curl https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py -O
python3 bootstrap.py
```

Press "enter" for destination, for default; so it'll start in
"~/ff01/mozilla-unified" in this example.  Mercurial will pull from
"https://hg.mozilla.org/mozilla-unified"; which is full tree. We will build that first,
then later we can get more clever and build from tar files. Follow instructions from script, then
make sure to start a new terminal so all the settings have taken effect.

The various tooling specific to FF build will be set up by the above bootstrap in ```~/.mozbuild/```

The C++ tools used to build on Mac are based off Xcode; so first
install latest version of Xcode from the App Store, then finalize it's
installation from command line, and install Mercurial (and make sure
your python is 3.8.x)

```
sudo xcode-select --switch /Applications/Xcode.app
sudo xcodebuild -license
echo "export PATH=\"$(python3 -m site --user-base)/bin:$PATH\"" >> ~/.zshenv
python3 -m pip install --user mercurial
hg version
```

Do *not* run "brew install mercurial", that's something else, it will
drag in newer versions of Python (3.9.x) etc.

HOWEVER. Your "latest version" of Xcode will probably have an SDK that
is too modern. So you need to "downgrade" locally for Moz.  At time of
writing, their _documentation_
(https://firefox-source-docs.mozilla.org/setup/macos_build.html#macos-sdk-is-unsupported)
states that they are using the 10.12 SDK, but their _error messages_
state that they support the 11.1 SDK.

(Apple documentation on the different versions is summarized here:
```https://developer.apple.com/support/xcode/#minimum-requirements``` ).

The older (documentation) instructions suggests pulling 10.12 SDK from
Xcode 8.2. We will go with that for now. Download:

```https://download.developer.apple.com/Developer_Tools/Xcode_8.2/Xcode_8.2.xip```

It's big (4.2 GB), unzip and pull out the 10.12 SDK by "opening" the
file - it'll look like an xcode app copy in your Download folder, but
it's "really" directory tree under ~/Downloads/Xcode.app:

```
mkdir -p ~/.mozbuild/macos-sdk
# This assumes that Xcode is in your "Downloads" folder
cp -aH ~/Downloads/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk ~/.mozbuild/macos-sdk/
```

And add the following line to the "mozconfig" file (which will be
created if it's not there); should be in your FF source code
directory:

```
echo "ac_add_options --with-macos-sdk=$HOME/.mozbuild/macos-sdk/MacOSX10.12.sdk" >> ~/dev/ff01/mozilla-unified/mozconfig
```

Again, make sure to start a new terminal so all the settings have
taken effect, and then you should be able to start the (huge) build:

```
cd ~/dev/ff01/mozilla-unified
./mach build
./mach run

# if you want to try to package it, you would also:
# ./mach package
```

the object tree will be in:

```
~/dev/ff01/mozilla-unified/obj-x86_64-apple-darwin20.5.0
```

Next, build the same (or very similar) version of FF from a clean
source code tarball. Make sure to match (exactly) the tagged version
in m041 (e.g. from top of
```https://github.com/Magnusson-Institute/m041/releases```).

In this case, our latest m041 tag is "89.0.0.1", which matches Mozilla FF tag "89.0" (the fourth
digit ".1" is our internal release schedule, tracking FF). So in this case, download
```https://archive.mozilla.org/pub/firefox/releases/89.0/source/firefox-89.0.source.tar.xz```,
download our own (tagged) m041 tarball, and place it alongside, extract all the tarballs, net
result should look like:

```
~/dev/ff01/mozilla-unified/...
~/dev/ff01/firefox-89.0/..
~/dev/ff01/m041-89.0.0.1/...
```

First re-build clean 89.0 by itself _without_ applying any patches, to make sure your build environment
is all working:

```
# examples assume this root dev directory
cd ~/dev/ff01

# if you haven't extracted it yet:
tar xzf ./firefox-89.0.source.tar.xz

cd firefox-89.0

# remember to update/create mozconfig:
echo "ac_add_options --with-macos-sdk=$HOME/.mozbuild/macos-sdk/MacOSX10.12.sdk" >> ./mozconfig

# now this should work:
./mach build
./mach run
```

Now you can apply the patches:

```
# make sure we're in the right place
cd ~/dev/ff01

# first, even if it's a tarball, needs to be called 'm041':
mv m041-89.0.0.1 m041

# make sure you're in the right spot
cd ~/dev/ff01/firefox-89.0

# first copy the files that are meant to outright over-write:
../m041/copy_files.sh

# make sure your actual "obj" directory can be reached from the reference directory:
# (otherwise some patches will break)
ln -s obj-x86_64-apple-darwin20.5.0 obj-x86_64-pc-mingw32

# now soft-link our patch system and apply them
ln -s ../m041/patches .
quilt push -a

# the above will fail on Patch 12, that's ok, first build with patches 1-11:
./mach build
./mach run

# then apply Patches 12+ and build again
quilt push -a
./mach build
./mach run

# and if that all looks good, build a .dmg,
# the result will be in obj-*/dist
./mach package
```

And there we go (first build per above steps: 20210704).




## TODO:

* [PSM 07/05]: need to update
```locales/en-US/toolkit/about/aboutRights.ftl``` to correctly
position MiFF, including referencing our overall privacy policy.

* [PSM 07/05]: these need to be changed to 'miff-help':
```
	browser/base/content/aboutDialog.xhtml
130	<label is="text-link" onclick="openHelpLink('firefox-help')" data-l10n-id="aboutdialog-help-user"/>
browser/base/content/browser-menubar.inc
467	oncommand="openHelpLink('firefox-help')"
browser/base/content/browser.js
2601	openHelpLink("firefox-help");
```
and a matching ```privacy.app/supportmiff-help``` endpoint added (i think that's where they'll go,
thought right now it looks like still landing on ```https://privacy.app/supportfirefox-help```)

* [PSM 07/05]: i _think_ we should replace all occurrences of
  "mozilla.org" or "firefox.com" to "privacy.app" in file
  ```source/browser/app/profile/firefox.js```; note that many have already been
  modified with "MagIns" explanations.

* [PSM 07/05]: need an endpoint for ```https://privacy.app/contribute/```

* [PSM 07/05]: i am currently experimenting with using these additional lines in the "mozconfig" file:
```
# this fixes -DMOZ_DISTRIBUTION_ID="org.mozilla"
ac_add_options --with-distribution-id=app.privacy

# this fixes -DMOZ_MACBUNDLE_ID=org.mozilla.nightly
ac_add_options --with-macbundlename-prefix=app.privacy

# this might help:
ac_add_options --with-branding=browser/branding/unofficial

# unsure if this needs fixing? -DMOZ_USER_DIR="Mozilla" 
```
as well as one change, and one addition, to "browser/branding/unofficial/configure.sh":
```
#MOZ_APP_DISPLAYNAME=Nightly
# MagIns - changed
MOZ_APP_DISPLAYNAME=Miff
# MagIns - added, not sure (yet) if it makes much difference:
MOZ_APP_VENDOR=PrivacyApp
```
they might help on a Mac (or Mobile) build.

## Resources:

https://firefox-source-docs.mozilla.org/setup/windows_build.html#building-firefox-on-windows

https://firefox-source-docs.mozilla.org/contributing/vcs/mercurial.html

