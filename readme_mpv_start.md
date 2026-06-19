
---

### Inhalt für `readme_mpv_start.md`

Kopiere diesen Text in den zweiten Editor:

```markdown
# mpv auf dem Rock 5B starten – Detaillierte Anleitung

## Welches Script soll ich verwenden?

| Dein Ziel                                   | Empfohlenes Script             | Ort          | Audio |
|---------------------------------------------|--------------------------------|--------------|-------|
| Beste Bildqualität + niedrigste Drops       | `play.sh`                      | TTY F3       | Nein  |
| Normaler Gebrauch mit Ton                   | `play-desktop.sh`              | Desktop      | Ja    |
| Maximale Glätte (auch für Display-Tests)    | `play-desktop-lowdrop.sh`      | Desktop      | Nein  |

## Start-Beispiele

```bash
# Auf TTY F3 (empfohlen für Tests)
./play.sh /mnt/ssd/Videos/aquarium-sdr.mp4

# Auf dem Desktop mit Ton
./play-desktop.sh /mnt/ssd/Videos/mein-video.mp4

# Desktop – besonders flüssig
./play-desktop-lowdrop.sh /mnt/ssd/Videos/testvideo.mp4
