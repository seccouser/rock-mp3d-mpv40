# Starting mpv on Rock 5B — Detailed guide

## Which script should I use?

| Your goal | Recommended script | Location | Audio |
|-----------|-------------------|----------|-------|
| Best picture quality + lowest drops | `play.sh` | TTY F3 | Yes |
| Normal use with sound | `play-desktop.sh` | Desktop | Yes |
| Maximum smoothness (display tests) | `play-desktop-lowdrop.sh` | Desktop | Yes |

## Benchmark results (Rock 5B+)

**Profile:** `play.sh` · **Audio:** on · **Video:** `bbb_sunflower_2160p_60fps_normal.mp4` (4K60) · **Duration:** 30 s from second 30 · **Build:** mp3d v0.40.0-dev, rkmpp, `--secenable=yes`

| Condition | Drops per run | Average |
|-----------|---------------|---------|
| **No GUI** — TTY/DRM, desktop stopped, card0 free | 1, 1, 1, 0, 1 | **~0.8 / 30 s** |
| **With GUI** — Plasma/KDE active (SSH test) | 10, 5, 7, 9, 7 | ~7.6 / 30 s |

Hardware decoding (rkmpp) and Pulse audio (48 kHz stereo) worked in both cases. **Audio does not cause noticeable extra drops** — what matters is whether the desktop holds `/dev/dri/card0`.

### TTY F3 (recommended)

1. `Ctrl+Alt+F3` → log in  
2. `./play.sh /path/to/video.mp4`  
3. During playback press **``** (backtick) → live stats including drop counter  
4. `Ctrl+Alt+F2` → back to desktop  

### Stop GUI for a clean DRM test (SSH only)

If you are connected via SSH only and need a clean measurement:

```bash
loginctl terminate-session 2    # end Plasma session (check ID: loginctl list-sessions)
cd /path/to/rock-mp3d-mpv40
./play.sh /path/to/video.mp4
# then log in again at the monitor (GDM login screen)
```

## Examples

```bash
# On TTY F3 (recommended for tests)
./play.sh /mnt/ssd/Videos/aquarium-sdr.mp4

# On desktop with audio
./play-desktop.sh /mnt/ssd/Videos/my-video.mp4

# Desktop — especially smooth
./play-desktop-lowdrop.sh /mnt/ssd/Videos/testvideo.mp4
```

---

**Author / Maintainer:** Ulrich Daehnert, Germany  
**Copyright © 2026 Ulrich Daehnert.** Documentation and packaging for this project.  
*Deutsch:* [readme_mpv_start.md](readme_mpv_start.md)
