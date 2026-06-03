# DevContainer — Domäne

## Zweck

Definiert die **VS Code Dev Container**-Umgebung für dieses Projekt. Ein Entwickler, der das Repository in VS Code (oder GitHub Codespaces) öffnet, landet in einem vollständig konfigurierten Container: korrekte Java/Maven/Node/npm-Versionen, Docker-outside-of-Docker, Playwright-Chromium und alle VS Code-Erweiterungen vorinstalliert.

## Bounded Context

Besitzt alles unter `.devcontainer/`:
- `devcontainer.json` — Container-Spec (Basis-Image, Features, Mounts, Ports, Umgebungsvariablen, VS Code-Erweiterungen)
- `Dockerfile` — Basis-Image-Anpassung (System-Pakete, AWS CLI, Playwright OS-Abhängigkeiten)
- `scripts/postCreate*.sh` — einmalige Setup-Schritte nach Container-Erstellung

Die Domäne hat **keine Laufzeit-Services** — sie ist reine Entwickler-Infrastruktur.

## Komponenten

| Datei / Skript | Zweck |
|---|---|
| `devcontainer.json` | Einstiegspunkt — Features, Mounts, Ports, `initializeCommand`, `runArgs`, VS Code-Anpassungen |
| `Dockerfile` | Erweitert `mcr.microsoft.com/devcontainers/java:dev-25-jdk-bookworm`; fügt System-Pakete, AWS CLI, Playwright OS-Bibliotheken hinzu |
| `scripts/postCreateCommand.sh` | Orchestrator — ruft alle `postCreate-*.sh` in Reihenfolge auf |
| `scripts/postCreate-Claude.sh` | Richtet AWS-Verzeichnis-Berechtigungen ein |
| `scripts/postCreate-Maven.sh` | Schreibt `~/.m2/settings.xml` mit lokalem Maven-Mirror (`maven-mirror:8080`) |
| `scripts/postCreate-npm.sh` | Setzt npm-Auth-Token für Verdaccio (`${NPM_MIRROR}`) |
| `scripts/postCreate-Playwright.sh` | Installiert Playwright-Testabhängigkeiten aus `tests/package.json` (optional) |
| `scripts/postCreate-Quarkus.sh` | Deaktiviert Quarkus-Telemetrie |

## Schlüsselentscheidungen

- **`--network=docker-default-network`** — der Container tritt demselben Docker-Netzwerk bei wie der Compose-Stack; andere Services sind per Hostname erreichbar.
- **`--hostname=${localWorkspaceFolderBasename}`** — Container-Hostname entspricht dem Repo-Ordnernamen; kein hardcoded Hostname.
- **Named Volumes für Caches** — `localcache` → `~/.m2` überlebt Container-Rebuilds.
- **Kein stage-spezifischer Config** — `remoteEnv`-Variablen sind der einzige Konfigurationsweg (CLAUDE-2).
- **Mirror-aware Maven** — `postCreate-Maven.sh` schreibt `settings.xml` für lokalen Reposilite-Mirror. Entfernen wenn kein Mirror vorhanden.

## Anpassungen beim Setup

Folgende Stellen vor erstem Container-Build prüfen:

| Was | Wo | Aktion |
|---|---|---|
| Projektname | `devcontainer.json` → `"name"` | `{{PROJECT_NAME}}` ersetzen |
| Ports | `devcontainer.json` → `forwardPorts` | Nicht benötigte Ports entfernen |
| VS Code-Erweiterungen | `devcontainer.json` → `extensions` | Nicht benötigte entfernen (Java, Angular, etc.) |
| AWS-Variablen | `devcontainer.json` → `remoteEnv` | Entfernen wenn kein AWS Bedrock |
| Maven-Mirror | `scripts/postCreate-Maven.sh` | Entfernen wenn kein lokaler Mirror |
| npm-Mirror | `scripts/postCreate-npm.sh` | Entfernen wenn kein lokaler npm-Mirror |
| Java-Tools | `Dockerfile` → Spring Boot CLI, Quarkus CLI | Entfernen wenn nicht benötigt |

## Verlauf

- 2026-06-03 — Erstfassung
