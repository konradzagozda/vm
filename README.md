# VM

## Prerequisites

1. **Incus installed and initialized:**
   ```sh
   # Add your user to the incus-admin group (log out and back in after)
   sudo usermod -aG incus-admin $USER

   # Initialize Incus with defaults
   incus admin init --minimal
   ```

   For automated host setup, see `infra/host-cloud-init.yml`.

2. **OpenTofu installed:** [Install instructions](https://opentofu.org/docs/intro/install/)

3. **Set `VM_HOST_MOUNT_PATH`** in `.env` to the host directory you want mounted in the VM.

## VM Usage

```sh
# Initialize OpenTofu (downloads providers — run once)
just vm-init

# Preview what will be created
just vm-plan

# Create the VM
just vm-up

# Shell into the VM as the claude user
just vm-ssh

# Check VM status
just vm-status

# Destroy the VM
just vm-down
```

## Load Environment Variables:

```sh
set -a
source secrets/.env
set +a
```

## Start Claude:

`claude`
