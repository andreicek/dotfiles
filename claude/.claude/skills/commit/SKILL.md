---
name: commit
description: Create a git commit with a well-crafted message based on staged and unstaged changes. Use when the user asks to commit, or after completing a task where committing is a natural next step.
---

Create a git commit for the current changes. Follow these steps:

## 1. Understand the current state

Run these commands in parallel to understand what's going on:

- `git status` — see staged, unstaged, and untracked files
- `git diff --staged` — see what's already staged
- `git diff` — see unstaged changes
- `git log --oneline -10` — see recent commit style

## 2. Stage changes

- If there are already staged changes, respect that selection — the user intentionally staged specific files.
- If nothing is staged, stage all modified and new files that are relevant. Never stage files that look like secrets (`.env`, credentials, tokens).
- Prefer `git add <specific files>` over `git add -A`.

## 3. Write the commit message

Analyze the diff of what will be committed and write a commit message:

- **First line**: concise summary in imperative mood (e.g., "Add user authentication", "Fix off-by-one in pagination"). Under 72 characters.
- **Body** (if needed): explain **why** the change was made, not what changed (the diff shows that). Wrap at 72 characters.
- Match the style of recent commits in the repo.
- NEVER add a `Co-Authored-By` trailer. Never. Not under any circumstances.

## 4. Commit

Use a HEREDOC to pass the message to avoid quoting issues:

```
git commit -m "$(cat <<'EOF'
<message here>
EOF
)"
```

## 5. Wait for YubiKey

The user signs commits with a YubiKey. The `git commit` command may hang waiting for a physical touch. If the commit doesn't return within a few seconds, tell the user to touch their YubiKey. Do NOT cancel or interrupt the command — just wait for it.

## 6. Confirm

Run `git status` after committing and show the user a brief summary of what was committed.

## Handling arguments

If the user provides `$ARGUMENTS`, treat it as guidance for the commit message or scope (e.g., `/commit fix the login bug` means the message should reference fixing the login bug).
