#!/usr/bin/env bash

TORRENTING_ROOT_DEFAULT="${HOME}/torrent"
TORRENTING_ROOT_="${1:-$TORRENTING_ROOT_DEFAULT}"
TORRENTING_ROOT="$(readlink -f "$TORRENTING_ROOT_")"

if [ "${TORRENTING_ROOT}" != "${TORRENTING_ROOT_DEFAULT}" ]
then
    ln -s -f -n "${TORRENTING_ROOT}" "${TORRENTING_ROOT_DEFAULT}"
fi

TORRENT_SUBDIRS=('session' 'content-in-progress' 'content-finished' 'metafiles-in-progress' 'metafiles-finished')
for subdir in "${TORRENT_SUBDIRS[@]}"; do
    mkdir -p "${TORRENTING_ROOT}/${subdir}"
done


DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

ln -s -f -n "${DIR}/rtorrent.rc"    "${HOME}/.rtorrent.rc"

mkdir -p "${HOME}/bin"
ln -s -f -n "${DIR}/magnet.sh"      "${HOME}/bin/magnet.sh"

