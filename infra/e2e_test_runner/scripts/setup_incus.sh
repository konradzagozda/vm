#!/usr/bin/env bash
set -euox pipefail

# Add Zabbly apt repo, install and initialize Incus.
# Works on both bare_metal and e2e_test_runner.
# KAN-21: Replace Zabbly repo with install from source.
#
# Example:
#   ./setup_incus.sh
#
# Environment:
#   INCUS_VERSION — required, from /etc/tool-versions.env or caller

if [ -f /etc/tool-versions.env ]; then
  . /etc/tool-versions.env
fi

: "${INCUS_VERSION:?INCUS_VERSION is required}"

curl -fsSL https://pkgs.zabbly.com/key.asc \
  | gpg --dearmor -o /usr/share/keyrings/zabbly.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/zabbly.gpg] https://pkgs.zabbly.com/incus/stable $(. /etc/os-release && echo "$VERSION_CODENAME") main" \
  > /etc/apt/sources.list.d/zabbly-incus.list

cat > /etc/apt/preferences.d/pin-incus << PINEOF
Package: incus incus-base incus-client
Pin: version ${INCUS_VERSION}.*
Pin-Priority: 990
PINEOF

apt-get update
apt-get install -y incus incus-ui-canonical

if [ -f /etc/incus/init-config.yaml ]; then
  incus admin init --preseed < /etc/incus/init-config.yaml
else
  incus admin init --minimal
fi
