#!/usr/bin/env bash
set -euo pipefail

TOFU_VARS=(
  -var="host_mount_path=$VM_HOST_MOUNT_PATH"
  -var="host_secrets_path=$VM_HOST_SECRETS_PATH"
)

echo "==> Initializing..."
tofu -chdir=infra/tf init -input=false

echo "==> Destroying existing VM (if any)..."
tofu -chdir=infra/tf destroy -auto-approve "${TOFU_VARS[@]}"

echo "==> Creating VM..."
tofu -chdir=infra/tf apply -auto-approve "${TOFU_VARS[@]}"

echo "==> Waiting for cloud-init to complete..."
incus exec workstation -- cloud-init status --wait

echo "==> Verifying VM is running..."
incus list workstation --format=csv -c s | grep -q RUNNING

echo "==> Verifying mount..."
incus exec workstation -- mountpoint -q /root/projects

echo "==> Verifying secrets mount..."
incus exec workstation -- test -f /root/secrets/.env

echo "==> Verifying network..."
incus exec workstation -- ping -c 1 -W 5 archive.ubuntu.com

echo "==> Verifying Claude Code..."
incus exec workstation -- zsh -lc "claude --version"

echo "==> Verifying git identity vars..."
incus exec workstation -- zsh -lc "env | grep GIT"

echo "==> Verifying Jira vars..."
incus exec workstation -- zsh -lc "env | grep JIRA"

echo "==> Verifying gh auth login with App credentials..."
incus exec workstation -- zsh -lc "bash -" < infra/scripts/gh-setup.sh
incus exec workstation -- zsh -lc "gh auth status"

echo "==> VM info:"
incus exec workstation -- uname -a

echo "==> All checks passed. VM is running."
