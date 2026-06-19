# rock-mp3d-mpv40

Optimierter mpv-Fork + Starter-Scripts für den **Radxa Rock 5B (RK3588)** mit guter 4K60-Unterstützung und 3D-Funktionalität.

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
