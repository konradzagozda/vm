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
    tofu -chdir=infra plan -var="host_mount_path=$VM_HOST_MOUNT_PATH"

vm-up:
    tofu -chdir=infra apply -auto-approve -var="host_mount_path=$VM_HOST_MOUNT_PATH"

vm-down:
    tofu -chdir=infra destroy -auto-approve -var="host_mount_path=$VM_HOST_MOUNT_PATH"

vm-ssh:
    lxc exec claude-dev -- sudo --login --user root

vm-status:
    lxc list claude-dev --format=table
