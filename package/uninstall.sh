#!/bin/bash
set -euo pipefail

INSTALL_PREFIX="${INSTALL_PREFIX:-/opt/rock-mp3d-mpv40}"

if [ "$(id -u)" -ne 0 ]; then
    echo "Bitte als root: sudo ./uninstall.sh" >&2
    exit 1
fi

rm -f /usr/local/bin/rock-mp3d-mpv40
rm -f /usr/local/bin/rock-mp3d-play /usr/local/bin/rock-mp3d-desktop /usr/local/bin/rock-mp3d-desktop-lowdrop
rm -rf "$INSTALL_PREFIX"

echo "Deinstalliert: $INSTALL_PREFIX"
