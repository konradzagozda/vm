# VM

## Prerequisites

1. **LXD installed and initialized:**
   ```sh
   # Add your user to the lxd group (log out and back in after)
   sudo usermod -aG lxd $USER

   # Initialize LXD with defaults
   lxd init --minimal
   ```

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
source .env
set +a
```

## Start Claude:

`claude`
