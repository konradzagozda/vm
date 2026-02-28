set dotenv-filename := "envs/.env"

gh-setup:
    bash infra/scripts/gh-setup.sh
    git remote set-url origin "https://github.com/$(git remote get-url origin | sed 's|.*github.com[:/]||')"

vm-init:
    tofu -chdir=infra/iac init

vm-plan:
    tofu -chdir=infra/iac plan \
      -var="host_mount_path=$VM_HOST_MOUNT_PATH" \
      -var="host_envs_path=$VM_HOST_ENVS_PATH"

vm-up:
    tofu -chdir=infra/iac apply -auto-approve \
      -var="host_mount_path=$VM_HOST_MOUNT_PATH" \
      -var="host_envs_path=$VM_HOST_ENVS_PATH"

vm-down:
    tofu -chdir=infra/iac destroy -auto-approve \
      -var="host_mount_path=$VM_HOST_MOUNT_PATH" \
      -var="host_envs_path=$VM_HOST_ENVS_PATH"

vm-ssh:
    incus exec workstation -- sudo --login --user root

vm-status:
    incus list workstation --format=table

vm-test:
    bash infra/tests/e2e-workstation.sh

scan-history:
    gitleaks detect --source . -v
