# rock-mp3d-mpv40 — Installation (Radxa Rock 5B, aarch64)

Ready-made binary packages for **mpv mp3d-mpv40** with SECCO-3D (`--secenable`), **ffmpeg-rockchip** / rkmpp, and starter scripts.

## Downloads in this folder

| File | Description |
|------|-------------|
| **`rock-mp3d-mpv40-aarch64-20260621.tar.gz`** | **Recommended** — Tarball (~15 MB) |
| `rock-mp3d-mpv40-aarch64-20260621.run` | Alternative — self-extracting installer (~15 MB) |

Includes: `bin/mpv`, `lib/` (FFmpeg, libplacebo, libmpv), `play.sh`, `play-desktop.sh`, `play-desktop-lowdrop.sh`, `etc/rock-input.conf`

**mpv version in package:** v0.40.0-dev (mp3d-mpv40 + SECCO-3D)

---

## Requirements (target system)

Radxa/Rockchip image with MPP drivers, e.g. `rock-5b_bookworm_kde`:

```bash
sudo apt update
sudo apt install -y \
  libdrm2 libgbm1 libegl1 libgles2 libgl1 \
  libx11-6 libxext6 libxrandr2 libxv1 libxpresent1 \
  libasound2 libpulse0 libass9 libvulkan1 \
  librockchip-mpp1 librga2 mesa-utils

sudo usermod -aG video,render "$USER"
# Log in again!
```

Mesa/GPU (panfrost/rockchip DRI) and `librockchip-mpp` come from the **system** — not included in the package.

---

## Option 1: Tarball (recommended)

```bash
wget https://github.com/seccouser/rock-mp3d-mpv40/raw/main/dist/rock-mp3d-mpv40-aarch64-20260621.tar.gz

tar xzf rock-mp3d-mpv40-aarch64-20260621.tar.gz
cd rock-mp3d-mpv40-aarch64-20260621

cat INSTALL.txt
sudo ./install.sh
```

Installs to **`/opt/rock-mp3d-mpv40`**.

---

## Option 2: .run installer

```bash
wget https://github.com/seccouser/rock-mp3d-mpv40/raw/main/dist/rock-mp3d-mpv40-aarch64-20260621.run
chmod +x rock-mp3d-mpv40-aarch64-20260621.run
sudo ./rock-mp3d-mpv40-aarch64-20260621.run
```

Extract only (no system install):

```bash
./rock-mp3d-mpv40-aarch64-20260621.run --noexec --target ~/rock-mp3d
```

---

## Usage

| Command | Mode |
|---------|------|
| `rock-mp3d-play video.mp4` | TTY/DRM — best performance, with audio |
| `rock-mp3d-desktop video.mp4` | Desktop/X11 with audio |
| `rock-mp3d-desktop-lowdrop video.mp4` | Desktop, low frame drops |

TTY/DRM: `Ctrl+Alt+F3`, then:

```bash
rock-mp3d-play /path/to/video.mp4
```

From install directory:

```bash
/opt/rock-mp3d-mpv40/play.sh /path/to/video.mp4
```

---

## Uninstall

```bash
sudo /opt/rock-mp3d-mpv40/uninstall.sh
```

---

## Package layout (tarball)

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

## Notes

- **3D/SECCO:** `--secenable=yes` is enabled in the `play*.sh` scripts.
- **4K60:** Best results with `rock-mp3d-play` (DRM/TTY). Desktop: `rock-mp3d-desktop-lowdrop`.
- **Benchmark (Rock 5B+, `play.sh` + audio, 4K60, 30 s):** without GUI ~**0.8** drops/30 s (1, 1, 1, 0, 1); with desktop running ~**7.6** drops/30 s. Audio is not the issue — the GUI blocks DRM. Details: [readme_mpv_start.en.md](../readme_mpv_start.en.md).
- **mpv source:** [seccouser/mp3d-mpv40](https://github.com/seccouser/mp3d-mpv40)
- **Scripts & build:** see [README.en.md](../README.en.md)

---

**Author / Maintainer:** Ulrich Daehnert, Germany  
**Copyright © 2026 Ulrich Daehnert.** Documentation and packaging for this project.  
*Deutsch:* [INSTALL.md](INSTALL.md)
