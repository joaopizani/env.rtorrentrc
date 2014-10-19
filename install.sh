#!/usr/bin/env bash

TORR_ROOT_DEFAULT="${HOME}/torrent"
TORR_ROOT_="${1:-$TORR_ROOT_DEFAULT}"
TORR_ROOT="$(readlink -f "$TORR_ROOT_")"

[ "${TORR_ROOT}" != "${TORR_ROOT_DEFAULT}" ] && ln -s -f -n "${TORR_ROOT}" "${TORR_ROOT_DEFAULT}"

TORR_SUBDIRS=('session' 'content-in-progress' 'content-finished' 'metafiles-in-progress' 'metafiles-finished')
for subdir in "${TORR_SUBDIRS[@]}"; do mkdir -p "${TORR_ROOT}/${subdir}"; done


DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

ln -s -f -n "${DIR}/rtorrent.rc"    "${HOME}/.rtorrent.rc"

"${DIR}/magnet-get/install.sh"  "${TORR_ROOT}"

