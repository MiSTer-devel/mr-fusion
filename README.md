# Mr. Fusion - Universal MiSTer SD card image

This project provides a minimal SD card image that you can download
and flash onto an SD card of any size with a tool like [Apple Pi Baker](https://www.tweaking4all.com/software/macosx-software/applepi-baker-v2/), [balenaEtcher](https://www.balena.io/etcher/), [Win32 Disk Imager](https://sourceforge.net/projects/win32diskimager/) or even [dd](https://en.wikipedia.org/wiki/Dd_%28Unix%29).

## Status

The project is currently in beta testing. More documentation as well as
a complete account of the reasoning behind it and its development process
will follow soon.

## Requirements

- A Micro SD card of minimum 2 GB, for example the one that came with your
  DE10-nano kit.
- Windows, Mac or Linux based computer with a (micro)SD card reader.
- An SD card flash utility.

## Instructions

### Step 1

Download a copy of the image from the [releases](https://github.com/michaelshmitty/mr-fusion/releases) page.

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

Put the SD card into the DE10-nano and power it on. The board will boot up,
re-partition and resize your SD card and copy all the necessary MiSTer files
onto it. When it's done it will automatically reboot and you will be greeted
by the MiSTer menu, provided that you have connected your board to a TV or
monitor.
Continue to set up your MiSTer device as usual following the
instructions on the [MiSTer wiki](https://github.com/MiSTer-devel/Main_MiSTer/wiki).

_Note: There is currently no visual feedback on the installation process on the
DE10-nano board. This will be added soon. From powering on the
DE10-nano and getting to the MiSTer menu should not take more than 90 seconds.
If you don't see the MiSTer menu appear after two minutes, power off the
DE10-nano, remove the SD card and start over._

## Getting help

If you need help, come find us in the #mister-help channel on the [Classic
Gaming Discord server](https://top.gg/servers/418895913210216448).

## Reporting issues

If you think you found a bug or you have an idea for an improvement, [please
open an issue](https://github.com/michaelshmitty/mr-fusion/issues).

## Acknowledgements

Thanks to Sorgelig, Rysha, Ziggurat, alanswx, r0ni and Locutus73 for their insights.
Thanks to [amoore2600](https://www.youtube.com/channel/UC_IynEJIMqkYaCVjEk_EIlg) for pushing me to build this.

## Disclaimer

This program is free software. It comes without any warranty, to
the extent permitted by applicable law. See [LICENSE](https://github.com/michaelshmitty/mr-fusion/blob/master/LICENSE) for more details.
