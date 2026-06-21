#!/bin/bash
# Baut eine selbstentpackende .run-Installationsdatei (eine Datei zum Kopieren)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
OUT_DIR="${OUT_DIR:-$REPO_ROOT/dist}"
HEADER="$SCRIPT_DIR/installer-header.sh"

if [ "${SKIP_MAKE_PACKAGE:-}" != "1" ]; then
    "$SCRIPT_DIR/make-package.sh" >/dev/null
fi

TARBALL=$(ls -t "$OUT_DIR"/rock-mp3d-mpv40-aarch64-*.tar.gz | head -1)
PKG_NAME=$(basename "$TARBALL" .tar.gz)
INSTALLER="$OUT_DIR/${PKG_NAME}.run"

cat > "$HEADER" << 'HEADER_EOF'
#!/bin/bash
# rock-mp3d-mpv40 Self-Extracting Installer
set -euo pipefail

INSTALL_PREFIX="${INSTALL_PREFIX:-/opt/rock-mp3d-mpv40}"
SKIP_INSTALL=0
EXTRACT_ONLY=0
TARGET_DIR=""

usage() {
    cat << EOF
rock-mp3d-mpv40 Installer (Radxa Rock 5B / aarch64)

Verwendung:
  sudo $0                    Installiert nach /opt/rock-mp3d-mpv40
  $0 --noexec --target DIR   Nur entpacken nach DIR
  $0 --help                  Diese Hilfe

Umgebungsvariablen:
  INSTALL_PREFIX=/pfad         Zielverzeichnis (mit sudo ./install.sh im Paket)
  ALLOW_USER_INSTALL=1         Installation ohne root ins Home-Verzeichnis
EOF
}

while [ $# -gt 0 ]; do
    case "$1" in
        --noexec) SKIP_INSTALL=1 ;;
        --target) EXTRACT_ONLY=1; TARGET_DIR="$2"; shift ;;
        --help|-h) usage; exit 0 ;;
        *) echo "Unbekannte Option: $1" >&2; usage; exit 1 ;;
    esac
    shift
done

TMP=$(mktemp -d)
cleanup() { rm -rf "$TMP"; }
trap cleanup EXIT

ARCHIVE_LINE=$(awk '/^__ARCHIVE_BELOW__$/ {print NR + 1; exit 0; }' "$0")
echo "Entpacke Paket …"
tail -n +"$ARCHIVE_LINE" "$0" | tar xz -C "$TMP"

PKG_DIR=$(find "$TMP" -mindepth 1 -maxdepth 1 -type d | head -1)
[ -n "$PKG_DIR" ] || { echo "Fehler: leeres Archiv" >&2; exit 1; }

if [ "$EXTRACT_ONLY" = "1" ]; then
    DEST="${TARGET_DIR:-./rock-mp3d-mpv40}"
    mkdir -p "$DEST"
    cp -a "$PKG_DIR/." "$DEST/"
    echo "Entpackt nach: $DEST"
    echo "Manuell installieren: cd $DEST && sudo ./install.sh"
    exit 0
fi

if [ "$SKIP_INSTALL" = "1" ]; then
    echo "Entpackt nach: $TMP/$(basename "$PKG_DIR")"
    echo "( --noexec ohne --target: temporäres Verzeichnis wird beim Beenden gelöscht )"
    trap - EXIT
    exit 0
fi

echo ""
echo "=== rock-mp3d-mpv40 Installation ==="
echo ""

if [ "$(id -u)" -ne 0 ] && [ "${ALLOW_USER_INSTALL:-}" != "1" ]; then
    echo "Root-Rechte nötig. Starte mit sudo …"
    exec sudo INSTALL_PREFIX="$INSTALL_PREFIX" "$0" ${1+"$@"}
fi

cd "$PKG_DIR"
./install.sh
echo ""
echo "Fertig! Test: rock-mp3d-play /pfad/zum/video.mp4"
exit 0

__ARCHIVE_BELOW__
HEADER_EOF

chmod 755 "$HEADER"
cat "$HEADER" "$TARBALL" > "$INSTALLER"
chmod +x "$INSTALLER"

SIZE=$(du -h "$INSTALLER" | cut -f1)
echo ""
echo "Installer erstellt: $INSTALLER ($SIZE)"
