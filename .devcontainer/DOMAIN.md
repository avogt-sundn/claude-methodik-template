# DevContainer — Domäne

## Zweck

Definiert die **VS Code Dev Container**-Umgebung für dieses Projekt. Ein Entwickler, der das Repository in VS Code (oder GitHub Codespaces) öffnet, landet in einem vollständig konfigurierten Container: korrekte Java/Maven/Node/npm-Versionen, Docker-outside-of-Docker, Playwright-Chromium und alle VS Code-Erweiterungen vorinstalliert.

## Bounded Context

Besitzt alles unter `.devcontainer/`:
- `devcontainer.json` — Container-Spec (externe + lokale Features, Mounts, Ports, Umgebungsvariablen, VS Code-Erweiterungen)
- `Dockerfile` — Basis-Image-Anpassung (System-Pakete, Playwright OS-Abhängigkeiten)
- `features/` — lokale DevContainer-Features (selbstenthalten, per Eintrag in `devcontainer.json` aktivierbar)
- `scripts/postCreateCommand.sh` — Auto-Discovery-Orchestrator für Feature-postCreate-Skripte

Die Domäne hat **keine Laufzeit-Services** — sie ist reine Entwickler-Infrastruktur.

## Komponenten

| Datei / Skript | Zweck |
|---|---|
| `devcontainer.json` | Einstiegspunkt — Features, Mounts, Ports, `initializeCommand`, `runArgs`, VS Code-Anpassungen |
| `Dockerfile` | Erweitert `mcr.microsoft.com/devcontainers/java:dev-25-jdk-bookworm`; fügt System-Pakete und Playwright OS-Bibliotheken hinzu |
| `scripts/postCreateCommand.sh` | Auto-Discovery-Orchestrator — führt `features/*/postCreate.sh` in lexikalischer Reihenfolge aus |
| `features/opencode/` | Lokales Feature: kopiert `opencode.json` → `~/.config/opencode/config.json` (Build-Zeit) |
| `features/vertex-auth/` | Lokales Feature: stellt `.config/gcp/`-Verzeichnis bereit (Build-Zeit); validiert Vertex-Credentials (postCreate) |

## Lokale Features

Lokale Features liegen unter `features/<name>/` und bestehen aus:
- `devcontainer-feature.json` — Metadaten (ID, Version, Beschreibung)
- `install.sh` — läuft als root **während des Image-Builds** (keine gemounteten Secrets verfügbar)
- `postCreate.sh` *(optional)* — läuft als Teil von `postCreateCommand.sh` nach Container-Erstellung (Secrets verfügbar)

**Ein Feature aktivieren/deaktivieren:** Eintrag in `devcontainer.json` → `features` hinzufügen oder entfernen.
Das `features/`-Verzeichnis bleibt im Repo — das Feature wird nur durch den `devcontainer.json`-Eintrag aktiviert.

| Feature | install.sh | postCreate.sh |
|---|---|---|
| `opencode` | Kopiert `opencode.json` in `~/.config/opencode/config.json` | — |
| `vertex-auth` | Erstellt `~/.config/gcp/`-Verzeichnis | Validiert Vertex-Service-Account-JSON |

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
| Aktive Features | `devcontainer.json` → `features` | Nicht benötigte lokale Features (`./features/…`) entfernen |
| Projektname | `devcontainer.json` → `"name"` | `{{PROJECT_NAME}}` ersetzen |
| Ports | `devcontainer.json` → `forwardPorts` | Nicht benötigte Ports entfernen |
| VS Code-Erweiterungen | `devcontainer.json` → `extensions` | Nicht benötigte entfernen (Java, Angular, etc.) |
| Vertex-Variablen | `devcontainer.json` → `remoteEnv` | `GCP_PROJECT_ID` und `GCP_REGION` auf dem Host setzen |
| Vertex-Credentials | Hostpfad `~/.config/gcp/vertex-service-account.json` | Datei lokal anlegen; wird read-only in den Container gemountet |
| OpenCode-Modell | `features/opencode/opencode.json` → `"model"` | Standard-Modell anpassen |
| Maven-Mirror | `scripts/postCreate-Maven.sh` | Entfernen wenn kein lokaler Mirror |
| npm-Mirror | `scripts/postCreate-npm.sh` | Entfernen wenn kein lokaler npm-Mirror |
| Java-Tools | `Dockerfile` → Spring Boot CLI, Quarkus CLI | Entfernen wenn nicht benötigt |

## Verlauf

- 2026-06-03 — Erstfassung
- 2026-06-11 — AWS-Bedrock-Default entfernt; Vertex-Setup mit localEnv-Credential-Mount dokumentiert
- 2026-06-11 — postCreate-Skripte in lokale DevContainer-Features (`features/`) überführt; `postCreateCommand.sh` auf Auto-Discovery umgestellt
