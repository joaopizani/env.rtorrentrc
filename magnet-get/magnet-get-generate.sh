#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

DESTINATION_DIR="${1}"

cat <<EOF > "${DIR}/magnet-get"
#!/usr/bin/env bash
WATCH_DIR="${DESTINATION_DIR}"

MAGNETGET_HOST_DEFAULT="localhost"
MAGNETGET_HOST_="\${MAGNETGET_HOST:-\${MAGNETGET_HOST_DEFAULT}}"

MAGNETGET_USER_DEFAULT="\${USER}"
MAGNETGET_USER_="\${MAGNETGET_USER:-\${MAGNETGET_USER_DEFAULT}}"


[[ "\$1" =~ xt=urn:btih:([^&/]+) ]] || exit

TFNAME="meta-\${BASH_REMATCH[1]}.torrent"
TMPTFILE="/tmp/\${TFNAME}"
echo "d10:magnet-uri\${#1}:\${1}e" > "\${TMPTFILE}"

if [[ "\${MAGNETGET_HOST_}" =~ localhost ]]; then  cp "\${TMPTFILE}" "\${WATCH_DIR}/\${TFNAME}"
else  scp "\${TMPTFILE}" "\${MAGNETGET_USER_}@\${MAGNETGET_HOST_}:\${WATCH_DIR}/\${TFNAME}";  fi
rm "\${TMPTFILE}"


echo "magnet meta-file added as \${WATCH_DIR}/\${TFNAME} at \${MAGNETGET_HOST_}"
EOF

