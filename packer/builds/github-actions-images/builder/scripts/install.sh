#!/bin/bash -e
export DEBIAN_FRONTEND=noninteractive
RUNNER_ARCH=$(dpkg --print-architecture)
RUNNER_VERSION=${RUNNER_VERSION:-2.319.1}

if [ "$RUNNER_ARCH" = "amd64" ]; then
  RUNNER_ARCH="x64"
fi
echo "RUNNER_ARCH: $RUNNER_ARCH"

RUNNER_OS=$(uname -s | tr '[:upper:]' '[:lower:]')
echo "RUNNER_OS: $RUNNER_OS"

useradd -m runner

apt-get update -y && apt-get upgrade -y &&
  apt-get install -y --no-install-recommends \
    curl \
    jq \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3 \
    python3-venv \
    python3-dev \
    python3-pip \
    unzip \
    libicu-dev \
    nodejs \
    xorriso \
    git

apt-get update -y
apt-get install software-properties-common -y
add-apt-repository --yes --update ppa:ansible/ansible
apt-get install ansible -y

cd /home/runner && mkdir actions-runner && cd actions-runner &&
  curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-${RUNNER_OS}-${RUNNER_ARCH}-${RUNNER_VERSION}.tar.gz &&
  tar xzf ./actions-runner-${RUNNER_OS}-${RUNNER_ARCH}-${RUNNER_VERSION}.tar.gz &&
  rm -rf actions-runner-${RUNNER_OS}-${RUNNER_ARCH}-${RUNNER_VERSION}.tar.gz

chown -R runner ~runner &&
  /home/runner/actions-runner/bin/installdependencies.sh &&
  rm -rf /var/lib/apt/lists/*

cd / &&
  chmod +x ./start.sh
