rtorrentrc
==========

This repository contains my setup for torrenting using the excellent `rtorrent` software.
This "personal" setup is the result of years of organization, and at this stage should be useful not anymore only for me but for general use.

Highlights of the setup
-----------------------

Non-polemic issues, which I think that should be generally useful:

  * Concentrates all torrenting-related files into a directory hierarchy under a user-defined directory.

  * Has subdirectories `metafiles-in-progress` and `metafiles-finished`.
    The `*.torrent` files which are being _currently_ downloaded are kept in `metafiles-in-progress`.
    When the download is completed, the metafiles is _automatically_ moved to `metafiles-finished`.
  * The directory `metafiles-in-progress` is monitored by rtorrent, and any torrent file added to it
    _automatically_ initiates a corresponding download.

  * Has subdirectories `content-in-progress` and `content-finished`.
  * The contents of current downloads are kept in `content-in-progress`, and when download is finished they are moved to `content-finished`.
    During post-download seeding, the contents will _already_ be at `content-finished`.

  * With this setup, you get a script called `magnet-get` (which is linked into `~/bin`).
    Calling this script with a magnet link as parameter will create a correspondent torrent file under
    `metafiles-in-progress`, and therefore _start a download_.

Also, some settings that I find very useful, but you might want to change in `rtorrent.rc`

  * RTorrent is set to always _try_ encryption, that is, allow incoming, try outgoing.
  * The maximum number of upload slots _per torrent_ is 15.
  * Default maximum download speed of 2MB/s and maximum upload speed of 1MB/s.
  * Seed ration control: torrent is closed automatically after reaching seed ration of 200%.
  * Speed scheduling: down and up speed are _halved_ early in the mornings (7:00-10:00) and in the evening (17:30-23:00),
    as in these periods the connection is more likely to be used by other applications also.

How to install
--------------

Run the included script `install.sh`, passing as parameter the desired directory under which you want to keep everything torrent-related.
If you don't pass anything, the default "torrenting root" is `${HOME}/torrent`.

