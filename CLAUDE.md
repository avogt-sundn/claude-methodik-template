# CLAUDE.md

> **Setup:** Suche und ersetze alle `{{PLACEHOLDER}}`-Marker in diesem Kit, bevor du arbeitest.
> Liste aller Marker: `grep -r "{{" claude-methodik-template/`

> **Sprache**: Alle Markdown-Dateien in diesem Repository werden auf **Deutsch** verfasst.

---

## Projekt

{{PROJEKT_BESCHREIBUNG — Ein Satz: Was ist das System, welches Problem löst es?}}

Referenzmaterialien in `quelldokumente/`:
- {{QUELLDOKUMENT_1}} — {{BESCHREIBUNG}}
- {{QUELLDOKUMENT_2}} — {{BESCHREIBUNG}}

---

## Axiome

Übergreifende Regeln für jeden Agenten und jede Änderung.

- **[CLAUDE-1] Klarheit und Kürze.** Kein Padding, keine Redundanz, kein Fülltext. Jede Zeile muss ihren Platz verdienen.
- **[CLAUDE-2] Lokalität und Hierarchie.** Jede Zeile lebt so nah wie möglich an ihrem Verwendungsort. Belange werden in einer strikten Hierarchie getrennt.
- **[CLAUDE-3] Lesen vor Schreiben.** Vor jeder Dateiänderung muss die aktuelle Version in derselben Session gelesen worden sein. Schreiben aus dem Gedächtnis oder aus einer anderen Session ist verboten.
- **[CLAUDE-4] Ergebnisse verifizieren, nicht Absichten.** Eine Aufgabe ist erledigt, wenn die Änderung nachweislich funktioniert — nicht wenn der Code geschrieben wurde.
- **[CLAUDE-5] Minimaler Fußabdruck.** Nur das Explizit-Beauftragte ändern. Kein opportunistisches Refactoring, kein Cleanup, keine präventiven Ergänzungen. Beobachtete Probleme melden, nicht still beheben.
- **[CLAUDE-6] Jeden stillen Standard vor dem Handeln benennen.** Wenn der Agent einen Pfad, Port, Typ oder Namenskonvention ergänzt, die nicht explizit vorgegeben wurde, muss er das vor dem Schreiben deklarieren.
- **[CLAUDE-7] Explizite Bestätigung vor irreversiblen Aktionen.** Alles, was nicht durch ein einfaches `git revert` rückgängig gemacht werden kann, erfordert eine explizite Bestätigung.
- **[CLAUDE-8] Vor dem Erfinden replizieren.** Bevor Code, Konfiguration oder Dokumentation produziert wird, das nächste passende Beispiel im Repository suchen und dessen Struktur, Benennung und Stil übernehmen.
- **[CLAUDE-9] Jede Domäne dokumentiert sich selbst.** Jeder Domänen-Ordner enthält eine `DOMAIN.md` mit Zweck, Bounded Context und Schlüsselentscheidungen.
- **[CLAUDE-10] Ubiquitäre Sprache — Glossarbegriffe sind erstklassige Code-Identifier.** Code ist standardmäßig Englisch. Ausnahme: Fachbegriffe, die im Glossar der Ubiquitären-Sprache-Erkundung (Wahrheitsquelle) oder im `## Glossar`-Abschnitt einer `DOMAIN.md` (Auszug) dokumentiert sind, sind die *einzig zulässige* Form für dieses Konzept im Code dieser Domäne — niemals in eine andere Sprache übersetzen.
- **[CLAUDE-11] Ordner-Closure.** Bei Aufgaben, die auf einen Ordner `F` begrenzt sind: (1) alle Dateioperationen auf `F` und seine Nachkommen beschränken; (2) nur `.md`-Steuerdateien in `F` und dessen Vorfahren bis zum Repo-Root befolgen; (3) keine Regel eines Nachfahren überschreibt eine Regel eines Vorfahren.
- **[CLAUDE-12] Sub-Agent-Delegation vor dem Aufruf ankündigen.** Orchestrierende Agenten müssen jeden Sub-Agenten und dessen Begründung nennen, bevor sie ihn aufrufen.
- **[CLAUDE-13] Wissenskarte vor jeder Scoped-Arbeit traversieren.** Vor jeder Ausgabe für eine Domäne, einen Ordner oder ein Ticket in dieser Reihenfolge lesen: (1) `CLAUDE.md`, (2) relevante Agent-Dateien aus `.claude/agents/`, (3) `<domäne>/DOMAIN.md`. Partielle Traversierung gilt nicht.
- **[CLAUDE-14] Geltende Regel für jede nicht-triviale Entscheidung nennen.** Bei der Wahl zwischen gültigen Optionen — Benennung, Ansatz, Architektur, Strategie — muss der Agent benennen, welches Axiom, welche Konvention oder welches bestehende Muster diese Wahl begründet. Stille Standards sind verboten; jeder sichtbare Entscheidungspunkt muss seine Begründung tragen.
- **[CLAUDE-15] Diagramme immer als SVG — Styleguide und Vorlage zwingend.** Jedes Diagramm, jede Skizze und jedes Schema wird als `.svg`-Datei angelegt und per `![Titel](datei.svg)` verlinkt. ASCII-Grafiken in Codeblöcken sind verboten — auch als Entwurf. Vor jeder neuen SVG müssen `.claude/grafiken/STYLEGUIDE.md` und `.claude/grafiken/vorlage.svg` in derselben Session gelesen worden sein; die `<defs>` (Marker + CSS-Klassen) aus der Vorlage sind Ausgangspunkt jeder SVG.

---

## Wissenskarte

```
CLAUDE.md                                              [CLAUDE]  ← übergreifende Axiome (diese Datei)
├── .devcontainer/DOMAIN.md                                       ← DevContainer-Infrastruktur
├── .claude/agents/                                               ← Agenten-Specs
├── erkundungen/DOMAIN.md                              [ERK]     ← Strukturvorgabe für alle Erkundungen
└── tickets/DOMAIN.md                                             ← Ticket-Verfahren
```

> Nach dem Setup: Wissenskarte mit den ersten Erkundungen befüllen.  
> Muster: `├── erkundungen/<frage>/DOMAIN.md  ← Zweck in einem Satz`

---

## API / Schnittstellen

{{API_BESCHREIBUNG — Tabelle mit Methode, Pfad, Beschreibung. Löschen falls nicht zutreffend.}}

---

## Geplanter Tech-Stack

| Schicht | Technologie | Status |
|---------|-------------|--------|
| Backend | {{BACKEND_TECH}} | {{noch nicht scaffolded / in Betrieb}} |
| Frontend | {{FRONTEND_TECH}} | {{noch nicht scaffolded / in Betrieb}} |
| Testing | {{TEST_TECH}} | — |

```bash
# Build/Test/Run-Befehle hier eintragen, sobald bekannt
```

---

## DevContainer-Infrastruktur

| Port | Service |
|------|---------|
| {{PORT}} | {{SERVICE}} |

**Verfügbare CLI-Tools** (je nach DevContainer):

| Tool | Befehl |
|------|--------|
| {{TOOL}} | {{BEFEHL}} |

---

## Konventionen

**Ticket-Tracking**: Zweistufiges Verfahren in `tickets/`. Eingang in `tickets/_eingang/` ablegen — unveränderlich. Verfeinerung in `tickets/{ID}/` mit drei Dateien: `eingang.md`, `review.md`, `arbeitsstand.md`. Index in `tickets/BACKLOG.md`. Prozess in `tickets/DOMAIN.md`.

**Domänendokumentation**: Jede Domäne hat eine `DOMAIN.md`. Pflichtabschnitte: Zweck, Abgegrenzter Kontext, Schlüsselentscheidungen, Glossar-Auszug, Verlauf.

**Entwicklungsweg sichtbar halten**: Arbeitsdateien werden nie überschrieben — der Erkenntnisweg bleibt Teil des Dokuments.

- **Kleine Änderungen** — `## Verlauf`-Abschnitt am Dateiende fortschreiben:
  ```markdown
  ## Verlauf
  - 2026-05-22 — Erstfassung
  - 2026-05-23 — These 3 überarbeitet
  ```
- **Größere Umbrüche** — neue Version als datierten Abschnitt anhängen, alte Version stehen lassen:
  ```markdown
  ## These — 2026-05-15
  ...ursprünglicher Text...

  ## These — 2026-05-22 (überarbeitet)
  ...neue Version...
  ```

---

## Claude Code

{{CLAUDE_PROVIDER}} — {{MODELL_KONFIGURATION}}.  
Empfehlung: Opus für Planung (methodology-advisor, session-observer), Sonnet für Ausführung.
