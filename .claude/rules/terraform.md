# Terraform / OpenTofu

## Comments

Use single-line comments (`#`) for brief annotations above resource blocks. For longer explanations, use block comments:

```hcl
/*
 * Multi-line explanation goes here.
 * Describe the why, not the what.
 */
```

Avoid trailing comments on resource properties unless they add significant clarity.

## File organization

Place all `.tf` files in a dedicated subdirectory (e.g. `infra/tf/`), separate from cloud-init configs and scripts.

## Variables

Pin version constraints explicitly in `versions.tf`. Use descriptive variable names and always provide a `description` field.
