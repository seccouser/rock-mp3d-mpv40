#!/bin/bash
# Baut Tarball (empfohlen) und .run-Installer nach dist/
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "=== rock-mp3d-mpv40 Paket bauen ==="
echo ""

echo "[1/2] Tarball (empfohlen) …"
"$SCRIPT_DIR/make-package.sh"

echo ""
echo "[2/2] Self-Extracting .run …"
SKIP_MAKE_PACKAGE=1 "$SCRIPT_DIR/build-installer.sh"

echo ""
echo "=== Fertig ==="
ls -lh "$REPO_ROOT/dist"/rock-mp3d-mpv40-aarch64-* 2>/dev/null | awk '{print "  " $9 " (" $5 ")"}'
echo ""
echo "Veröffentlichen: git add dist/ && git commit && git push"
