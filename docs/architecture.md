# Architecture

Isolated VM-based development environment designed for Claude Code usage. A configurable host directory is mounted into the VM so Claude can work inside the VM while files live on the host machine.

```mermaid
graph TB
  User["🧑‍💻 User (Developer)"]
  Agent["🤖 Agent (Claude Code)"]
  Host["🖥️ Host Machine"]
  Repo["📦 vm_dev Repo"]
  VM["☁️ Virtual Machine"]

  User -->|configures| Repo
  User -->|operates| Host
  Repo -->|provisions| VM
  Host -->|runs| VM
  Agent -->|works inside| VM
  VM -->|mounts host directory| Host
```
