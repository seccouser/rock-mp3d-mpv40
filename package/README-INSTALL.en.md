# rock-mp3d-mpv40 — Installation package

Two options for **Radxa Rock 5B / RK3588** (aarch64):

| File | Description |
|------|-------------|
| **`rock-mp3d-mpv40-aarch64-*.tar.gz`** | **Recommended** — Tarball |
| `rock-mp3d-mpv40-aarch64-*.run` | Alternative — self-extracting single file |

Package contents:
- `bin/mpv` (mp3d-mpv40 + SECCO-3D / `--secenable`)
- `lib/` with ffmpeg-rockchip, libplacebo, libmpv
- Starter scripts: `play.sh`, `play-desktop.sh`, …

---

## Option 1: Tarball (recommended)

```bash
tar xzf rock-mp3d-mpv40-aarch64-*.tar.gz
cd rock-mp3d-mpv40-aarch64-*

cat INSTALL.txt
sudo ./install.sh        # → /opt/rock-mp3d-mpv40
```

**Layout after extraction:**

```
rock-mp3d-mpv40-aarch64-*/
├── INSTALL.txt
├── install.sh / uninstall.sh
├── run-mpv40.sh
├── play.sh, play-desktop.sh, play-desktop-lowdrop.sh
├── bin/mpv, bin/ffmpeg, bin/ffprobe
├── lib/aarch64-linux-gnu/
└── etc/rock-input.conf, mpv-4k.conf
```

---

## Option 2: .run installer

```bash
chmod +x rock-mp3d-mpv40-aarch64-*.run
sudo ./rock-mp3d-mpv40-aarch64-*.run
```

---

## System requirements (both options)

Radxa/Rockchip image with MPP (e.g. `rock-5b_bookworm_kde`):

```bash
sudo apt update
sudo apt install -y \
  libdrm2 libgbm1 libegl1 libgles2 libgl1 \
  libx11-6 libxext6 libxrandr2 libxv1 libxpresent1 \
  libasound2 libpulse0 libass9 libvulkan1 \
  librockchip-mpp1 librga2 mesa-utils
sudo usermod -aG video,render "$USER"
```

Mesa/GPU drivers come from the system — not included in the package.

---

## Usage after installation

```bash
rock-mp3d-play              /path/video.mp4   # TTY/DRM
rock-mp3d-desktop           /path/video.mp4   # Desktop + audio
rock-mp3d-desktop-lowdrop   /path/video.mp4   # Desktop, smooth
```

Or directly:

```bash
/opt/rock-mp3d-mpv40/play.sh /path/video.mp4
```

## Uninstall

```bash
sudo /opt/rock-mp3d-mpv40/uninstall.sh
```

---

## Rebuild package (development machine)

```bash
./package/make-package.sh
./package/build-installer.sh
./package/build-all.sh         # → dist/
```

Requires a built mp3d-mpv40 (default: `../install-mp3d/bin/mpv` next to this repo).

---

**Author / Maintainer:** Ulrich Daehnert, Germany  
**Copyright © 2026 Ulrich Daehnert.** Documentation and packaging for this project.  
*Deutsch:* [README-INSTALL.md](README-INSTALL.md)
