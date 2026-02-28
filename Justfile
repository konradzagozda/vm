set dotenv-filename := ".env"

prepare-env:
    cp infra/secrets/.env.example .env
    cp infra/secrets/key.example.pem infra/secrets/key.pem
    @echo "Edit .env and infra/secrets/key.pem with your values"

gh-setup:
    bash infra/scripts/gh_setup.sh
    git remote set-url origin "https://github.com/$(git remote get-url origin | sed 's|.*github.com[:/]||')"

vm-init:
    tofu -chdir=infra/iac init

vm-plan:
    tofu -chdir=infra/iac plan \
      -var="host_mount_path=$VM_HOST_MOUNT_PATH" \
      -var="host_secrets_path=$VM_HOST_SECRETS_PATH"

vm-up:
    tofu -chdir=infra/iac apply -auto-approve \
      -var="host_mount_path=$VM_HOST_MOUNT_PATH" \
      -var="host_secrets_path=$VM_HOST_SECRETS_PATH"

vm-down:
    tofu -chdir=infra/iac destroy -auto-approve \
      -var="host_mount_path=$VM_HOST_MOUNT_PATH" \
      -var="host_secrets_path=$VM_HOST_SECRETS_PATH"

vm-ssh:
    incus exec workstation -- sudo --login --user root

vm-status:
    incus list workstation --format=table

vm-test:
    bash infra/tests/e2e_workstation.sh

scan-history:
    gitleaks detect --source . -v
