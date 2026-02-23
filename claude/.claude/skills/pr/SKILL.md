---
name: pr
description: Create a GitHub pull request using gh. Use when the user wants to open a PR for the current branch (e.g., `/pr` or `/pr draft`).
---

Create a GitHub pull request for the current branch. If `$ARGUMENTS` contains "draft", create it as a draft PR.

## 1. Understand the changes

Run these commands in parallel:

- `git log --oneline $(git merge-base HEAD main 2>/dev/null || git merge-base HEAD master 2>/dev/null)..HEAD` — commits on this branch
- `git diff $(git merge-base HEAD main 2>/dev/null || git merge-base HEAD master 2>/dev/null)..HEAD --stat` — files changed
- `git branch --show-current` — current branch name
- `git remote show origin` — to find the default branch and confirm the remote

## 2. Determine the base branch

Figure out the correct base branch for this PR:

- Check if `gh-merge-base` is configured for the current branch: `git config branch.$(git branch --show-current).gh-merge-base`
- If not configured, use the repository's default branch (from step 1's `git remote show origin` output).
- Do NOT ask the user — just use the right default.

## 3. Push the branch

Make sure the current branch is pushed to the remote:

```bash
git push -u origin $(git branch --show-current)
```

## 4. Check for a PR template

Look for a pull request template in the repo. Check these locations:

- `.github/pull_request_template.md`
- `.github/PULL_REQUEST_TEMPLATE.md`
- `docs/pull_request_template.md`
- `.github/PULL_REQUEST_TEMPLATE/` directory

If a template exists, read it and use it as the structure for the PR body — fill in the template sections rather than replacing them. If no template exists, write a freeform description.

## 5. Write the PR title and body

- **Title**: Short (under 70 characters), descriptive summary of the changes. Do not just repeat the branch name.
- **Body**: If using a template, fill in each section of the template thoughtfully. If no template, write a concise description covering what changed and why.

## 6. Create the PR

```bash
gh pr create --title "<title>" --base <base-branch> --body "$(cat <<'EOF'
<body here>
EOF
)" <flags>
```

Add `--draft` if `$ARGUMENTS` contains "draft".

## 7. Confirm

Show the user the PR URL returned by `gh pr create`.
