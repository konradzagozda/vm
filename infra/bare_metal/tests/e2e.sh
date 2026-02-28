#!/usr/bin/env bash
set -euox pipefail

# End-to-end test wrapper: create e2e_test_runner, run workstation setup test, destroy.
# Runs on bare_metal via `just e2e-test`.
#
# Example:
#   just e2e-test

echo "==> Creating e2e_test_runner VM..."
just e2e-init
just e2e-up

echo "==> Waiting for cloud-init inside e2e_test_runner..."
incus exec e2e_test_runner -- cloud-init status --wait

echo "==> Running workstation setup test inside e2e_test_runner..."
incus exec e2e_test_runner -- bash -lc "cd /root/projects/vm_dev && just workstation-setup-test"

echo "==> Destroying e2e_test_runner VM..."
just e2e-down

echo "==> E2E test passed."
