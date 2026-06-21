#!/bin/bash
# Installiert rock-mp3d-mpv40 nach /opt/rock-mp3d-mpv40
set -euo pipefail

INSTALL_PREFIX="${INSTALL_PREFIX:-/opt/rock-mp3d-mpv40}"
SRC="$(cd "$(dirname "$0")" && pwd)"

if [ "$(id -u)" -ne 0 ] && [ "${ALLOW_USER_INSTALL:-}" != "1" ]; then
    echo "Bitte als root ausführen: sudo ./install.sh" >&2
    echo "Oder: ALLOW_USER_INSTALL=1 INSTALL_PREFIX=\$HOME/rock-mp3d-mpv40 ./install.sh" >&2
    exit 1
fi

echo "Installiere nach: $INSTALL_PREFIX"
mkdir -p "$INSTALL_PREFIX"
if command -v rsync >/dev/null 2>&1; then
    rsync -a --delete \
        --exclude='doc/' \
        "$SRC/" "$INSTALL_PREFIX/"
else
    find "$INSTALL_PREFIX" -mindepth 1 -maxdepth 1 -exec rm -rf {} + 2>/dev/null || true
    cp -a "$SRC/." "$INSTALL_PREFIX/"
fi
chmod 755 "$INSTALL_PREFIX/install.sh" "$INSTALL_PREFIX/uninstall.sh" "$INSTALL_PREFIX/run-mpv40.sh" 2>/dev/null || true

write_cmd() {
    local cmd="$1" script="$2"
    cat > "/usr/local/bin/rock-mp3d-${cmd}" << EOF
#!/bin/bash
cd "$INSTALL_PREFIX" && exec "./$script" "\$@"
EOF
    chmod 755 "/usr/local/bin/rock-mp3d-${cmd}"
}
write_cmd play play.sh
write_cmd desktop play-desktop.sh
write_cmd desktop-lowdrop play-desktop-lowdrop.sh

cat > /usr/local/bin/rock-mp3d-mpv40 << EOF
#!/bin/bash
exec "$INSTALL_PREFIX/run-mpv40.sh" "\$@"
EOF
chmod 755 /usr/local/bin/rock-mp3d-mpv40

echo ""
echo "Installation abgeschlossen."
"$INSTALL_PREFIX/run-mpv40.sh" --version | head -3
echo ""
echo "Beispiele:"
echo "  rock-mp3d-play /pfad/video.mp4"
echo "  rock-mp3d-desktop /pfad/video.mp4"
