#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

TORRENTING_ROOT="${1}"


"${DIR}/magnet-get-generate.sh" "${TORRENTING_ROOT}/metafiles-in-progress"
chmod +x "${DIR}/magnet-get"

mkdir -p "${HOME}/bin"
ln -s -f -n "${DIR}/magnet-get"  "${HOME}/bin/magnet-get"

MIMES_DIR="${HOME}/.local/share/applications"
mkdir -p "${MIMES_DIR}"
ln -s -f -n "${DIR}/magnet.desktop"  "${MIMES_DIR}/magnet.desktop"
xdg-mime default magnet.desktop x-scheme-handler/magnet

