#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

DESTINATION_DIR="${1}"

cat <<EOF > "${DIR}/magnet-get"
#!/usr/bin/env bash
WATCH_DIR="${DESTINATION_DIR}"

cd "\${WATCH_DIR}" || exit
[[ "\$1" =~ xt=urn:btih:([^&/]+) ]] || exit
echo "d10:magnet-uri\${#1}:\${1}e" > "meta-\${BASH_REMATCH[1]}.torrent"
echo "magnet meta-file added as \${WATCH_DIR}/meta-\${BASH_REMATCH[1]}.torrent"
EOF

