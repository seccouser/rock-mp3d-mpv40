# Starting mpv on Rock 5B — Detailed guide

## Which script should I use?

| Your goal | Recommended script | Location | Audio |
|-----------|-------------------|----------|-------|
| Best picture quality + lowest drops | `play.sh` | TTY F3 | No |
| Normal use with sound | `play-desktop.sh` | Desktop | Yes |
| Maximum smoothness (display tests) | `play-desktop-lowdrop.sh` | Desktop | No |

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
