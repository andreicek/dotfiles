---
name: jira-move
description: Transition a Jira issue to a new state (e.g., `/jira-move In Progress`, `/jira-move CB-21 Done`). Infers the issue key from the current branch if not provided.
---

Transition a Jira issue to a new state. `$ARGUMENTS` can be:

- `<STATE>` only (e.g., `In Progress`) — infer the issue key from the current git branch name.
- `<KEY> <STATE>` (e.g., `CB-21 Done`) — use the given issue key.

## 1. Determine the issue key and target state

Parse `$ARGUMENTS`:

- If it starts with something that looks like a Jira issue key (letters, hyphen, digits, e.g., `CB-21`), treat the first token as the key and the rest as the state.
- Otherwise, the entire argument is the target state. Extract the issue key from the current branch name — Jira keys look like `PROJ-123` at the start of the branch (e.g., `CB-21-fix-auth-flow` → `CB-21`).

If the issue key cannot be determined, ask the user.

## 2. Move the issue

Run:

```bash
jira issue move <KEY> "<STATE>"
```

## 3. Confirm

Tell the user the issue was transitioned and to which state.
