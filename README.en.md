# rock-mp3d-mpv40

Optimized mpv fork + starter scripts for the **Radxa Rock 5B (RK3588)** with solid 4K60 support and 3D functionality.

## Ready-to-use binary packages (installation)

**→ [dist/INSTALL.en.md](dist/INSTALL.en.md)** — Tarball and `.run` installer for Rock 5B (aarch64, ~15 MB)  
**Build scripts:** [package/](package/)

```bash
tar xzf dist/rock-mp3d-mpv40-aarch64-*.tar.gz
cd rock-mp3d-mpv40-aarch64-* && sudo ./install.sh
```

## Available scripts

| Script | Recommended location | Audio | Drops | Purpose |
|--------|----------------------|-------|-------|---------|
| `play.sh` | **TTY F3** | Yes | ~0–1 / 30 s | Best performance + 3D (with audio) |
| `play-desktop.sh` | Desktop (X11) | Yes | Medium | Normal use with sound |
| `play-desktop-lowdrop.sh` | Desktop (X11) | Yes | Very low | Maximum smoothness for display tests |

### Benchmark (Rock 5B+, June 2026)

Tested with **`play.sh`** (rkmpp, `--secenable=yes`, **with audio**), video `bbb_sunflower_2160p_60fps_normal.mp4` (4K60), **30 s from second 30** each run, mpv v0.40.0-dev:

| Condition | Frame drops (5 runs) | Avg / 30 s |
|-----------|----------------------|------------|
| **TTY/DRM without GUI** (no desktop on card0) | 1, 1, 1, 0, 1 | **~0.8** |
| Desktop/SSH active (Plasma holds DRM) | 10, 5, 7, 9, 7 | ~7.6 |

**Conclusion:** With audio on **TTY F3**, playback is essentially smooth. GUI contention for `/dev/dri/card0` is the main cause of higher drops — not audio. With vs. without audio in the same degraded SSH test: practically identical (~6 vs. ~8 drops).

→ Details: [readme_mpv_start.en.md](readme_mpv_start.en.md)

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
