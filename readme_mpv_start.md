# mpv auf dem Rock 5B starten – Detaillierte Anleitung

## Welches Script soll ich verwenden?

| Dein Ziel | Empfohlenes Script | Ort | Audio |
|-----------|-------------------|-----|-------|
| Beste Bildqualität + niedrigste Drops | `play.sh` | TTY F3 | Ja |
| Normaler Gebrauch mit Ton | `play-desktop.sh` | Desktop | Ja |
| Maximale Glätte (auch für Display-Tests) | `play-desktop-lowdrop.sh` | Desktop | Ja |

## Benchmark-Ergebnisse (Rock 5B+)

**Profil:** `play.sh` · **Audio:** an · **Video:** `bbb_sunflower_2160p_60fps_normal.mp4` (4K60) · **Dauer:** 30 s ab Sek. 30 · **Build:** mp3d v0.40.0-dev, rkmpp, `--secenable=yes`

| Bedingung | Drops pro Lauf | Durchschnitt |
|-----------|----------------|--------------|
| **Ohne GUI** — TTY/DRM, Desktop beendet, card0 frei | 1, 1, 1, 0, 1 | **~0,8 / 30 s** |
| **Mit GUI** — Plasma/KDE aktiv (SSH-Test) | 10, 5, 7, 9, 7 | ~7,6 / 30 s |

Hardwaredecoding (rkmpp) und Pulse-Audio (48 kHz Stereo) liefen in beiden Fällen. **Audio verursacht keine spürbaren Extra-Drops** — entscheidend ist, ob der Desktop `/dev/dri/card0` blockiert.

### TTY F3 (empfohlen)

1. `Ctrl+Alt+F3` → einloggen  
2. `./play.sh /pfad/zum/video.mp4`  
3. Während der Wiedergabe **``** (Backtick) → Live-Stats inkl. Drop-Zähler  
4. `Ctrl+Alt+F2` → zurück zum Desktop  

### GUI für DRM-Test beenden (nur SSH)

Wenn du nur per SSH verbunden bist und einen sauberen Messwert brauchst:

```bash
loginctl terminate-session 2    # Plasma-Session beenden (Session-ID ggf. prüfen: loginctl list-sessions)
cd /pfad/zu/rock-mp3d-mpv40
./play.sh /pfad/zum/video.mp4
# danach am Monitor neu einloggen (GDM-Login)
```

## Start-Beispiele

```bash
# Auf TTY F3 (empfohlen für Tests)
./play.sh /mnt/ssd/Videos/aquarium-sdr.mp4

# Auf dem Desktop mit Ton
./play-desktop.sh /mnt/ssd/Videos/mein-video.mp4

# Desktop – besonders flüssig
./play-desktop-lowdrop.sh /mnt/ssd/Videos/testvideo.mp4
```

---

**Autor / Maintainer:** Ulrich Daehnert, Deutschland  
**Copyright © 2026 Ulrich Daehnert.** Dokumentation und Paketierung dieses Projekts.  
*English:* [readme_mpv_start.en.md](readme_mpv_start.en.md)
