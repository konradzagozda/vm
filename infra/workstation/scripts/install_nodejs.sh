#!/usr/bin/env bash
set -euox pipefail

/*
 * Install Node.js via NodeSource.
 *
 * Example:
 *   ./install_nodejs.sh
 *
 * Environment:
 *   NODEJS_VERSION — required, from /etc/tool-versions.env (e.g. "lts")
 */

. /etc/tool-versions.env

curl -fsSL "https://deb.nodesource.com/setup_${NODEJS_VERSION}.x" | bash -
apt-get install -y nodejs
