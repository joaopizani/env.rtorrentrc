#!/usr/bin/env bash

TORRENTING_ROOT_DEFAULT="${HOME}/torrent"
TORRENTING_ROOT_=${1:-$TORRENTING_ROOT_DEFAULT}
TORRENTING_ROOT=$(readlink -f $TORRENTING_ROOT_)

if [ ${TORRENTING_ROOT} != ${TORRENTING_ROOT_DEFAULT} ]
    ln -s -f ${TORRENTING_ROOT} ${TORRENTING_ROOT_DEFAULT}
fi

mkdir -p "${TORRENTING_ROOT}/session"
mkdir -p "${TORRENTING_ROOT}/content-in-progress"
mkdir -p "${TORRENTING_ROOT}/content-finished"
mkdir -p "${TORRENTING_ROOT}/metafiles-in-progress"
mkdir -p "${TORRENTING_ROOT}/metafiles-finished"


REL_SRC=${BASH_SOURCE[0]}
CANONICAL_SRC=$(readlink -f $REL_SRC)
DIR="$(cd -P "$(dirname $CANONICAL_SRC)" && pwd)"

ln -s -f ${DIR}/rtorrent.rc    ${HOME}/.rtorrent.rc

mkdir -p ${HOME}/bin
ln -s -f ${DIR}/magnet.sh      ${HOME}/bin/magnet.sh

