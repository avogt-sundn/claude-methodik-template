FROM mcr.microsoft.com/devcontainers/java:dev-25-jdk-bookworm

ENV IGNORE_NOTICE=true

# Diagnostic utilities
RUN apt-get update && apt-get install -y --no-install-recommends \
    iputils-ping \
    dnsutils \
    file \
    apache2-utils \
    python3-pip \
    httpie \
    telnet \
    poppler-utils \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home/vscode

# AWS CLI — clean up installer artifacts after install
RUN ARCH=$(uname -m) \
    && curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-${ARCH}.zip" -o awscliv2.zip \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws/

# Python deps
RUN pip3 install --break-system-packages pyyaml
