rtorrentrc
==========

This repository contains my setup for torrenting using the excellent `rtorrent` software.
This "personal" setup is the result of years of organization,
and at this stage should be useful not anymore only to me but to other people interested in bittorrent.


Highlights of the setup
-----------------------

### Non-polemic issues, generally useful ###

 * Concentrates all torrenting-related files into a directory hierarchy under a user-defined directory.

 * Has subdirectories `metafiles-in-progress` and `metafiles-finished`.
    + The `*.torrent` files which are being _currently_ downloaded are kept in `metafiles-in-progress`.
    + When a download is completed, the corresponding metafile is moved to `metafiles-finished`.

 * The directory `metafiles-in-progress` is monitored by rtorrent, and any `*.torrent` file added to it
   _automatically_ initiates a corresponding download.

 * Has subdirectories `content-in-progress` and `content-finished`.
    + The contents of current downloads are kept in `content-in-progress`,
      and when a download is finished they are moved to `content-finished`.
    + During post-download seeding, the contents will _already_ be at `content-finished`.

### Magnet-get, the script integrating RTorrent and magnet links ###

 * With this setup, you get a script called `magnet-get` (which is linked into `~/bin`).
    + Calling this script with a magnet link as parameter will put a corresponding file under
      `metafiles-in-progress`, and therefore _start a download_.

 * The script reads environment variables called `MAGNETGET_HOST` and `MAGNETGET_USER`
    + If **both** are defined, the metafile is created at `${MAGNET_USER}@${MAGNETGET_HOST}:<meta_in_progress_dir>`.
    + If only `MAGNETGET_HOST` is defined, then it's created at `${USER}@${MAGNETGET_HOST}:<meta_in_progress_dir>`.
    + If **none are defined** (default), it's created normally at `localhost:<meta_in_progrss_dir>`.
    + For example, I have a torrent box on my LAN. So I define `export MAGNETGET_HOST=192.168.1.10`.

### Reasonable defaults, but which you MIGHT want to change ###

The following settings can be changed in `rtorrent.rc`:

 * RTorrent is set to always _try_ encryption, that is, allow incoming, try outgoing.
 * The maximum number of upload slots _per torrent_ is 15.
 * Default maximum download speed of 2MB/s and maximum upload speed of 1MB/s.
 * Seed ratio control: torrent is closed automatically after reaching seed ratio of 200%.
 * Speed scheduling: speeds are _halved_ early in the mornings (7:00-10:00) and in the evening (17:30-23:00),
   as during these periods I am at home, and using the connection more intensively.

Concerning RTorrent being the default handler for magnet links...

 * RTorrent is made the _default_ application to handle magnet links.
   That is, whenever you click on a magnet link on your browser, it will queue a download in RTorrent.
   If RTorrent is not running at the moment, the download will start whenever you run RTorrent.
    + What is _actually_ done when a magnet link is clicked is create a `.torrent` file representing the magnet link
      inside the `metafiles-in-progress` directory.
    + If you wish to _deregister_ RTorrent from handling magnet links, type the following into a terminal:
      `xdg-mime default <your-application>.desktop x-scheme-handler/magnet`, where `<your-application>` can
      be something like `transmission-gtk`, `deluge`, or whatever else you want.


How to install
--------------

Run the included script `install.sh`,
passing as parameter the desired directory under which you want to keep everything torrent-related.
If you don't pass anything, the default "torrenting root" is `${HOME}/torrent`.

