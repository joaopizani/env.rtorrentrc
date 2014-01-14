#!/usr/bin/env bash

TORRENT_DIR_LINK="${HOME}/torrent"
WATCH_DIR="${TORRENT_DIR_LINK}/metafiles-toekomst"

cd "${WATCH_DIR}" || exit
[[ "$1" =~ xt=urn:btih:([^&/]+) ]] || exit
echo "d10:magnet-uri${#1}:${1}e" > "meta-${BASH_REMATCH[1]}.torrent"
echo "torrent added to rtorrent via magnet link"

