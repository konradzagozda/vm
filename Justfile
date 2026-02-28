set dotenv-filename := ".env"

prepare-env:
    cp infra/secrets/.env.example .env
    cp infra/secrets/key.example.pem infra/secrets/key.pem
    @echo "Edit .env and infra/secrets/key.pem with your values"

gh-setup:
    bash infra/scripts/gh_setup.sh
    git remote set-url origin "https://github.com/$(git remote get-url origin | sed 's|.*github.com[:/]||')"

vm-init:
    tofu -chdir=infra/iac/workstation init -lockfile=readonly

vm-plan:
    tofu -chdir=infra/iac/workstation plan \
      -var="host_mount_path=$VM_HOST_MOUNT_PATH" \
      -var="host_secrets_path=$VM_HOST_SECRETS_PATH"

vm-up:
    tofu -chdir=infra/iac/workstation apply -auto-approve \
      -var="host_mount_path=$VM_HOST_MOUNT_PATH" \
      -var="host_secrets_path=$VM_HOST_SECRETS_PATH"

vm-down:
    tofu -chdir=infra/iac/workstation destroy -auto-approve \
      -var="host_mount_path=$VM_HOST_MOUNT_PATH" \
      -var="host_secrets_path=$VM_HOST_SECRETS_PATH"

vm-ssh:
    incus exec workstation -- sudo --login --user root

vm-status:
    incus list workstation --format=table

vm-test:
    bash infra/tests/e2e_workstation.sh

e2e-init:
    tofu -chdir=infra/iac/e2e init -lockfile=readonly

e2e-up:
    tofu -chdir=infra/iac/e2e apply -auto-approve \
      -var="host_mount_path=$VM_HOST_MOUNT_PATH"

e2e-down:
    tofu -chdir=infra/iac/e2e destroy -auto-approve \
      -var="host_mount_path=$VM_HOST_MOUNT_PATH"

e2e-ssh:
    incus exec e2e_test_runner -- sudo --login --user root

e2e-test:
    incus exec e2e_test_runner -- bash -lc "cd /root/projects/vm_dev && just vm-test"

update-lock:
    tofu -chdir=infra/iac/workstation init -upgrade
    tofu -chdir=infra/iac/e2e init -upgrade

scan-history:
    gitleaks detect --source . -v
