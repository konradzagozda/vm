set dotenv-filename := "secrets/.env"

# GitHub Setup
gh-setup:
    bash infra/scripts/gh-setup.sh
    git remote set-url origin "https://github.com/$(git remote get-url origin | sed 's|.*github.com[:/]||')"

# VM Provisioning
vm-init:
    tofu -chdir=infra/tf init

vm-plan:
    tofu -chdir=infra/tf plan \
      -var="host_mount_path=$VM_HOST_MOUNT_PATH" \
      -var="host_secrets_path=$VM_HOST_SECRETS_PATH"

vm-up:
    tofu -chdir=infra/tf apply -auto-approve \
      -var="host_mount_path=$VM_HOST_MOUNT_PATH" \
      -var="host_secrets_path=$VM_HOST_SECRETS_PATH"

vm-down:
    tofu -chdir=infra/tf destroy -auto-approve \
      -var="host_mount_path=$VM_HOST_MOUNT_PATH" \
      -var="host_secrets_path=$VM_HOST_SECRETS_PATH"

vm-ssh:
    incus exec workstation -- sudo --login --user root

vm-status:
    incus list workstation --format=table

# E2E validation: destroy, create VM, verify (leaves VM running)
vm-test:
    bash infra/scripts/vm-test.sh

# Scan full git history for leaked secrets
scan-history:
    gitleaks detect --source . -v
