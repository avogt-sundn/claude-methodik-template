# DevContainer — Domäne

## Zweck

Definiert die **VS Code Dev Container**-Umgebung für dieses Projekt. Ein Entwickler, der das Repository in VS Code (oder GitHub Codespaces) öffnet, landet in einem vollständig konfigurierten Container: korrekte Java/Maven/Node/npm-Versionen, Docker-outside-of-Docker, Playwright-Chromium und alle VS Code-Erweiterungen vorinstalliert.

## Bounded Context

Besitzt alles unter `.devcontainer/`:
- `devcontainer.json` — Container-Spec (Basis-Image, GHCR-Features, Mounts, Ports, Umgebungsvariablen, VS Code-Erweiterungen)
- `scripts/postCreateCommand.sh` — Auto-Discovery-Orchestrator für lokale Feature-postCreate-Skripte (läuft leer, wenn kein `features/`-Verzeichnis vorhanden)

Die Domäne hat **keine Laufzeit-Services** — sie ist reine Entwickler-Infrastruktur.

## Komponenten

| Datei / Skript | Zweck |
|---|---|
| `devcontainer.json` | Einstiegspunkt — Basis-Image, Features, Mounts, Ports, `initializeCommand`, `runArgs`, VS Code-Anpassungen |
| `scripts/postCreateCommand.sh` | Auto-Discovery-Orchestrator — führt `features/*/postCreate.sh` in lexikalischer Reihenfolge aus (fällt leer durch, wenn kein `features/`-Verzeichnis vorhanden) |

## GHCR-Features

Alle Features werden als publizierte Pakete von GHCR eingebunden — kein lokales `features/`-Verzeichnis mehr. **Ein Feature aktivieren/deaktivieren:** Eintrag in `devcontainer.json` → `features` hinzufügen oder entfernen.

| Feature | Registry | Zweck |
|---|---|---|
| `claude-code:1` | `ghcr.io/avogt-sundn/devcontainer-features` | Claude Code CLI |
| `copilot-cli:1` | `ghcr.io/avogt-sundn/devcontainer-features` | GitHub Copilot CLI |
| `devtools:1` | `ghcr.io/avogt-sundn/devcontainer-features` | Allgemeine Entwicklertools |
| `opencode:1` | `ghcr.io/avogt-sundn/devcontainer-features` | OpenCode-Konfiguration |
| `vertex-auth:1` | `ghcr.io/avogt-sundn/devcontainer-features` | Vertex AI Service-Account-Authentifizierung |
| `github-cli:1` | `ghcr.io/devcontainers/features` | `gh`-CLI |
| `zsh-plugins:0` | `ghcr.io/devcontainers-extra/features` | Zsh-Plugins |
| `docker-outside-of-docker:1` | `ghcr.io/devcontainers/features` | Docker-Socket-Zugriff vom Container |
| `ripgrep:1` | `ghcr.io/devcontainers-extra/features` | Schnelles Datei-Grep |

## Schlüsselentscheidungen

- **`--network=docker-default-network`** — der Container tritt demselben Docker-Netzwerk bei wie der Compose-Stack; andere Services sind per Hostname erreichbar.
- **`--hostname=${localWorkspaceFolderBasename}`** — Container-Hostname entspricht dem Repo-Ordnernamen; kein hardcoded Hostname.
- **Named Volumes für Caches** — `localcache` → `~/.m2` überlebt Container-Rebuilds.
- **Kein stage-spezifischer Config** — `remoteEnv`-Variablen sind der einzige Konfigurationsweg (CLAUDE-2).
- **Publizierte GHCR-Features statt lokaler `features/`** — `opencode`, `vertex-auth` und projektspezifische Tools werden als versionierte GHCR-Pakete unter `ghcr.io/avogt-sundn/devcontainer-features` veröffentlicht und eingebunden. Kein lokaler Build-Code im Repo.
- **Kein Dockerfile** — alle System-Pakete werden durch das `devtools`-Feature abgedeckt; das Basis-Image wird direkt per `"image"` in `devcontainer.json` referenziert.

## Anpassungen beim Setup

Folgende Stellen vor erstem Container-Build prüfen:

| Was | Wo | Aktion |
|---|---|---|
| Aktive Features | `devcontainer.json` → `features` | Nicht benötigte Features entfernen |
| Projektname | `devcontainer.json` → `"name"` | `{{PROJECT_NAME}}` ersetzen |
| Ports | `devcontainer.json` → `forwardPorts` | Nicht benötigte Ports entfernen |
| VS Code-Erweiterungen | `devcontainer.json` → `extensions` | Nicht benötigte entfernen (Java, Angular, etc.) |
| Vertex-Variablen | `devcontainer.json` → `remoteEnv` | `GCP_PROJECT_ID` und `GCP_REGION` auf dem Host setzen |
| Vertex-Credentials | Hostpfad `~/.config/gcp/vertex-service-account.json` | Datei lokal anlegen; wird read-only in den Container gemountet |
| Maven-Mirror | `devcontainer.json` → `remoteEnv.NPM_MIRROR` | Entfernen wenn kein lokaler npm-Mirror |
| Basis-Image | `devcontainer.json` → `"image"` | Ggf. auf leichteres Image wechseln (z. B. `base:bookworm`) wenn kein Java benötigt |

## Verlauf

- 2026-06-03 — Erstfassung
- 2026-06-11 — AWS-Bedrock-Default entfernt; Vertex-Setup mit localEnv-Credential-Mount dokumentiert
- 2026-06-11 — postCreate-Skripte in lokale DevContainer-Features (`features/`) überführt; `postCreateCommand.sh` auf Auto-Discovery umgestellt
- 2026-06-12 — Features auf Anforderungsanalyse-Profil ausgerichtet: `claude-code:1`, `copilot-cli:1`, `devtools:1` hinzugefügt; coding-spezifische Features entfernt; Playwright-OS-Deps aus Dockerfile entfernt
- 2026-06-12 — Lokales `features/`-Verzeichnis entfernt; alle Features als publizierte GHCR-Pakete unter `ghcr.io/avogt-sundn/devcontainer-features` eingebunden; DOMAIN.md auf neue Struktur aktualisiert
- 2026-06-12 — `Dockerfile` entfernt; System-Pakete durch `devtools`-Feature abgedeckt; Basis-Image direkt per `"image"` in `devcontainer.json` referenziert
