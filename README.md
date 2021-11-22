
## MiFF build - with patches


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


# Set up Cygwin

We work in either Moz Shell for all the build tools from Mozilla (see
below), and Cygwin64 for all of our own tooling (git, quilt, various
shellscripts, etc).

# Check out mercurial

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

Once the above works, you have a dev environment (mozilla
tooling). That confirms a working build environment.

# Take a specific tarball

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

# MiFF patches / changes

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
`m041/patches/series`.

Now make some edits to this file (aboutDialog.ftl). Then refresh the patch file:

```bash
quilt refresh
```

That will create an 'NN' patch file.

# To work with an existing patch / set of changes

You will need to selectively 'quilt push' until you are at the patch
file you want to be using to cluster your changes.  Make sure the
file(s) you are working with are referenced in that patch file (if not
add them with `quilt add <filename>`.


# Some principles

* Try labeling changes with the "MagIns NN" string
  where 'NN' is the patch (diff) file
  (it will be unique, does not exist in FF source code)
* Try not just deleting or replacing things, but comment out the
  old code, so that when continuing to work with the resulting
  modified files, you can see what's been done (roughly)



# Resources:

https://firefox-source-docs.mozilla.org/setup/windows_build.html#building-firefox-on-windows

https://firefox-source-docs.mozilla.org/contributing/vcs/mercurial.html
