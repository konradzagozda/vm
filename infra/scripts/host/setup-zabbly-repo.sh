#!/usr/bin/env bash
# KAN-21: Replace Zabbly repo with Incus install from source
set -eu
. /etc/tool-versions.env

curl -fsSL https://pkgs.zabbly.com/key.asc \
  | gpg --dearmor -o /usr/share/keyrings/zabbly.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/zabbly.gpg] https://pkgs.zabbly.com/incus/stable $(. /etc/os-release && echo "$VERSION_CODENAME") main" \
  > /etc/apt/sources.list.d/zabbly-incus.list

cat > /etc/apt/preferences.d/pin-incus << PINEOF
Package: incus incus-base incus-client
Pin: version ${INCUS_PIN}.*
Pin-Priority: 990
PINEOF

apt-get update
apt-get install -y incus incus-ui-canonical
