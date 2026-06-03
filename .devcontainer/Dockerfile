FROM mcr.microsoft.com/devcontainers/java:dev-25-jdk-bookworm

ENV IGNORE_NOTICE=true

# System-Pakete + Playwright OS-Abhängigkeiten — single apt layer
RUN apt-get update && apt-get install -y --no-install-recommends \
    iputils-ping \
    dnsutils \
    file \
    python3-pip \
    httpie \
    telnet \
    xvfb \
    libglib2.0-0 \
    libgbm1 \
    libgtk-3-0 \
    libnss3 \
    libasound2 \
    libxtst6 \
    libatk-bridge2.0-0 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libpango-1.0-0 \
    libcairo2 \
    poppler-utils \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home/vscode

# AWS CLI — Installer-Artefakte nach Installation entfernen
# Entfernen wenn kein AWS benötigt wird
RUN ARCH=$(uname -m) \
    && curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-${ARCH}.zip" -o awscliv2.zip \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws/

# Node.js 22
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Playwright Chromium — ins Image gebacken, damit postCreate keinen Download braucht
ENV PLAYWRIGHT_BROWSERS_PATH=/ms-playwright
RUN npx --yes playwright@1.58.2 install chromium && chmod -R 777 /ms-playwright

# Python-Abhängigkeiten (pyyaml für Skript-Support)
RUN pip3 install --break-system-packages pyyaml

# Claude Code CLI
RUN npm install -g @anthropic-ai/claude-code

# Spring Boot CLI (entfernen wenn kein Spring Boot)
ARG SPRINGBOOT_CLI_VERSION=3.4.4
RUN curl -fsSL "https://repo.maven.apache.org/maven2/org/springframework/boot/spring-boot-cli/${SPRINGBOOT_CLI_VERSION}/spring-boot-cli-${SPRINGBOOT_CLI_VERSION}-bin.tar.gz" \
    | tar xz -C /opt \
    && ln -sf /opt/spring-${SPRINGBOOT_CLI_VERSION}/bin/spring /usr/local/bin/spring

# Quarkus CLI (entfernen wenn kein Quarkus)
ARG QUARKUS_CLI_VERSION=3.19.4
RUN curl -fsSL "https://github.com/quarkusio/quarkus/releases/download/${QUARKUS_CLI_VERSION}/quarkus-cli-${QUARKUS_CLI_VERSION}.tar.gz" \
    | tar xz -C /opt \
    && ln -sf /opt/quarkus-cli-${QUARKUS_CLI_VERSION}/bin/quarkus /usr/local/bin/quarkus
