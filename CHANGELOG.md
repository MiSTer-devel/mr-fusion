# Version 2.9

- Mr. Fusion now generates a random Ethernet MAC address for your MiSTer during installation.
  This generated MAC address is set in `/linux/u-boot.txt`. This should better avoid potential
  MAC address collisions when multiple MiSTers are connected to the same network.
  Thanks [Callan Barrett](https://github.com/wizzomafizzo) for the contribution!

# Version 2.8

- Updated packaged MiSTer release to release_20230501.

# Version 2.7

- Bundled the [SDL Game Controller DB](https://github.com/MiSTer-devel/Distribution_MiSTer/blob/main/linux/gamecontrollerdb/gamecontrollerdb.txt) until it is included by default in a future MiSTer release.

# Version 2.6

- Updated packaged MiSTer release to release_20221224.
- Removed Vagrant method for building.

# Version 2.5

- Updated packaged MiSTer release to release_20220413.
- [The new downloader script](https://github.com/MiSTer-devel/Downloader_MiSTer) has now replaced
  the previous update.sh script by default in every new MiSTer release.

# Version 2.4

- Updated packaged MiSTer release to release_20211112.
- Bundle [the new downloader script](https://github.com/MiSTer-devel/Downloader_MiSTer) until
  it is included by default in a future MiSTer release.

# Version 2.3

- Updated packaged MiSTer release to release_20210917. This MiSTer release
  includes out of the box gamepad support which should make setting up your new
  MiSTer much easier!
- Added support for custom config. During the MiSTer installation Mr. Fusion will copy the
  config folder in the root of the SD card to your MiSTer. Put any custom MiSTer configuration
  files in here. For example: Custom input mappings in config/inputs.
- Removed support for RAR and added support for 7-zip as newer MiSTer releases
  now use 7-zip compression instead of RAR.

# Version 2.2

- Added support for custom WiFi and Samba configuration (thanks versechoruscurse
  for the suggestion).
- Improved splash screen visibility when using HDMI to VGA adapter dongles with
  older (CRT) monitors.

# Version 2.1

- Updated packaged MiSTer release to release_20200908.

# Version 2.0

- Added HDMI out support.
- Added splash screen giving visual feedback to the user.

# Version 1.0

- Added [WiFi setup script](https://github.com/MiSTer-devel/Scripts_MiSTer/blob/master/other_authors/wifi.sh).
- Added support to include additional scripts.

# Version 1.0-beta

- Initial release.
