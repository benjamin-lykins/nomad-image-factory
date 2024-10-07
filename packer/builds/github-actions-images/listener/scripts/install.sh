#!/bin/bash -e
export DEBIAN_FRONTEND=noninteractive

RUNNER_ARCH=$(dpkg --print-architecture)
if [ "$RUNNER_ARCH" = "amd64" ]; then
  RUNNER_ARCH="x64"
fi
echo "RUNNER_ARCH: $RUNNER_ARCH"

# Nomad
NOMAD_PACK_ARCH=$(dpkg --print-architecture)
echo "NOMAD_PACK_ARCH: $NOMAD_PACK_ARCH"

RUNNER_OS=$(uname -s | tr '[:upper:]' '[:lower:]')
echo "RUNNER_OS: $RUNNER_OS"

NOMAD_PACK_VERSION=0.1.2

useradd -m runner

apt-get update -y && apt-get upgrade -y && \
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
&& rm -rf /var/lib/apt/lists/*

curl --silent --remote-name https://releases.hashicorp.com/nomad-pack/0.1.2/nomad-pack_${NOMAD_PACK_VERSION}_${RUNNER_OS}_${NOMAD_PACK_ARCH}.zip \
&& unzip nomad-pack_${NOMAD_PACK_VERSION}_${RUNNER_OS}_${NOMAD_PACK_ARCH}.zip \
&& chown root:root nomad-pack \
&& mv nomad-pack /usr/local/bin/ \
&& nomad-pack version \
&& rm -rf nomad-pack_${NOMAD_PACK_VERSION}_${RUNNER_OS}_${NOMAD_PACK_ARCH}.zip

cd /home/runner && mkdir actions-runner && cd actions-runner \
&& curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-${RUNNER_OS}-${RUNNER_ARCH}-${RUNNER_VERSION}.tar.gz \
&& tar xzf ./actions-runner-${RUNNER_OS}-${RUNNER_ARCH}-${RUNNER_VERSION}.tar.gz \
&& rm -rf actions-runner-${RUNNER_OS}-${RUNNER_ARCH}-${RUNNER_VERSION}.tar.gz

chown -R runner ~runner \
&& /home/runner/actions-runner/bin/installdependencies.sh \
&& rm -rf /var/lib/apt/lists/*

cd / \
&& chmod +x ./start.sh \
&& chown -R runner /nomad-packs \
&& chmod -R 700 /nomad-packs
