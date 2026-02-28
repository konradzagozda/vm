#!/usr/bin/env bash
set -euox pipefail

# Create workstation VM inside e2e_test_runner, validate, destroy.
# Runs inside e2e_test_runner via `just workstation-setup-test`.
#
# Example:
#   just workstation-setup-test
#
# Environment:
#   VM_HOST_MOUNT_PATH   — optional, default /root/projects
#   VM_HOST_SECRETS_PATH — optional, default /root/projects/vm_dev/infra/bare_metal/secrets

# Nested virtiofs mounts cause stale file handles — copy to local disk
LOCAL_PROJECTS=/root/local_projects
rsync -a --delete /root/projects/ "$LOCAL_PROJECTS/"

VM_HOST_MOUNT_PATH="$LOCAL_PROJECTS"
VM_HOST_SECRETS_PATH="$LOCAL_PROJECTS/vm_dev/infra/bare_metal/secrets"

TOFU_VARS=(
  -var="host_mount_path=$VM_HOST_MOUNT_PATH"
  -var="host_secrets_path=$VM_HOST_SECRETS_PATH"
)

echo "==> Initializing..."
rm -rf infra/workstation/iac/.terraform/providers
tofu -chdir=infra/workstation/iac init -input=false

echo "==> Destroying existing VM (if any)..."
tofu -chdir=infra/workstation/iac destroy -auto-approve "${TOFU_VARS[@]}"

echo "==> Creating VM..."
tofu -chdir=infra/workstation/iac apply -auto-approve "${TOFU_VARS[@]}"

echo "==> Waiting for VM agent..."
for i in $(seq 1 30); do
  incus exec workstation -- true 2>/dev/null && break
  sleep 2
done

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
incus exec workstation -- zsh -lc "test -n \"\$GIT_AUTHOR_NAME\""
incus exec workstation -- zsh -lc "test -n \"\$GIT_AUTHOR_EMAIL\""
incus exec workstation -- zsh -lc "test -n \"\$GIT_COMMITTER_NAME\""
incus exec workstation -- zsh -lc "test -n \"\$GIT_COMMITTER_EMAIL\""

echo "==> Verifying Jira vars..."
incus exec workstation -- zsh -lc "test -n \"\$JIRA_URL\""

echo "==> Verifying GH app key file..."
incus exec workstation -- zsh -lc "test -f \"\$GH_APP_PRIVATE_KEY_PATH\""

echo "==> VM info:"
incus exec workstation -- uname -a

echo "==> Destroying workstation..."
tofu -chdir=infra/workstation/iac destroy -auto-approve "${TOFU_VARS[@]}"

echo "==> All checks passed."
