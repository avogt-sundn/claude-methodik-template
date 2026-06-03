#!/usr/bin/env bash

# Setzt einen lokalen Maven-Mirror (Reposilite unter maven-mirror:8080).
# Voraussetzung: maven-mirror:8080 läuft im selben Docker-Netzwerk.
# Entfernen oder anpassen wenn kein lokaler Mirror vorhanden ist.

mkdir -p "$HOME/.m2"
sudo chown -R vscode:vscode /home/vscode/.m2

cat > "$HOME/.m2/settings.xml" <<EOF
<settings>
    <mirrors>
        <mirror>
            <id>dockerized-mirror</id>
            <name>Local Mirror Repository</name>
            <url>http://maven-mirror:8080/central</url>
            <mirrorOf>central</mirrorOf>
        </mirror>
    </mirrors>
</settings>
EOF

echo "Maven mirror is set up"
