#!/bin/bash
# Erstellt ein portables Install-Paket für rock-mp3d-mpv40 (aarch64)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PROJEKT_ROOT="${PROJEKT_ROOT:-$(cd "$REPO_ROOT/.." && pwd)}"
OUT_DIR="${OUT_DIR:-$REPO_ROOT/dist}"
STAGE="$SCRIPT_DIR/staging"
VERSION="$(date +%Y%m%d)"
PKG_NAME="rock-mp3d-mpv40-aarch64-${VERSION}"
ARCHIVE="$OUT_DIR/${PKG_NAME}.tar.gz"

MP3D_PREFIX="${MP3D_PREFIX:-$PROJEKT_ROOT/install-mp3d}"
FFMPEG_PREFIX="${FFMPEG_PREFIX:-$PROJEKT_ROOT/install}"
DEPS="${DEPS_PREFIX:-$PROJEKT_ROOT/deps-prefix}"
SCRIPTS_SRC="$REPO_ROOT"

for d in "$MP3D_PREFIX/bin/mpv" "$FFMPEG_PREFIX/lib/libavcodec.so.60" "$SCRIPTS_SRC/play.sh"; do
    [ -e "$d" ] || { echo "Fehlt: $d — zuerst mp3d-mpv40 bauen." >&2; exit 1; }
done

rm -rf "$STAGE"
ROOT="$STAGE/$PKG_NAME"
mkdir -p "$ROOT"/{bin,lib/aarch64-linux-gnu,etc,doc}

echo "==> Kopiere mp3d-mpv + ffmpeg-rockchip …"
install -m 755 "$MP3D_PREFIX/bin/mpv" "$ROOT/bin/mpv"
install -m 755 "$FFMPEG_PREFIX/bin/ffmpeg" "$ROOT/bin/ffmpeg" 2>/dev/null || true
install -m 755 "$FFMPEG_PREFIX/bin/ffprobe" "$ROOT/bin/ffprobe" 2>/dev/null || true

for lib in "$FFMPEG_PREFIX/lib"/libav*.so* "$FFMPEG_PREFIX/lib"/libsw*.so* "$FFMPEG_PREFIX/lib"/libpostproc.so*; do
    [ -e "$lib" ] && cp -a "$lib" "$ROOT/lib/aarch64-linux-gnu/" 2>/dev/null || true
done
for lib in "$FFMPEG_PREFIX/lib/aarch64-linux-gnu"/libplacebo.so*; do
    [ -e "$lib" ] && cp -a "$lib" "$ROOT/lib/aarch64-linux-gnu/"
done
for lib in "$MP3D_PREFIX/lib/aarch64-linux-gnu"/libmpv.so*; do
    [ -e "$lib" ] && cp -a "$lib" "$ROOT/lib/aarch64-linux-gnu/"
done
for lib in libmujs.so liblua5.2.so libdisplay-info.so libXpresent.so; do
    find "$DEPS/usr/lib/aarch64-linux-gnu" -maxdepth 1 -name "${lib}*" -exec cp -a {} "$ROOT/lib/aarch64-linux-gnu/" \;
done
find "$ROOT/lib" -type l ! -exec test -e {} \; -delete 2>/dev/null || true

echo "==> Skripte und Konfiguration …"
for f in play.sh play-desktop.sh play-desktop-lowdrop.sh; do
    install -m 755 "$SCRIPTS_SRC/$f" "$ROOT/$f"
done
for f in readme_mpv_start.md README.md; do
    [ -f "$SCRIPTS_SRC/$f" ] && install -m 644 "$SCRIPTS_SRC/$f" "$ROOT/$f"
done
install -m 644 "$SCRIPTS_SRC/etc/"* "$ROOT/etc/"

cat > "$ROOT/run-mpv40.sh" << 'WRAPPER'
#!/bin/bash
ROOT="$(cd "$(dirname "$0")" && pwd)"
export PATH="$ROOT/bin:$PATH"
export LD_LIBRARY_PATH="$ROOT/lib/aarch64-linux-gnu:$ROOT/lib:/usr/lib/aarch64-linux-gnu${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
export LIBGL_DRIVERS_PATH="/usr/lib/aarch64-linux-gnu/dri"
export MESA_LOADER_DRIVER_OVERRIDE="${MESA_LOADER_DRIVER_OVERRIDE:-rockchip}"
exec "$ROOT/bin/mpv" "$@"
WRAPPER
chmod 755 "$ROOT/run-mpv40.sh"

MPV_VER="$("$ROOT/run-mpv40.sh" --version 2>/dev/null | head -1 || echo unknown)"
cat > "$ROOT/VERSION" << EOF
package=${PKG_NAME}
built=$(date -Iseconds)
mpv=${MPV_VER}
target=Radxa Rock 5B / RK3588 (aarch64)
EOF

cp "$SCRIPT_DIR/install.sh" "$ROOT/install.sh"
cp "$SCRIPT_DIR/uninstall.sh" "$ROOT/uninstall.sh"
chmod 755 "$ROOT/install.sh" "$ROOT/uninstall.sh"
cp "$SCRIPT_DIR/README-INSTALL.md" "$ROOT/doc/README.md"
[ -f "$SCRIPT_DIR/README-INSTALL.en.md" ] && cp "$SCRIPT_DIR/README-INSTALL.en.md" "$ROOT/doc/README.en.md"
[ -f "$REPO_ROOT/dist/INSTALL.en.md" ] && cp "$REPO_ROOT/dist/INSTALL.en.md" "$ROOT/doc/INSTALL.en.md"

cat > "$ROOT/INSTALL.txt" << 'EOF'
rock-mp3d-mpv40 — Schnellinstallation (Radxa Rock 5B, aarch64)
================================================================

1) System-Voraussetzungen (einmalig):
   sudo apt install -y libdrm2 libgbm1 libegl1 libgles2 libgl1 \
     libx11-6 libxext6 libxrandr2 libxv1 libxpresent1 \
     libasound2 libpulse0 libass9 libvulkan1 \
     librockchip-mpp1 librga2 mesa-utils
   sudo usermod -aG video,render $USER
   (neu einloggen)

2) Installieren:
   sudo ./install.sh
   → Ziel: /opt/rock-mp3d-mpv40

3) Abspielen:
   rock-mp3d-play              /pfad/video.mp4   (DRM/TTY, beste Performance)
   rock-mp3d-desktop           /pfad/video.mp4   (Desktop mit Audio)
   rock-mp3d-desktop-lowdrop   /pfad/video.mp4   (Desktop, wenig Drops)

Deinstallieren:
   sudo ./uninstall.sh

Details: doc/README.md
EOF

mkdir -p "$OUT_DIR"
tar -C "$STAGE" -czf "$ARCHIVE" "$PKG_NAME"
rm -rf "$STAGE"

SIZE=$(du -h "$ARCHIVE" | cut -f1)
echo ""
echo "Tarball: $ARCHIVE ($SIZE)"
echo "Installer bauen: $SCRIPT_DIR/build-installer.sh"
