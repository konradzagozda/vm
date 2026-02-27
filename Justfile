# GitHub Setup
gh-setup:
    gh token generate \
      --app-id "$GH_APP_ID" \
      --installation-id "$GH_APP_INSTALLATION_ID" \
      --key "$GH_APP_PRIVATE_KEY_PATH" \
      | jq -r '.token' \
      | gh auth login --with-token
    git remote set-url origin "https://github.com/$(git remote get-url origin | sed 's|.*github.com[:/]||')"

# VM Provisioning
vm-init:
    tofu -chdir=infra init

vm-plan:
    tofu -chdir=infra plan \
      -var="host_mount_path=$VM_HOST_MOUNT_PATH" \
      -var="gh_app_private_key_path=$GH_APP_PRIVATE_KEY_PATH"

vm-up:
    tofu -chdir=infra apply -auto-approve \
      -var="host_mount_path=$VM_HOST_MOUNT_PATH" \
      -var="gh_app_private_key_path=$GH_APP_PRIVATE_KEY_PATH"

vm-down:
    tofu -chdir=infra destroy -auto-approve \
      -var="host_mount_path=$VM_HOST_MOUNT_PATH" \
      -var="gh_app_private_key_path=$GH_APP_PRIVATE_KEY_PATH"

vm-ssh:
    lxc exec workstation -- sudo --login --user root

vm-status:
    lxc list workstation --format=table

# E2E validation: init, create VM, verify, destroy
vm-test:
    #!/usr/bin/env bash
    set -euo pipefail
    echo "==> Initializing..."
    tofu -chdir=infra init -input=false
    echo "==> Creating VM..."
    tofu -chdir=infra apply -auto-approve \
      -var="host_mount_path=$VM_HOST_MOUNT_PATH" \
      -var="gh_app_private_key_path=$GH_APP_PRIVATE_KEY_PATH"
    echo "==> Waiting for cloud-init to complete..."
    lxc exec workstation -- cloud-init status --wait
    echo "==> Verifying VM is running..."
    lxc list workstation --format=csv -c s | grep -q RUNNING
    echo "==> Verifying mount..."
    lxc exec workstation -- mountpoint -q /root/vm_projects
    echo "==> Verifying network..."
    lxc exec workstation -- ping -c 1 -W 5 archive.ubuntu.com
    echo "==> Verifying Claude Code..."
    lxc exec workstation -- zsh -lc "claude --version"
    echo "==> Verifying env vars loaded..."
    lxc exec workstation -- zsh -lc "echo \$GIT_AUTHOR_NAME"
    echo "==> VM info:"
    lxc exec workstation -- uname -a
    echo "==> Destroying VM..."
    tofu -chdir=infra destroy -auto-approve \
      -var="host_mount_path=$VM_HOST_MOUNT_PATH" \
      -var="gh_app_private_key_path=$GH_APP_PRIVATE_KEY_PATH"
    echo "==> All checks passed."
