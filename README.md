# Mr. Fusion - Universal MiSTer installation image

Mr. Fusion provides a compact image that you can download
and flash onto an SD card of any size with a tool like [Apple Pi Baker](https://www.tweaking4all.com/software/macosx-software/applepi-baker-v2/), [balenaEtcher](https://www.balena.io/etcher/), [Win32 Disk Imager](https://sourceforge.net/projects/win32diskimager/) or even [dd](https://en.wikipedia.org/wiki/Dd_%28Unix%29).

When you put this SD card into your DE10-nano and start it up, it will
expand the SD card to its full capacity and install a basic MiSTer setup.
This will be familiar to anyone who's worked with a Raspberry Pi before.

From there, using the built-in scripts, you can configure WiFi
(or use ethernet out of the box) and run the standard
[MiSTer Updater script](https://github.com/MiSTer-devel/Updater_script_MiSTer)
to get an up to date MiSTer installation.

## Requirements

- A Micro SD card of minimum 2 GB, for example the one that came with your
  DE10-nano kit.
- Windows, Mac or Linux based computer with a (micro)SD card reader.
- An SD card flash utility.

## Instructions

### Step 1

Download the latest version from the [releases](https://github.com/MiSTer-devel/mr-fusion/releases) page.

### Step 2

Download and install an SD card flash utility for your system. Here are
a few example in no particular order:

- [Apple Pi Baker](https://www.tweaking4all.com/software/macosx-software/applepi-baker-v2/)
- [balenaEtcher](https://www.balena.io/etcher/)
- [Win32 Disk Imager](https://sourceforge.net/projects/win32diskimager/)

Refer to the documentation of the SD card flash utility for more information.

### Step 3

Follow your SD card flash utility's instructions to flash the downloaded image
onto your SD card.

_Note: Extract the downloaded SD card image zip file if your SD card flash utility
does not support flashing zip files!_

### Step 4

Put the SD card into the DE10-nano and power it on. After a few seconds the
orange LED on the board should light up. If you have a TV or monitor connected
to the HDMI port, the screen will turn blue and then show an installation
notice splash screen:

<img src="https://github.com/MiSTer-devel/mr-fusion/raw/master/vendor/support/splash.png" alt="MiSTer installation splash screen" width="50%">

Mr. Fusion will automatically re-partition and resize your SD card and copy all the
necessary MiSTer files onto it. When it's done it will reboot your DE10-nano
and you will be greeted by the MiSTer menu.

Connect a keyboard to your DE10-nano and hit F12 to open the menu. Through
the Scripts section you can configure WiFi and update your MiSTer.
Please refer to the instructions on the
[MiSTer wiki](https://github.com/MiSTer-devel/Main_MiSTer/wiki) for more
information.

_Note: From powering on the DE10-nano and getting to the MiSTer menu should not
take more than 90 seconds. If you don't see the MiSTer menu appear after
two minutes, power off the DE10-nano, remove the SD card and start over._

## MiSTer scripts support

The [MiSTer updater script](https://github.com/MiSTer-devel/Updater_script_MiSTer)
is included by default in every MiSTer installation.
This image also includes the [WiFi setup script](https://github.com/MiSTer-devel/Scripts_MiSTer/blob/master/other_authors/wifi.sh) to allow you to
quickly setup a wireless internet connection after installation.

### Adding more scripts

You can add more scripts if necessary: After you have flashed your SD card and
before you move it over to the DE10-nano, re-insert it into your computer.
A new drive called `MRFUSION` will appear. In it is a `Scripts` folder. Put
any script you want to have available in your MiSTer in this folder. It will
be copied to your MiSTer's Scripts folder automatically during the installation.

## How is this an improvement to the MiSTer setup process?

Having a universal flash image means we can just use _any_ SD card image
flashing tool on _any_ platform instead of a bespoke MiSTer SD card creation
app. We no longer need to maintain such a custom made app or port it to other
platforms.

A fixed size image based approach has one caveat: We want the image to be as
small as possible to reduce the time it takes to download and to support a wide
variety of SD card capacities. We've managed to cram everything MiSTer needs
into approximately 100 MB.
When you flash a 100 MB image onto any size SD card, you will get
only 100 MB of storage, most of which will be taken up by the MiSTer files.
Your whopping 256 GB capacity SD card will only have a few megabytes free space.
The filesystem must be resized to match its full capacity.

MiSTer uses the exFAT filesystem for maximum compatibility across different
platforms (Windows, macOS, Linux, ...). Linux, the operating system that MiSTer
uses under the hood does not (yet) support resizing exFAT filesystems.
The only way to ensure maximum SD card capacity is to recreate the filesystem
with the proper size. However, we can't know in advance what that capacity
is going to be so we let the DE10-nano do the resize before installing
MiSTer. That's what Mr. Fusion does. Because everyone has different computers
but we all have the same DE10-nano board, it makes sense to do it this way.

## Getting help

If you need help, come find us in the #mister-help channel on the [Classic
Gaming Discord server](https://top.gg/servers/418895913210216448).

## Reporting issues

If you think you found a bug or you have an idea for an improvement, [please
open an issue](https://github.com/MiSTer-devel/mr-fusion/issues).

## Building it yourself

See [BUILDING.md](https://github.com/MiSTer-devel/mr-fusion/blob/master/BUILDING.md)
for more details.

## Acknowledgements

Thanks to Sorgelig, Rysha, Ziggurat, alanswx, r0ni and Locutus73 for their insights.
Thanks to [amoore2600](https://www.youtube.com/channel/UC_IynEJIMqkYaCVjEk_EIlg) for pushing me to build this.

## Disclaimer

This program is free software. It comes without any warranty, to
the extent permitted by applicable law. See [LICENSE](https://github.com/MiSTer-devel/mr-fusion/blob/master/LICENSE) for more details.
