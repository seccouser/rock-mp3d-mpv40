# rock-mp3d-mpv40

Optimierter mpv-Fork + Starter-Scripts für den **Radxa Rock 5B (RK3588)** mit guter 4K60-Unterstützung und 3D-Funktionalität.

*English:* [README.en.md](README.en.md)

## Fertige Binary-Pakete (Installation)

**→ [dist/INSTALL.md](dist/INSTALL.md)** — Tarball und `.run`-Installer für Rock 5B (aarch64, ~15 MB)  
*English:* [dist/INSTALL.en.md](dist/INSTALL.en.md)

**Paket bauen:** [`package/`](package/) — Skripte für Tarball und `.run`-Installer

```bash
tar xzf dist/rock-mp3d-mpv40-aarch64-*.tar.gz
cd rock-mp3d-mpv40-aarch64-* && sudo ./install.sh
```

## Verfügbare Scripts

| Script                        | Empfohlener Ort | Audio | Drops          | Zweck                                      |
|-------------------------------|------------------|-------|----------------|--------------------------------------------|
| `play.sh`                     | **TTY F3**       | Ja    | ~0–1 / 30 s    | Beste Performance + 3D (mit Ton)            |
| `play-desktop.sh`             | Desktop (X11)    | Ja    | Mittel         | Normaler Gebrauch mit Ton                 |
| `play-desktop-lowdrop.sh`     | Desktop (X11)    | Ja    | Sehr niedrig   | Maximale Glätte für Display-Tests         |

### Benchmark (Rock 5B+, Juni 2026)

Getestet mit **`play.sh`** (rkmpp, `--secenable=yes`, **mit Audio**), Video `bbb_sunflower_2160p_60fps_normal.mp4` (4K60), je **30 s ab Sek. 30**, mpv v0.40.0-dev:

| Bedingung | Frame-Drops (5 Läufe) | Ø / 30 s |
|-----------|------------------------|----------|
| **TTY/DRM ohne GUI** (kein Desktop auf card0) | 1, 1, 1, 0, 1 | **~0,8** |
| Desktop/SSH aktiv (Plasma blockiert DRM) | 10, 5, 7, 9, 7 | ~7,6 |

**Fazit:** Mit Ton auf **TTY F3** praktisch butterweich. Die GUI-Konkurrenz um `/dev/dri/card0` ist der Hauptgrund für höhere Drops — nicht das Audio. Ohne vs. mit Ton im gleichen (degraderten) SSH-Test: praktisch gleich (~6 vs. ~8 Drops).

→ Details: [readme_mpv_start.md](readme_mpv_start.md)

### Schnellstart

```bash
# Beste Qualität (empfohlen)
./play.sh /pfad/zum/video.mp4

# Mit Audio auf dem Desktop
./play-desktop.sh /pfad/zum/video.mp4

# Sehr flüssig auf dem Desktop
./play-desktop-lowdrop.sh /pfad/zum/video.mp4
```

---

**Autor / Maintainer:** Ulrich Daehnert, Deutschland  
**Copyright © 2026 Ulrich Daehnert.** Dokumentation und Paketierung dieses Projekts.  
*English:* [README.en.md](README.en.md) · [AUTHORS.md](AUTHORS.md)
