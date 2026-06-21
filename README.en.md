# rock-mp3d-mpv40

Optimized mpv fork + starter scripts for the **Radxa Rock 5B (RK3588)** with solid 4K60 support and 3D functionality.

## Ready-to-use binary packages (installation)

**→ [dist/INSTALL.en.md](dist/INSTALL.en.md)** — Tarball and `.run` installer for Rock 5B (aarch64, ~15 MB)

```bash
tar xzf dist/rock-mp3d-mpv40-aarch64-*.tar.gz
cd rock-mp3d-mpv40-aarch64-* && sudo ./install.sh
```

## Available scripts

| Script | Recommended location | Audio | Drops | Purpose |
|--------|----------------------|-------|-------|---------|
| `play.sh` | **TTY F3** | No | Very low | Best performance + 3D tests |
| `play-desktop.sh` | Desktop (X11) | Yes | Medium | Normal use with sound |
| `play-desktop-lowdrop.sh` | Desktop (X11) | No | Very low | Maximum smoothness for display tests |

### Quick start

```bash
# Best quality (recommended)
./play.sh /path/to/video.mp4

# Desktop with audio
./play-desktop.sh /path/to/video.mp4

# Very smooth on desktop
./play-desktop-lowdrop.sh /path/to/video.mp4
```

---

**Author / Maintainer:** Ulrich Daehnert, Germany  
**Copyright © 2026 Ulrich Daehnert.** Documentation and packaging for this project.  
*Deutsch:* [README.md](README.md) · [AUTHORS.md](AUTHORS.md)
