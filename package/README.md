# Package build scripts

Scripts to create release packages in [`../dist/`](../dist/).

| Script | Purpose |
|--------|---------|
| [`make-package.sh`](make-package.sh) | Build Tarball (recommended) |
| [`build-installer.sh`](build-installer.sh) | Build self-extracting `.run` |
| [`build-all.sh`](build-all.sh) | Build both |

Documentation: [README-INSTALL.en.md](README-INSTALL.en.md) · [README-INSTALL.md](README-INSTALL.md)

## Quick start (development machine)

Requires built mp3d-mpv40, ffmpeg-rockchip, and deps (default paths: sibling dirs `install-mp3d/`, `install/`, `deps-prefix/`).

```bash
./package/build-all.sh
```

Override paths if needed:

```bash
export PROJEKT_ROOT=/home/rock/projekte
export MP3D_PREFIX=$PROJEKT_ROOT/install-mp3d
export FFMPEG_PREFIX=$PROJEKT_ROOT/install
export DEPS_PREFIX=$PROJEKT_ROOT/deps-prefix
./package/make-package.sh
```

---

**Author / Maintainer:** Ulrich Daehnert, Germany  
**Copyright © 2026 Ulrich Daehnert.**
