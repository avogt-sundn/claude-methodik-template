# Erkundungen — Domäne

## Zweck

Dieser Ordner enthält **offene Erkundungsdomänen**: zeitlich begrenzte Denkräume für Fragen, die vor einer Implementierungsentscheidung geklärt werden müssen. Jede Erkundung ist eine eigenständige Domäne mit eigenem Bounded Context.

Erkundungen sind keine Tickets und keine Aufgabenlisten — sie sind Wissensdestillate. Das Ergebnis ist entweder eine begründete Entscheidung, ein Muster oder die strukturierte Erkenntnis, dass eine Frage neu gestellt werden muss.

---

## Pflichtstruktur jeder Erkundungsdomäne

Jeder Unterordner muss mindestens enthalten:

| Datei | Inhalt |
|-------|--------|
| `DOMAIN.md` | Zweck, Leitfragen, Abgegrenzter Kontext, Schlüsselentscheidungen, `## Glossar`-Auszug — **diese Datei ist der Einstiegspunkt** |

Empfohlene optionale Dateien (je nach Bedarf):

| Datei | Inhalt |
|-------|--------|
| `BACKLOG.md` | Offene Fragen, nächste Schritte, Arbeitsstand |
| `quellen.md` | Kuratierte Quellen mit Einordnung |
| `*.md` | Analysen, Abstracts, Entscheidungsvorlagen — je Thema eine Datei |

Die `DOMAIN.md` listet im Abschnitt `## Abgegrenzter Kontext` alle Dateien des Ordners mit einem Einzeiler-Zweck.

---

## Benennungskonvention

Ordnernamen sind **Fragen in Kebab-Case**, ohne Sonderzeichen:

```
wie-<verb>-man-<gegenstand>
was-ist-<gegenstand>
welche-<gegenstand>-passt-zu-<kontext>
```

Beispiele: `wie-macht-man-pdfs-maschinenlesbar`, `welche-architektur-passt-zu-unserem-system`, `wie-modelliert-man-das-datenmodell`

Die Frageform zwingt zur Klarheit darüber, was die Erkundung beantworten soll.

---

## Arbeitskonvention: Entwicklungsweg sichtbar halten

Arbeitsdateien werden **nicht überschrieben**. Stattdessen:

**Bei kleinen Änderungen** — `## Verlauf`-Abschnitt am Dateiende fortschreiben:
```markdown
## Verlauf
- 2026-05-28 — Erstfassung
- 2026-05-29 — These 2 überarbeitet
```

**Bei größeren Umbrüchen** — neue Version als datierten Abschnitt anhängen, alte Version stehen lassen:
```markdown
## These — 2026-05-15
...ursprünglicher Text...

## These — 2026-05-28 (überarbeitet)
...neue Version...
```

Git fängt den Rest auf — `git log <datei>` zeigt die vollständige Geschichte.

---

## Abgegrenzter Kontext

Dieser Ordner gehört keiner technischen Infrastruktur an — er ist reiner Denkraum.

- `DOMAIN.md` — diese Datei: Strukturvorgabe und Prozess für alle Erkundungsdomänen
- `<frage>/DOMAIN.md` — Einstiegspunkt jeder Erkundungsdomäne

---

## Prozesse

### Neue Erkundung aufnehmen

1. **Frage klären** — Gemeinsam mit dem Nutzer präzisieren: Was soll beantwortet werden? Was ist der Auslöser? Was wäre ein gutes Ergebnis?
2. **Ordner anlegen** — Name in Frageform gemäß Benennungskonvention.
3. **`DOMAIN.md` erstellen** — Zweck, Leitfragen, Abgegrenzter Kontext, `## Glossar`-Auszug aus der Ubiquitären-Sprache-Erkundung. Die Leitfragen sind das Destillat aus Schritt 1.
4. **Wissenskarte in `CLAUDE.md` aktualisieren** — Neuen Eintrag in der Baumstruktur ergänzen.

### Erkundungen zusammenführen (Merge)

Zwei oder mehr Erkundungen werden zusammengeführt, wenn sie sich thematisch so weit angenähert haben, dass sie dieselbe Frage beantworten, oder wenn eine die andere vollständig einschließt.

1. **Zielordner bestimmen** — Welche Frage formuliert den gemeinsamen Kern am besten? Dieser Ordner wird beibehalten; ggf. umbenennen.
2. **Inhalte sichten** — Alle `.md`-Dateien beider Ordner lesen. Duplikate identifizieren, Ergänzungen markieren.
3. **Inhalte einarbeiten** — Nicht-doppelte Abschnitte aus dem Quellordner in passende Dateien des Zielordners übernehmen (Verlaufskonvention beachten: anhängen, nicht überschreiben).
4. **`DOMAIN.md` des Zielordners aktualisieren** — Zweck und Abgegrenzter Kontext neu schreiben; Merge im `## Verlauf` dokumentieren.
5. **Quellordner löschen** — Erst nach expliziter Bestätigung (CLAUDE-7).
6. **Wissenskarte in `CLAUDE.md` aktualisieren** — Eintrag des Quellordners entfernen.
