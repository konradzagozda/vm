#!/usr/bin/env bash
set -euo pipefail
set -x

TOFU_VARS=(
  -var="host_mount_path=$VM_HOST_MOUNT_PATH"
  -var="host_envs_path=$VM_HOST_ENVS_PATH"
)

echo "==> Initializing..."
tofu -chdir=infra/iac init -input=false

echo "==> Destroying existing VM (if any)..."
tofu -chdir=infra/iac destroy -auto-approve "${TOFU_VARS[@]}"

echo "==> Creating VM..."
tofu -chdir=infra/iac apply -auto-approve "${TOFU_VARS[@]}"

echo "==> Waiting for cloud-init to complete..."
incus exec workstation -- cloud-init status --wait

echo "==> Verifying VM is running..."
incus list workstation --format=csv -c s | grep -q RUNNING

echo "==> Verifying mount..."
incus exec workstation -- mountpoint -q /root/projects

echo "==> Verifying envs mount..."
incus exec workstation -- test -f /root/envs/.env

echo "==> Verifying network..."
incus exec workstation -- ping -c 1 -W 5 archive.ubuntu.com

echo "==> Verifying Claude Code..."
incus exec workstation -- zsh -lc "claude --version"

echo "==> Verifying git identity vars..."
incus exec workstation -- zsh -lc "env | grep GIT"

echo "==> Verifying Jira vars..."
incus exec workstation -- zsh -lc "env | grep JIRA"

echo "==> Verifying gh auth..."
incus exec workstation -- zsh -lc "bash -" < infra/scripts/gh-setup.sh
incus exec workstation -- zsh -lc "gh auth status"

echo "==> VM info:"
incus exec workstation -- uname -a

echo "==> All checks passed."
