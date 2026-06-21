# Build guide for mp3d player (Rock 5B)

This guide describes how to rebuild the mpv fork with Rockchip support on a **Radxa Rock 5B**.

Tested with the official Radxa Rock 5B image: `rock-5b_bookworm_kde_b5`  
Download: https://docs.radxa.com/en/rock5/rock5b/download

## 1. Update system

```bash
sudo apt update && sudo apt upgrade -y
```

## 2. Install build tools

```bash
sudo apt install -y \
    build-essential \
    meson \
    ninja-build \
    pkg-config \
    git \
    python3 \
    python3-pip
```

## 3. Install mpv development packages

```bash
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
```

### Optional (extended features)

```bash
sudo apt install -y \
    libwayland-dev \
    libwayland-egl-backend-dev \
    wayland-protocols \
    libxkbcommon-dev
```

## 4. Build example (mpv 0.40 + Rockchip)

For the SECCO-3D fork, use [seccouser/mp3d-mpv40](https://github.com/seccouser/mp3d-mpv40) with **ffmpeg-rockchip** (nyanmisaka).

```bash
git clone https://github.com/seccouser/mp3d-mpv40.git
cd mp3d-mpv40

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
sudo ninja -C build install
```

Ready-made binaries: see [dist/INSTALL.en.md](dist/INSTALL.en.md).

---

**Author / Maintainer:** Ulrich Daehnert, Germany  
**Copyright © 2026 Ulrich Daehnert.** Documentation and packaging for this project.  
*Deutsch:* [BUILD.md](BUILD.md)
