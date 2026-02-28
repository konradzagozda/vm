# VM Dev

Isolated VM-based development environment for Claude Code. A bare-metal directory is mounted into a workstation VM so Claude can work inside the VM while files live on the host.

## Setup

1. **Install Incus** and add yourself to `incus-admin`:
   ```sh
   sudo usermod -aG incus-admin $USER
   incus admin init --minimal
   ```
   For automated bare-metal setup, see `infra/e2e_test_runner.cloud_init.yml`.

2. **Install OpenTofu:** [opentofu.org/docs/intro/install](https://opentofu.org/docs/intro/install/)

3. **Configure secrets:**
   ```sh
   just prepare-env
   # Edit .env and infra/secrets/key.pem with your values
   ```

4. **Provision the workstation:**
   ```sh
   just vm-init  # once
   just vm-up
   just vm-ssh
   ```
