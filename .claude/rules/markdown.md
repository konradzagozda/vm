---
paths:
  - "**/*.md"
---

Sort sections in order of importance to the audience. If multiple audiences would prefer different information, split the document into multiple files with a common generic part that references the specific ones.

Avoid h1 headings — the filename serves this purpose. Start documents with h2 (`##`).

Avoid generic top-level headings like "General" — provide the description directly at the top of the document or beneath the YAML frontmatter.

If a section is very short (one or two sentences), prefer not to introduce a heading for it.

KAN-27: Add a configurable markdown linter to enforce these rules.
