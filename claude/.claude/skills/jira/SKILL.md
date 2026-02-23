---
name: jira
description: Fetch a Jira issue and create a git branch named for auto-linking. Use when the user provides a Jira issue key (e.g., `/jira CB-21`).
---

Start work on a Jira issue. The full issue key (e.g., `CB-21`) is provided as `$ARGUMENTS`. Use the **exact value** of `$ARGUMENTS` as the issue key — do not split it or extract just the project prefix.

## 1. Fetch the issue

Run exactly this (replacing `<KEY>` with the full `$ARGUMENTS` value, e.g., `CB-21`):

```
jira issue view <KEY> --plain
```

Do NOT pass `-p` or `--project` flags — the issue key alone is sufficient.

## 2. Display context

Show the issue **title** and **description** so they are available in the conversation context for future work on this issue.

## 3. Choose a base branch

Ask the user which branch the new work should be based off of. Show the current branch and suggest common choices (e.g., `main`, `master`, `develop`, or the current branch). Once the user picks a base, make sure you're on that branch and it's up to date before creating the new one:

```
git checkout <base-branch> && git pull
```

## 4. Create a branch

Create and switch to a new branch named `<KEY>-<slugified-title>`:

- Take the issue title and slugify it: lowercase, replace spaces and special characters with hyphens, collapse consecutive hyphens, trim leading/trailing hyphens.
- Truncate the slug so the full branch name stays under 60 characters.
- Example: issue `CB-21` with title "Fix authentication flow" → branch `CB-21-fix-authentication-flow`.

```
git checkout -b <branch-name>
```

## 5. Confirm

Show the user the branch name and a brief summary of the issue so they can start working.
