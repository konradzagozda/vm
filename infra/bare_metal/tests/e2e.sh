#!/usr/bin/env bash
set -euox pipefail

# End-to-end test wrapper: create e2e-test-runner, run workstation setup test, destroy.
# Runs on bare_metal via `just e2e-test`.
#
# Example:
#   just e2e-test

echo "==> Creating e2e-test-runner VM..."
just e2e-init
just e2e-up

echo "==> Waiting for VM agent..."
for i in $(seq 1 30); do
  incus exec e2e-test-runner -- true 2>/dev/null && break
  sleep 2
done

echo "==> Waiting for cloud-init inside e2e-test-runner..."
incus exec e2e-test-runner -- cloud-init status --wait

echo "==> Running workstation setup test inside e2e-test-runner..."
incus exec e2e-test-runner -- bash -lc "cd /root/projects/vm_dev && just workstation-setup-test"

echo "==> Destroying e2e-test-runner VM..."
just e2e-down

echo "==> E2E test passed."
