# VM Dev

## IMPORTANT
Project moved to my private space elsewhere. For collaboration reach to me via zagozdakonrad@gmail.com or https://www.linkedin.com/in/konradzagozda/

## Description

Isolated VM-based development environment for Claude Code. A bare_metal directory is mounted into a workstation VM so Claude can work inside the VM while files live on the host.

## Setup

1. **Install Incus** and add yourself to `incus-admin`:
   ```sh
   sudo usermod -aG incus-admin $USER
   incus admin init --minimal
   ```
   For automated bare_metal setup, see `infra/e2e_test_runner/cloud-init.yml.tftpl`.

2. **Install OpenTofu:** [opentofu.org/docs/intro/install](https://opentofu.org/docs/intro/install/)

3. **Configure secrets:**
   ```sh
   just prepare-env
   # Edit .env and infra/bare_metal/secrets/gh_app_key.pem with your values
   ```

4. **Load env vars** (already automatic for `just` targets):
   ```sh
   set -a; source .env; set +a
   ```

5. **Provision the workstation:**
   ```sh
   just vm-init  # once
   just vm-up
   just vm-ssh
   ```
