# Tickets — Domäne

## Zweck

Dieser Ordner verwaltet **Implementierungstickets** als dreistufiges Verfahren:

1. **Eingang** (`_eingang/`) — Staging-Bereich für rohe Jira-Exporte oder manuell erfasste Texte, bevor ein Ticket-Ordner angelegt wird.
2. **Ticket-Ordner** (`{ID}/`) — sobald ein Ticket bearbeitet wird, erhält es einen eigenen Ordner mit drei Dateien: `eingang.md` (eingefroren), `review.md` (Kritik und Quellabgleich) und `arbeitsstand.md` (aktuelle Verfeinerung und ACs).

Tickets sind damit gleichzeitig externe Quelle und Gegenstand der Analyse. `eingang.md` bleibt nach dem ersten Schreiben unberührt; `review.md` und `arbeitsstand.md` sind laufend erweiterbar.

---

## Dateistruktur

```
tickets/
├── DOMAIN.md          ← diese Datei
├── BACKLOG.md         ← Index aller Tickets mit Status
├── _eingang/          ← Staging: rohe Jira-Exporte / manuelle Texte (noch kein Ordner angelegt)
└── {ID}/              ← ein Ordner pro Ticket
    ├── eingang.md     ← eingefroren — unveränderter Originaltext
    ├── review.md      ← Kritik, Quellabgleich, Befunde
    └── arbeitsstand.md ← YAML-Header, Ziel, Acceptance Criteria, Offene Fragen, Verlauf
```

---

## Status-Enum

| Status | Bedeutung |
|--------|-----------|
| `eingang` | In `_eingang/` abgelegt, noch nicht reviewt |
| `in-review` | Review läuft |
| `verfeinert` | Review und Acceptance Criteria vollständig |
| `bereit` | Freigegeben zur Umsetzung |
| `erledigt` | Implementierung abgenommen |

---

## Dateiformat — arbeitsstand.md

```markdown
---
id: {ID}
status: eingang | in-review | verfeinert | bereit | erledigt
quelle: jira | manuell
eingang: {Datum YYYY-MM-DD}
---

# {ID} — Arbeitsstand

## Ziel

{Ein Satz: Was wird danach anders sein?}

## Acceptance Criteria

- [ ] {Kriterium 1}
- [ ] {Kriterium 2}

## Offene Fragen

- {Frage oder Blocker, der vor Umsetzung geklärt werden muss}

## Verlauf

- {YYYY-MM-DD} — Eingang
```

---

## Prozess: Neues Ticket aufnehmen

1. Originaldatei in `_eingang/` ablegen — unveränderter Eingang.
2. `{ID}/`-Ordner anlegen, `eingang.md` aus `_eingang/`-Datei füllen.
3. `review.md` erstellen, Kritik und Quellabgleich eintragen, Status auf `in-review`.
4. `arbeitsstand.md` erstellen (Vorlage oben), Status `eingang`.
5. BACKLOG.md-Eintrag ergänzen.
6. Acceptance Criteria erarbeiten: `arbeitsstand.md` befüllen, Status auf `verfeinert`.
7. Freigabe: Status auf `bereit`.

---

## Verlauf

- 2026-06-02 — Erstfassung
