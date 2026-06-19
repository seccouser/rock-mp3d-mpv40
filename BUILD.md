# Build-Anleitung für mp3dplayer (Rock 5B)

Diese Anleitung beschreibt, wie du den mpv-Fork mit Rockchip-Unterstützung auf einem **Radxa Rock 5B** neu bauen kannst.
Das system wurde mit dem orginal Radxa Rock 5b Kernel -> rock-5b_bookworm_kde_b5  erstellt !!!
LINK zur Downloadseite -> https://docs.radxa.com/en/rock5/rock5b/download
## 1. System aktualisieren

```bash
sudo apt update && sudo apt upgrade -y
Benötigte Build-Tools installieren

bash 
sudo apt install -y \
    build-essential \
    meson \
    ninja-build \
    pkg-config \
    git \
    python3 \
    python3-pip

Entwicklungspakete für mpv installieren

bash
sudo apt install -y \
    libavcodec-dev \
    libavfilter-dev \
    libavformat-dev \
    libavutil-dev \
    libswresample-dev \
    libswscale-dev \
    libass-dev \
    libdrm-dev \
    libgbm-dev \
    libegl1-mesa-dev \
    libgles2-mesa-dev \
    libgl1-mesa-dev \
    libx11-dev \
    libxext-dev \
    libxrandr-dev \
    libxinerama-dev \
    libxv-dev \
    libpulse-dev \
    libasound2-dev \
    libsndio-dev \
    rubberband-dev \
    libuchardet-dev \
    zlib1g-dev \
    libjpeg-dev \
    libdisplay-info-dev \
    libplacebo-dev \
    libvulkan-dev \
    mesa-vulkan-drivers

Optional (für erweiterte Features)

bash
sudo apt install -y \
    libwayland-dev \
    libwayland-egl-backend-dev \
    wayland-protocols \
    libxkbcommon-dev

Beispiel für das Bauen !!!

# Beispiel: Vanilla mpv 0.40 mit Rockchip-Patches
git clone https://github.com/mpv-player/mpv.git
cd mpv
git checkout v0.40.0

meson setup build \
    -Dvulkan=enabled \
    -Dgl=enabled \
    -Dgbm=enabled \
    -Ddrm=enabled \
    -Degl=enabled \
    -Dx11=enabled \
    -Dlibmpv=true \
    -Dbuildtype=release

ninja -C build -j4

fertiger mpv in:

# Beispiel: Vanilla mpv 0.40 mit Rockchip-Patches
git clone https://github.com/mpv-player/mpv.git
cd mpv
git checkout v0.40.0

meson setup build \
    -Dvulkan=enabled \
    -Dgl=enabled \
    -Dgbm=enabled \
    -Ddrm=enabled \
    -Degl=enabled \
    -Dx11=enabled \
    -Dlibmpv=true \
    -Dbuildtype=release

ninja -C build -j4
