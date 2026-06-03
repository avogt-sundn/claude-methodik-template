# claude-methodik-template

Portables Starter-Kit für die KI-gestützte Arbeitsweise mit Claude Code.  
Enthält 15 Axiome, 6 spezialisierte Agenten, Lifecycle-Hooks, SVG-Styleguide und Domänen-Workflows.

---

## Einrichten

### 1. Template klonen oder kopieren

```bash
# Option A: Template direkt als neues Repo klonen
git clone <template-url> mein-neues-projekt
cd mein-neues-projekt
git remote remove origin   # oder neuen Remote setzen

# Option B: Dateien in bestehendes Repo kopieren
cp -r claude-methodik-template/. /pfad/zum/neuen-repo/
```

### 2. Claude Code öffnen und einen Satz tippen

```
initialize this project
```

Der `projekt-init`-Agent stellt alle nötigen Fragen, ersetzt die Platzhalter, legt die Verzeichnisse an und löst den ersten Commit aus. Fertig.

---

## Was ist drin

| Datei | Zweck |
|-------|-------|
| `CLAUDE.md` | 15 Axiome + Wissenskarte + Projektkontext |
| `.claude/agents/git-commit-master.md` | Atomare Commits, Pre-Commit-Checks, GIT-1–4-Axiome |
| `.claude/agents/session-observer.md` | ADRs, Session-Summaries, Token-Optimierung |
| `.claude/agents/methodology-advisor.md` | Backward-Planning, Ticket-Qualitätsgate, Ressourcenzuweisung |
| `.claude/agents/docs-export.md` | Markdown + Mermaid → HTML + PDF |
| `.claude/agents/quelldokumente-eingang.md` | Quelldokument-Intake-Pipeline |
| `.claude/agents/projekt-init.md` | Interaktive Ersteinrichtung via `initialize this project` |
| `.claude/settings.json` | Hooks (Notification, File-Tracking, Git-Commit-Sperre), Permissions |
| `.claude/statusline-command.sh` | Statuszeile: Modell + Kontext-Auslastung |
| `.claude/grafiken/STYLEGUIDE.md` | SVG-Farbpalette, Typografie, Geometrie |
| `.claude/grafiken/vorlage.svg` | SVG-Ausgangspunkt mit `<defs>` (Marker + CSS) |
| `erkundungen/DOMAIN.md` | Meta-Pattern für Erkundungsdomänen |
| `tickets/DOMAIN.md` | Dreistufiger Ticket-Workflow |

---

## Kernprinzipien

- **Lesen vor Schreiben** (CLAUDE-3): Vor jeder Dateiänderung die aktuelle Version lesen.
- **Wissenskarte traversieren** (CLAUDE-13): Vor Scoped-Arbeit immer `CLAUDE.md` → Agent-Spec → Domänen-`DOMAIN.md` lesen.
- **Commits nur über git-commit-master**: Direkte `git commit`-Befehle werden durch den PreToolUse-Hook geblockt.
- **SVG-only-Diagramme** (CLAUDE-15): Kein ASCII-Art. Styleguide + Vorlage vor jeder neuen SVG lesen.
- **Entwicklungsweg sichtbar halten**: Arbeitsdateien nie überschreiben — `## Verlauf`-Abschnitte anhängen.
