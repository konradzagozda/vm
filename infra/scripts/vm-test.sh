#!/usr/bin/env bash
set -euo pipefail

TOFU_VARS=(
  -var="host_mount_path=$VM_HOST_MOUNT_PATH"
  -var="host_secrets_path=$VM_HOST_SECRETS_PATH"
)

echo "==> Initializing..."
tofu -chdir=infra init -input=false

echo "==> Creating VM..."
tofu -chdir=infra apply -auto-approve "${TOFU_VARS[@]}"

echo "==> Waiting for cloud-init to complete..."
lxc exec workstation -- cloud-init status --wait

echo "==> Verifying VM is running..."
lxc list workstation --format=csv -c s | grep -q RUNNING

echo "==> Verifying mount..."
lxc exec workstation -- mountpoint -q /root/vm_projects

echo "==> Verifying secrets mount..."
lxc exec workstation -- test -f /root/secrets/.env

echo "==> Verifying network..."
lxc exec workstation -- ping -c 1 -W 5 archive.ubuntu.com

echo "==> Verifying Claude Code..."
lxc exec workstation -- zsh -lc "claude --version"

echo "==> Verifying env vars loaded..."
lxc exec workstation -- zsh -lc "echo \$GIT_AUTHOR_NAME"

echo "==> VM info:"
lxc exec workstation -- uname -a

echo "==> Destroying VM..."
tofu -chdir=infra destroy -auto-approve "${TOFU_VARS[@]}"

echo "==> All checks passed."
