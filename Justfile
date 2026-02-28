set dotenv-filename := ".env"

prepare-env:
    cp infra/bare_metal/.env.example .env
    cp infra/bare_metal/secrets/gh_app_key.example.pem infra/bare_metal/secrets/gh_app_key.pem
    @echo "Edit .env and infra/bare_metal/secrets/gh_app_key.pem with your values"

gh-setup:
    bash infra/common/scripts/gh_setup.sh
    git remote set-url origin "https://github.com/$(git remote get-url origin | sed 's|.*github.com[:/]||')"

vm-init:
    tofu -chdir=infra/workstation/iac init -lockfile=readonly

vm-plan:
    tofu -chdir=infra/workstation/iac plan \
      -var="host_mount_path=$VM_HOST_MOUNT_PATH" \
      -var="host_secrets_path=$VM_HOST_SECRETS_PATH"

vm-up:
    tofu -chdir=infra/workstation/iac apply -auto-approve \
      -var="host_mount_path=$VM_HOST_MOUNT_PATH" \
      -var="host_secrets_path=$VM_HOST_SECRETS_PATH"

vm-down:
    tofu -chdir=infra/workstation/iac destroy -auto-approve \
      -var="host_mount_path=$VM_HOST_MOUNT_PATH" \
      -var="host_secrets_path=$VM_HOST_SECRETS_PATH"

vm-ssh:
    incus exec workstation -- sudo --login --user root

vm-status:
    incus list workstation --format=table

workstation-setup-test:
    bash infra/e2e_test_runner/tests/workstation_setup.sh

e2e-init:
    tofu -chdir=infra/e2e_test_runner/iac init -lockfile=readonly

e2e-up:
    tofu -chdir=infra/e2e_test_runner/iac apply -auto-approve \
      -var="host_mount_path=$VM_HOST_MOUNT_PATH"

e2e-down:
    tofu -chdir=infra/e2e_test_runner/iac destroy -auto-approve \
      -var="host_mount_path=$VM_HOST_MOUNT_PATH"

e2e-ssh:
    incus exec e2e-test-runner -- sudo --login --user root

e2e-test:
    bash infra/bare_metal/tests/e2e.sh

update-lock:
    tofu -chdir=infra/workstation/iac init -upgrade
    tofu -chdir=infra/e2e_test_runner/iac init -upgrade

scan-history:
    gitleaks detect --source . -v
