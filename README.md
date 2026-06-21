# rock-mp3d-mpv40

Optimierter mpv-Fork + Starter-Scripts für den **Radxa Rock 5B (RK3588)** mit guter 4K60-Unterstützung und 3D-Funktionalität.

*English:* [README.en.md](README.en.md)

## Fertige Binary-Pakete (Installation)

**→ [dist/INSTALL.md](dist/INSTALL.md)** — Tarball und `.run`-Installer für Rock 5B (aarch64, ~15 MB)  
*English:* [dist/INSTALL.en.md](dist/INSTALL.en.md)

```bash
tar xzf dist/rock-mp3d-mpv40-aarch64-*.tar.gz
cd rock-mp3d-mpv40-aarch64-* && sudo ./install.sh
```

## Verfügbare Scripts

| Script                        | Empfohlener Ort | Audio | Drops          | Zweck                                      |
|-------------------------------|------------------|-------|----------------|--------------------------------------------|
| `play.sh`                     | **TTY F3**       | Nein  | Sehr niedrig   | Beste Performance + 3D-Tests              |
| `play-desktop.sh`             | Desktop (X11)    | Ja    | Mittel         | Normaler Gebrauch mit Ton                 |
| `play-desktop-lowdrop.sh`     | Desktop (X11)    | Nein  | Sehr niedrig   | Maximale Glätte für Display-Tests         |

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
