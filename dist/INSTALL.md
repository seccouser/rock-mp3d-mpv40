# rock-mp3d-mpv40 — Installation (Radxa Rock 5B, aarch64)

Fertige Binary-Pakete für **mpv mp3d-mpv40** mit SECCO-3D (`--secenable`), **ffmpeg-rockchip** / rkmpp und Starter-Scripts.

## Downloads in diesem Ordner

| Datei | Beschreibung |
|-------|----------------|
| **`rock-mp3d-mpv40-aarch64-20260621.tar.gz`** | **Empfohlen** — Tarball (~15 MB) |
| `rock-mp3d-mpv40-aarch64-20260621.run` | Alternative — selbstentpackender Installer (~15 MB) |

Enthalten: `bin/mpv`, `lib/` (FFmpeg, libplacebo, libmpv), `play.sh`, `play-desktop.sh`, `play-desktop-lowdrop.sh`, `etc/rock-input.conf`

**mpv-Version im Paket:** v0.40.0-dev (mp3d-mpv40 + SECCO-3D)

---

## Voraussetzungen (Zielsystem)

Radxa/Rockchip-Image mit MPP-Treiber, z. B. `rock-5b_bookworm_kde`:

```bash
sudo apt update
sudo apt install -y \
  libdrm2 libgbm1 libegl1 libgles2 libgl1 \
  libx11-6 libxext6 libxrandr2 libxv1 libxpresent1 \
  libasound2 libpulse0 libass9 libvulkan1 \
  librockchip-mpp1 librga2 mesa-utils

sudo usermod -aG video,render "$USER"
# Neu einloggen!
```

Mesa/GPU (panfrost/rockchip DRI) und `librockchip-mpp` kommen vom **System** — nicht im Paket enthalten.

---

## Variante 1: Tarball (empfohlen)

```bash
# Paket holen (Browser, wget oder git clone)
wget https://github.com/seccouser/rock-mp3d-mpv40/raw/main/dist/rock-mp3d-mpv40-aarch64-20260621.tar.gz

tar xzf rock-mp3d-mpv40-aarch64-20260621.tar.gz
cd rock-mp3d-mpv40-aarch64-20260621

cat INSTALL.txt          # Kurzreferenz im Paket
sudo ./install.sh
```

Installiert nach **`/opt/rock-mp3d-mpv40`**.

---

## Variante 2: .run-Installer

```bash
wget https://github.com/seccouser/rock-mp3d-mpv40/raw/main/dist/rock-mp3d-mpv40-aarch64-20260621.run
chmod +x rock-mp3d-mpv40-aarch64-20260621.run
sudo ./rock-mp3d-mpv40-aarch64-20260621.run
```

Nur entpacken (ohne System-Installation):

```bash
./rock-mp3d-mpv40-aarch64-20260621.run --noexec --target ~/rock-mp3d
```

---

## Nutzung

| Befehl | Modus |
|--------|--------|
| `rock-mp3d-play video.mp4` | TTY/DRM — beste Performance |
| `rock-mp3d-desktop video.mp4` | Desktop/X11 mit Audio |
| `rock-mp3d-desktop-lowdrop video.mp4` | Desktop, wenig Frame-Drops |

TTY/DRM: `Ctrl+Alt+F3`, dann:

```bash
rock-mp3d-play /pfad/zum/video.mp4
```

Direkt aus dem Installationsordner:

```bash
/opt/rock-mp3d-mpv40/play.sh /pfad/zum/video.mp4
```

---

## Deinstallation

```bash
sudo /opt/rock-mp3d-mpv40/uninstall.sh
```

---

## Paketstruktur (Tarball)

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

## Hinweise

- **3D/SECCO:** `--secenable=yes` ist in den `play*.sh`-Scripts bereits aktiv.
- **4K60:** Beste Ergebnisse mit `rock-mp3d-play` (DRM/TTY). Desktop: `rock-mp3d-desktop-lowdrop`.
- **Quellcode mpv:** [seccouser/mp3d-mpv40](https://github.com/seccouser/mp3d-mpv40)
- **Scripts & BUILD:** siehe [README.md](../README.md) im Repo-Root
