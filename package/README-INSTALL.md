# rock-mp3d-mpv40 — Installationspaket

Zwei Varianten für **Radxa Rock 5B / RK3588** (aarch64):

| Datei | Beschreibung |
|-------|----------------|
| **`rock-mp3d-mpv40-aarch64-*.tar.gz`** | **Empfohlen** — Tarball, klar strukturiert |
| `rock-mp3d-mpv40-aarch64-*.run` | Alternative — eine Datei, selbstentpackend |

Inhalt beider Varianten:
- `bin/mpv` (mp3d-mpv40 + SECCO-3D / `--secenable`)
- `lib/` mit ffmpeg-rockchip, libplacebo, libmpv
- Starter-Scripts: `play.sh`, `play-desktop.sh`, …

---

## Variante 1: Tarball (empfohlen)

```bash
# Auf dem Zielsystem:
tar xzf rock-mp3d-mpv40-aarch64-*.tar.gz
cd rock-mp3d-mpv40-aarch64-*

cat INSTALL.txt          # Kurzanleitung
sudo ./install.sh        # → /opt/rock-mp3d-mpv40
```

**Paketstruktur nach dem Entpacken:**

```
rock-mp3d-mpv40-aarch64-*/
├── INSTALL.txt
├── install.sh / uninstall.sh
├── run-mpv40.sh
├── play.sh, play-desktop.sh, play-desktop-lowdrop.sh
├── bin/mpv, bin/ffmpeg, bin/ffprobe
├── lib/aarch64-linux-gnu/    ← gebündelte Libraries
└── etc/rock-input.conf, mpv-4k.conf
```

---

## Variante 2: .run-Installer

```bash
chmod +x rock-mp3d-mpv40-aarch64-*.run
sudo ./rock-mp3d-mpv40-aarch64-*.run
```

---

## System-Voraussetzungen (beide Varianten)

Radxa/Rockchip-Image mit MPP (z. B. `rock-5b_bookworm_kde`):

```bash
sudo apt update
sudo apt install -y \
  libdrm2 libgbm1 libegl1 libgles2 libgl1 \
  libx11-6 libxext6 libxrandr2 libxv1 libxpresent1 \
  libasound2 libpulse0 libass9 libvulkan1 \
  librockchip-mpp1 librga2 mesa-utils
sudo usermod -aG video,render "$USER"
```

Mesa/GPU-Treiber kommen vom System — nicht im Paket enthalten.

---

## Nutzung nach der Installation

```bash
rock-mp3d-play              /pfad/video.mp4   # TTY/DRM
rock-mp3d-desktop           /pfad/video.mp4   # Desktop + Audio
rock-mp3d-desktop-lowdrop   /pfad/video.mp4   # Desktop, flüssig
```

Oder direkt:

```bash
/opt/rock-mp3d-mpv40/play.sh /pfad/video.mp4
```

## Deinstallation

```bash
sudo /opt/rock-mp3d-mpv40/uninstall.sh
```

---

## Paket neu bauen (Entwicklungsrechner)

```bash
./package/make-package.sh      # nur Tarball
./package/build-installer.sh   # nur .run
./package/build-all.sh         # beides → dist/
```

Requires a built mp3d-mpv40 (default: `../install-mp3d/bin/mpv` next to this repo).

---

**Autor / Maintainer:** Ulrich Daehnert, Deutschland  
**Copyright © 2026 Ulrich Daehnert.** Dokumentation und Paketierung dieses Projekts.  
*English:* [README-INSTALL.en.md](README-INSTALL.en.md)
