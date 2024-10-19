#!/bin/bash -e

# This script sets up the environment for installing GitHub Actions runner.
#
# Environment Variables:
#   DEBIAN_FRONTEND - Set to 'noninteractive' to avoid interactive prompts during package installation.
#   RUNNER_ARCH - Determines the architecture of the system using dpkg.
#   RUNNER_VERSION - Specifies the version of the GitHub Actions runner to install. Defaults to 2.319.1 if not set.
export DEBIAN_FRONTEND=noninteractive
RUNNER_ARCH=$(dpkg --print-architecture)
RUNNER_VERSION=${RUNNER_VERSION:-2.319.1}

# This script checks if the environment variable RUNNER_ARCH is set to "amd64".
# If it is, the script changes the value of RUNNER_ARCH to "x64".
# Finally, it prints the value of RUNNER_ARCH to the console.
if [ "$RUNNER_ARCH" = "amd64" ]; then
  RUNNER_ARCH="x64"
fi
echo "RUNNER_ARCH: $RUNNER_ARCH"

# This script determines the operating system of the runner by using the `uname -s` command,
# converts the output to lowercase, and stores it in the RUNNER_OS variable.
# It then prints the determined operating system.
RUNNER_OS=$(uname -s | tr '[:upper:]' '[:lower:]')
echo "RUNNER_OS: $RUNNER_OS"

# This script creates a new user named 'runner' with a home directory.
useradd -m runner

# This script updates the package lists, upgrades installed packages,
# and installs a set of essential development tools and libraries.
# The installed packages include:
# - curl: Command line tool for transferring data with URLs
# - jq: Command line JSON processor
# - build-essential: Informational list of build-essential packages
# - libssl-dev: Development files for the OpenSSL library
# - libffi-dev: Foreign Function Interface library development files
# - python3: Python 3 interpreter
# - python3-venv: Python 3 virtual environment support
# - python3-dev: Header files and a static library for Python 3
# - python3-pip: Python package installer
# - unzip: Decompression utility
# - libicu-dev: Development files for International Components for Unicode
# - nodejs: JavaScript runtime built on Chrome's V8 JavaScript engine
# - xorriso: ISO 9660 Rock Ridge Filesystem Manipulator
# - git: Distributed version control system
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

# This installs Ansible.
apt-get update -y
apt-get install software-properties-common -y
add-apt-repository --yes --update ppa:ansible/ansible
apt-get install ansible -y

# This script installs the GitHub Actions runner.
# It performs the following steps:
# 1. Changes the directory to /home/runner.
# 2. Creates a new directory named actions-runner.
# 3. Changes the directory to actions-runner.
# 4. Downloads the specified version of the GitHub Actions runner tarball from GitHub.
# 5. Extracts the contents of the downloaded tarball.
# 6. Removes the downloaded tarball to clean up.
#
# Environment variables required:
# - RUNNER_VERSION: The version of the GitHub Actions runner to install.
# - RUNNER_OS: The operating system of the runner (e.g., linux, osx).
# - RUNNER_ARCH: The architecture of the runner (e.g., x64, arm64).
cd /home/runner && mkdir actions-runner && cd actions-runner &&
  curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-${RUNNER_OS}-${RUNNER_ARCH}-${RUNNER_VERSION}.tar.gz &&
  tar xzf ./actions-runner-${RUNNER_OS}-${RUNNER_ARCH}-${RUNNER_VERSION}.tar.gz &&
  rm -rf actions-runner-${RUNNER_OS}-${RUNNER_ARCH}-${RUNNER_VERSION}.tar.gz

# This script changes the ownership of the home directory of the 'runner' user,
# installs dependencies required for GitHub Actions runner using the provided script,
# and then cleans up the APT cache to free up space.
chown -R runner ~runner &&
  /home/runner/actions-runner/bin/installdependencies.sh &&
  rm -rf /var/lib/apt/lists/*

# This script changes the current directory to the root directory
# and then grants execute permissions to the start.sh script located in the root directory.
cd / &&
  chmod +x ./start.sh
