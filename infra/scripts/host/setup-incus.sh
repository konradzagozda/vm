#!/usr/bin/env bash
# Initialize Incus with preseed config from /etc/incus/init-config.yaml
set -eu

incus admin init --preseed < /etc/incus/init-config.yaml
