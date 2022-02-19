# MiFF

MiFF[^1] is lightway approach to replace Mozilla and Google (and
any other) service dependencies from Mozilla Firefox (GeckoView),
including removing anything resembling "phone home", as well as some
modifications to certain settings. Note that we "replace" service
dependencies, we don't "remove" them. Default build is to use
https://Privacy.App as backend replacement for service dependencies,
but you can run [your own backend
instance](https://github.com/magnusson-institute/miff-backend).

This project was partly inspired by the [ungoogled-chromium
project](https://github.com/Eloston/ungoogled-chromium) and borrows
from their methodology.


## Latest MiFF versions

We host latest builds on ``cdn.privacy.app``, updates are signed and
provided as well (once you've installed MiFF, updates should "just
work").

* [Windows (v92.x)](https://cdn.privacy.app/miffrelease/MiFF-92.0.0.1.exe)
* [MacOS (v89.x)](https://cdn.privacy.app/miffrelease/MiFF-89.0.0.1.en-US.mac.dmg)
* [Linux (v92.x)](https://cdn.privacy.app/miffrelease/MiFF-92.0.0.1.tar.bz2)


## Older MiFF versions

Source code releases are [tagged on
github](https://github.com/Magnusson-Institute/miff/tags). Not all
versions are supported for all targets. Expand below for details.  We
track Firefox releases [shortly after Mozilla releases
them](https://www.mozilla.org/en-US/firefox/releases/).

<!-- TODO: add system requirements -->

<details>
<summary><b>Click to expand/collapse</b></summary>
<!-- MarkdownMiffVersions -->

### v96.0.1.1

*Latest* - binaries not packaged yet.

MiFF Source: https://github.com/Magnusson-Institute/miff/releases/tag/v96.0.1.1

Matching Firefox release notes: https://www.mozilla.org/en-US/firefox/96.0.1/releasenotes/

Matching Firefox Source: https://archive.mozilla.org/pub/firefox/releases/96.0.1/source/firefox-96.0.1.source.tar.xz


### v92.0.0.1

Windows installer: https://cdn.privacy.app/miffrelease/MiFF-92.0.0.1.exe

Linux: https://cdn.privacy.app/miffrelease/MiFF-92.0.0.1.tar.bz2

Source: https://github.com/Magnusson-Institute/miff/releases/tag/v92.0.0.1

Matching Firefox release notes: https://www.mozilla.org/en-US/firefox/92.0/releasenotes/


### v89.0.2.3

MacOS installer: https://cdn.privacy.app/miffrelease/MiFF-89.0.0.1.en-US.mac.dmg
(note: this is v89.0.0.1).

Source: https://github.com/Magnusson-Institute/miff/releases/tag/v89.0.2.3

Matching Firefox release notes: https://www.mozilla.org/en-US/firefox/89.0.2/releasenotes/

Earlier point releases for v89.0.2.x:

* https://github.com/Magnusson-Institute/miff/releases/tag/v89.0.2.2
* https://github.com/Magnusson-Institute/miff/releases/tag/v89.0.2.1

### v89.0.0.1

Matching Firefox release notes: https://www.mozilla.org/en-US/firefox/89.0/releasenotes/

Source: https://github.com/Magnusson-Institute/miff/releases/tag/v89.0.0.1

### v84.0.2.4

Source: https://github.com/Magnusson-Institute/miff/releases/tag/v89.0.2.4

Matching Firefox release notes: https://www.mozilla.org/en-US/firefox/84.0.2/releasenotes/

<!-- MarkdownMiffVersions -->



# Table of Contents

<!-- MarkdownTOC -->
1. [Introduction](#introduction)
1. ["Patches"](#patches)
1. [My Instructions](#my-instructions)
1. [Alfa Driver DVDs](#alfa-driver-dvds)
    1. [Disk 1: ALFA_Driver_DVD_old](#disk-1-alfa_driver_dvd_old)
    1. [Disk 2: ALFA_Driver_DVD_v3.0](#recommended)
    1. [Disk copy instructions on Linux](#disk-copy-instructions-on-linux)
1. [License](#license)
1. [Driver Installation Instructions on Linux](#driver-installation-instructions-on-linux)
    1. [1. Alfa AWUS036NH 2000mW Tx Power 2.4GHz USB Wi-Fi adapter](#1-alfa-awus036nh-2000mw-tx-power-24ghz-usb-wi-fi-adapter)
        1. [SPEED:](#speed)
        1. [INSTALL DRIVER:](#install-driver)
        1. [CONNECT AND CONFIGURE:](#connect-and-configure)
    1. [2. Alfa AWUS036AC 802.11ac Long Range AC1200 Dual Band 2.4GHz/5GHz WiFi USB adapter](#2-alfa-awus036ac-80211ac-long-range-ac1200-dual-band-24ghz5ghz-wifi-usb-adapter)
        1. [SPEED:](#speed-1)
        1. [INSTALL DRIVER:](#install-driver-1)
        1. [CONNECT AND CONFIGURE:](#connect-and-configure-1)

<!-- /MarkdownTOC -->
</details>




<a id="introduction"></a>

# Introduction

This project is built from Mozilla's open source GeckoView software.
This project is not affiliated with Mozilla Foundation, Mozilla Corporation, Google, or Alphabet.
If you make and/or distribute your own build of miff or miff-backend, please
respect Mozilla's guidelines.[^2]

MiFF is open source and distributed under MPL 2
(https://www.mozilla.org/en-US/MPL/2.0/), see the "LICENSE" file for
details.

Instructions for building for various targets:

* :ref:`MacOS (m1) build <m1_build>`

*TODO: add reference to the UK paper that runs browsers for 30 minutes; include our objective
to have zero internet accesses that were not initiated by user.*


<a id="patches"></a>

# "Patches"

All of MiFF's patches for the Gecko source code are located in the
``patches``:

* All patches follow naming conventions of ``NN_<description>.diff``.
* The ``patches/series`` file lists all patches, and the order
  in which they will be applied. By naming convention, they are
  applied in "NN" order.
  
Contents of the diff files follow the unified GNU diff format.[^3]

*Note: for many of the patch files, we include extensive comments on
all of the changes.*



## ``01_privacy``

* Disabling all telemetry

* Enabling a number of privacy settings

* Several changes to baseline configuration (towards more private)


## ``02_sso``

* Changes from Mozilla HAWK requests to XHR

* Changes from Mozilla endpoint names to Privacy.App endpoints
  (TODO: generalize this to ``miff-backend``)


## ``03_sync``

* Similar to ``02_sso`` but for sync requests
  

## ``04_connected_devices``

* Disabling device push and connected devices
  

## ``05_search``

* Removing Google as default search engine,
  replace with DuckDuckGo as default

* Adds StartPage as an option


## ``06_ui``

* Remove default bookmarks

* Removes recommended sites
  

## ``07_pocket``

* Remove pocket


## ``08_endpoints``

* Routing security or settings requests through Privacy.App
  (TODO: generalize to ``miff-backend``)


## ``09_support_links``

* Change help and support links to Privacy.App
  (TODO: generalize to ``miff-backend``)


## ``10_branding_text``

* Changing brand names to comply with Mozilla Trademark Guidelines[^2]
  (TODO: generalize to ``miff-backend``)


## ``11_various_branding``

* Changing brandind messages to comply with Mozilla Trademark Guidelines[^2]
  (TODO: generalize to ``miff-backend``)


## ``12_updates``

* Change update server to be from Privacy.App
  (TODO: generalize to ``miff-backend``)


## ``13_permissions``

* Some fixes to support web apps that require local storage
  but do not work with cookies - in particular so that
  ``snackabra`` (https://snackabra.io) and similar apps can work properly
  even with privacy settings dialed up



## ``99_disable_debug``

* Turns off browser debugger and other debugging tools
  (note: this is partly necessary from the workflow of developing
  for ``miff``, since we debug the above patches using those tools)




# Branches

master - active development; all releases (v92.x, v096.x, etc) are on the master

stable - mirror of tagged releases (in case you need to try building on new targets for example)




# Win10 build setup

When installing, the following workloads must be checked:

* “Desktop development with C++” (under the Windows group)

* “Game development with C++” (under the Mobile & Gaming group)

In addition, go to the Individual Components tab and make sure the
following components are selected under the “SDKs, libraries, and
frameworks” group:

* “Windows 10 SDK” (at least version 10.0.17134.0)

* “C++ ATL for v142 build tools (x86 and x64)” (also select ARM64 if
  you’ll be building for ARM64)


## Set up Cygwin

In Windows, we work in either Moz Shell for all the build tools from Mozilla (see
below), and Cygwin64 for all of our own tooling (git, quilt, various
shellscripts, etc).

Install the following packages in Cygwin:

* git
* quilt
* p7zip

# Ubuntu build setup

First, install Python (3.6 or later): ``sudo apt install python3 python3-dev``

The Firefox documentation recommends downloading Mercurial through pip, but apt works as well. Run either command:

```bash
python3 -m pip install --user mercurial
sudo apt install mercurial
```


You will also need to install yasm and libgtk2.0-dev through ``apt``.

The rest of the process is similar to a Windows setup, but all commands can be done from the Ubuntu terminal.


## Check out with Mercurial

Work environment is in "/mozilla-source" (MozDev "/c/mozilla-source"
and Cygwin "/cygdrive/c/mozilla-source"

Mozilla Firefox release tags are here, if you want a specific
(release) version:

https://hg.mozilla.org/releases/mozilla-release/tags

Or just take the head:

```bash
mkdir /c/mozilla-source
cd /c/mozilla-source
hg clone https://hg.mozilla.org/releases/mozilla-release/
```

Then 'bootstrap' all the tools and configurations needed, follow
instructions along these lines:

```bash
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

Now grab a specific version that we have patch support for.  For our examples here,
we will use ``84.0.2`` throughout, but you can see latest tagged releases on our github at
https://github.com/Magnusson-Institute/miff/tags

Visity archive.mozilla.org/pub/firefox/releases/84.0.2/source/ and
download the compressed (xz) tar ball.  Untar it alongside
mozilla-release and move ''miff'' right next to it, should eventually
get something like this


```
   /c/mozilla-source/bootstrap.py
   /c/mozilla-source/mozilla-release/
   /c/mozilla-source/firefox-84.0.2/
   /c/mozilla-source/miff/
```

Next, go to the specific release (again, ``84.0.2`` throught our
example) and build it clean:

```bash
cd /c/mozilla-source/firefox-84.0.2
./mach build
./mach run
```


That should be analogous to the mozilla-release setup, note that you
don't need to do "bootstrap".

Note also, you need to pick a matching miff "release". This (tagged)
version would be the correct patch tarball to start with:

https://github.com/Magnusson-Institute/miff/archive/refs/tags/v84.0.2.4.tar.gz


# MiFF patches / changes


There are two sources of changes:

* File patches, these are encompassed by the `miff/patches/*.diff`
  files, and managed with `quilt`.

* Replacement files.  These are listed in `miff/copy_files/` and are
  copied over with `copy_files.sh` into the firefox source tree.

If you're just applying changes and patches and re-building, do
something like this:

```bash
cd /c/mozilla-source/firefox-84.0.2
../miff/copy_files.sh
ln -s ../miff/patches .
quilt push -a
./mach build
./mach run
```


# Creating an update file

Firefox updates replace the files in a user's install directory. These
updates are packaged as a special type of xz or bz2 archive called a
MAR (Mozilla Archive). There are two tools that are available to
create a MAR: a signmar tool created during the normal build process
(obj*/dist/bin/signmar), and a Python tool
(https://github.com/mozilla/build-mar). We need both to create a
working update. The signmar creates a file manifest, but cannot sign
the MAR; the Python tool can sign, but does not generate a file
manifest.

The Python tool can be installed with pip, but requires several other tools in order to install properly.

For Cygwin:
* python38
* python38-devel
* python38-cryptography
* liblzma-devel

For Ubuntu:
* liblzma-dev


## Working with the update patch (patch #12)

If you have not run ``./mach build`` before, quilt will fail trying
to apply 12_updates.diff. The build process creates several generated
files on a first run, including the certificates for update validation.
You will need to run ``./mach build`` first, then apply patch 12 and
beyond.

There is an additional step if you are not working in a Windows
environment. The first build creates an obj-\* folder, where all the
generated files live. The name of this folder is different on each OS.
For non-Windows systems, create a symbolic link to your platform's
obj-\* folder named ``obj-x86_64-pc-mingw32`` and the patch will
apply correctly.


## Working with the release patch (patch #99)

The final patch in the series is used to disable debug features and to
track the version number. If you are working on development you will want
to leave this patch unapplied. Before creating a release/update, set the
appropriate version number in this patch and create a matching tag on Github.

These features are controlled by the mozconfig files, one for each file.
The mozilla build tool will only use the mozconfig if the build is run like
so: ``env MOZCONFIG="path/to/mozconfig" ./mach build``.

Any changes to mozconfig or the version number trigger a full build.

And you should have a working, re-branded Firefox.

# To make modifications yourself

First make sure you've done the above steps. 'miff' needs to be
alongside your build directory, you need a symbolic link to 'patches',
etc.

For example, if you want to start making changes to 'aboutDialog.ftl'.
First, apply patches and file replacements as per above. Then:


```
bash
cd /mozilla-source/firefox-84.0.2
quilt new NN_description_of_changes.diff
quilt add browser/locales/en-US/browser/aboutDialog.ftl 
```


Where 'NN' is a new (higher) patch number than what is already in
`miff/patches/series`. Quilt will only track changes made *after* a file is added to a patch.

Now make some edits to this file (aboutDialog.ftl). Then refresh the patch file:

```
quilt refresh
```


That will create an 'NN' patch file.

## To work with an existing patch / set of changes


You will need to selectively 'quilt push' until you are at the patch
file you want to be using to cluster your changes.  Make sure the
file(s) you are working with are referenced in that patch file (if not
add them with `quilt add <filename>`.

## Some principles

* Try labeling changes with the "MIFF NN" string
  where 'NN' is the patch (diff) file
  (it will be unique, does not exist in FF source code outside dictionary files)
  (note: older tags might use "MagIns")

* Try not just deleting or replacing things, but comment out the
  old code, so that when continuing to work with the resulting
  modified files, you can see what's been done (roughly)


## Set up on Mac OS X (m1)

Similar to Ubuntu, obviously, but enough differences that this will be self-contained:

_(It's (currently) unclear if FF on m1 should be built native or
cross-platform. One confusion is in trying between these, the
"~/.mozbuild" probably gets populated with conflicting tools?
My current approach is to work in a pure 'x86' environment/terminal)_

The C++ tools used to build on Mac are based off Xcode; so first
install latest version of Xcode from the App Store, then finalize it's
installation from command line, and install Mercurial (and make sure
your python is 3.8.x, thought right now I'm trying with 3.9.9) and
other items:

```
   brew install mercurial
   brew install yasm
   brew install libgtk2.0-dev
   brew install quilt
```

Next, create a working directory where you want to work, here we'll
call it "~/dev/ff01"; create it and bootstrap:


   
```
   mkdir ~/dev/ff01
   cd ~/dev/ff01
   curl https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py -O
   python3 bootstrap.py
```


Press "enter" for destination, for default; so it'll start in
"~/ff01/mozilla-unified" in this example.  Mercurial will pull from
"https://hg.mozilla.org/mozilla-unified"; which is full tree. We will
build that first, that will ensure tooling etc is pulled in.  Follow
instructions from script, then make sure to start a new terminal so
all the settings have taken effect.

The various tooling specific to FF build will be set up by the above bootstrap in ``~/.mozbuild/``

A bit of setup:


```
   sudo xcode-select --switch /Applications/Xcode.app
   sudo xcodebuild -license
   echo "export PATH=\"$(python3 -m site --user-base)/bin:$PATH\"" >> ~/.zshenv
   python3 -m pip install --user mercurial
   hg version
```


_ .. hmm, I had a warning to myself "Do *not* run "brew install mercurial", that's something else, it will
drag in newer versions of Python (3.9.x) etc" that I'm "now" ignoring (Dec 21) .. _

HOWEVER. Your "latest version" of Xcode will probably have an SDK that
is too modern. So you need to "downgrade" locally for Moz.  At time of
writing, their _documentation_
(https://firefox-source-docs.mozilla.org/setup/macos_build.html#macos-sdk-is-unsupported)
states that they are using the 10.12 SDK, but their _error messages_
state that they support the 11.1 SDK.

(Apple documentation on the different versions is summarized here:
https://developer.apple.com/support/xcode/#minimum-requirements ).

The older (documentation) instructions suggests pulling 10.12 SDK from
Xcode 8.2. We will go with that for now. Download:

_(Update: mozbug trackers seem to indicate they're using 12.2 from
8.3.3 now, at https://developer.apple.com/download/all/?q=8.3.3 which will be a 'xip' file)_

``https://download.developer.apple.com/Developer_Tools/Xcode_8.2/Xcode_8.2.xip``

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
in miff (e.g. from top of
``https://github.com/Magnusson-Institute/miff/tags``).

In this case, our latest miff tag is "89.0.2.3", which matches Mozilla FF tag "89.0.2" (the fourth
digit ".3" is our internal release schedule, tracking FF). So in this case, download
``https://archive.mozilla.org/pub/firefox/releases/89.0.2/source/firefox-89.0.2.source.tar.xz``,
download our own (tagged) miff tarball, and place it alongside, extract all the tarballs, net
result should look like:


```
   #
   # eg in this case you're downloading:
   # https://github.com/Magnusson-Institute/miff/archive/refs/tags/v89.0.2.3.tar.gz
   # https://archive.mozilla.org/pub/firefox/releases/89.0.2/source/firefox-89.0.2.source.tar.xz
   #
   # and result should be:
   #
   ~/dev/ff01/mozilla-unified/...
   ~/dev/ff01/firefox-89.0.2/..
   ~/dev/ff01/miff-89.0.2.3/...
   #
```


First re-build clean 89.0.2 by itself _without_ applying any patches, to make sure your build environment
is all working:

```
   # examples assume this root dev directory
   cd ~/dev/ff01

   # if you haven't extracted it yet:
   tar xzf ./firefox-89.0.2.source.tar.xz

   cd firefox-89.0.2

   # remember to update/create mozconfig:
   # (it might not exist)
   echo "ac_add_options --with-macos-sdk=$HOME/.mozbuild/macos-sdk/MacOSX10.12.sdk" >> ./mozconfig

   # now this should work:
   ./mach build
   ./mach run
```

Now you can apply the patches:

 
```
   # make sure we're in the right place
   cd ~/dev/ff01

   # first, even if it's a tarball, needs to be called 'miff':
   mv miff-89.0.2.3 miff

   # make sure you're in the right spot
   cd ~/dev/ff01/firefox-89.0.2

   # first copy the files that are meant to outright over-write:
   ../miff/copy_files.sh

   # make sure your actual "obj" directory can be reached from the reference directory:
   # (otherwise some patches will break)
   ln -s obj-x86_64-apple-darwin20.5.0 obj-x86_64-pc-mingw32

   # now soft-link our patch system and apply them
   ln -s ../miff/patches .
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


And there we go (first build per above steps: 2021-07-04).

## NOTE (2021=12=21) on Mac m1

so i don't forget ... looks like their nightly (latest) nowadays can
work fine with the latest SDK (2021-12-22), however, that's not the
case with immediately recent version (e.g. 89.0.2); and looks like one
wants python 3.8 specifically, might need some "hard coding" of setup:


```
   brew reinstall python@3.8
   brew doctor
   brew link --overwrite python@3.8
   which python3
   python3 --version
   brew reinstall hg
   brew link --overwrite mercurial
   hg --version
   brew update
```


might need on second round of build to tell mach that yes system python3 is ok:

```
   export MACH_USE_SYSTEM_PYTHON="yes try it"
```


might run into issues with missing headers, try this (this takes a while):

```
   sudo rm -rf /Library/Developer/CommandLineTools
   xcode-select --install
   cd /Library/Developer/CommandLineTools/Packages/
   open macOS_SDK_headers_for_macOS_10.14.pkg
```


here's a collection of pesky SDKs:

https://github.com/phracker/MacOSX-SDKs/releases

i went with 11.1 instead.

current patch issues:

```   
   Applying patch patches/11_various_branding.diff
   patching file browser/base/content/aboutDialog.xhtml
   Hunk #2 succeeded at 143 with fuzz 2 (offset -1 lines).
   missing header for unified diff at line 39 of patch
   can't find file to patch at input line 39
   Perhaps you used the wrong -p or --strip option?
   The text leading up to this was:
   --------------------------
   |       </vbox>
   --------------------------
   No file to patch.  Skipping patch.
   1 out of 1 hunk ignored
   patching file browser/locales/en-US/browser/aboutDialog.ftl
   patching file toolkit/locales/en-US/toolkit/about/aboutAddons.ftl
   Patch patches/11_various_branding.diff does not apply (enforce with -f)
```   



# TODO (informal section - will migrate to issues)

* [PSM 07/05]: need to update
``locales/en-US/toolkit/about/aboutRights.ftl`` to correctly
position MiFF, including referencing our privacy policy. need
to document what policy documents somebody *else* who
works with ``miff`` would need to change.

* [PSM 07/05]: these need to be changed to 'miff-help':

```
        browser/base/content/aboutDialog.xhtml
   130	<label is="text-link" onclick="openHelpLink('firefox-help')" data-l10n-id="aboutdialog-help-user"/>
        browser/base/content/browser-menubar.inc
   467	oncommand="openHelpLink('firefox-help')"
        browser/base/content/browser.js
   2601	openHelpLink("firefox-help");
```

and a matching ``privacy.app/supportmiff-help`` endpoint added (i think that's where they'll go,
thought right now it looks like still landing on ``https://privacy.app/supportfirefox-help``)

* [PSM 07/05]: i _think_ we should replace all occurrences of
  "mozilla.org" or "firefox.com" to "privacy.app" in file
  ``source/browser/app/profile/firefox.js``; note that many have already been
  modified with "MagIns" explanations.

* [PSM 07/05]: need an endpoint for ``https://privacy.app/contribute/``

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


# Resources

https://firefox-source-docs.mozilla.org/setup/windows_build.html#building-firefox-on-windows

https://firefox-source-docs.mozilla.org/contributing/vcs/mercurial.html


# LICENSE

MiFF is open source and distributed under MPL 2
(https://www.mozilla.org/en-US/MPL/2.0/), see the "LICENSE" file for
details.



----------------

# Footnotes

[^1]: We would call it "Mostly It's Firefox", but that would be in
      violation of Mozilla's (reasonable) trademark rules.[^2]
      And we didn't want to call it "unmozzilad firefox", because
      we're big fans and that's too negative. A more correct name
      might be "ungoogled-firefox" but that would confuse most people.
      And we can't be clever like "GNU" ("Gnu's Not Unix") because
      neither Mozilla nor Firefox starts with a vowel. In short,
      officially, "MiFF" doesn't stand for anything at all.

[^2]: https://www.mozilla.org/en-US/foundation/trademarks/policy/

[^3]: https://www.gnu.org/software/diffutils/manual/html_node/Detailed-Unified.html

	   
