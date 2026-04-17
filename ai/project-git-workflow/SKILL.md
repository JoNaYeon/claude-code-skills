---
name: project-git-workflow
description: "Use this skill to define and document Git workflow rules for a project including branch policy, commit rules, and AI agent constraints. Triggers on: 'git workflow', 'branch policy', 'commit rules', 'git rules', '깃 워크플로우', '브랜치 정책'."
---

---
type: project-git-workflow
created: {{date}}
updated: {{date}}
tags: [ai, git, workflow, collaboration]
status: draft
---

# Project Git Workflow: {{title}}

> 목적: 이 프로젝트에서 브랜치, 커밋, push, 배포, handoff 규칙을 AI와 사람이 함께 재사용할 수 있게 고정한다.

## 1. Repository Snapshot
- Project / workstream:
- Repo path:
- Stable branch:
- Deployment branch:
- Runtime host or environment:
- Main owner:
- Typical collaborators:

## 2. Core Git Rules
- One branch = one task
- Keep the stable branch deployable
- Prefer linear history unless there is a clear reason not to
- Never commit secrets, tokens, or real `.env` files
- Prefer working on the main development machine rather than editing production/runtime hosts directly

### 2.1 AI Agent Secret Access Rules
- AI must NEVER read, open, or cat any `.env` file — use `.env.example` for reference
- AI must NEVER include API keys, tokens, or secrets in code, comments, or commit messages
- AI must NEVER hardcode credentials in configuration files or permission rules (e.g. `settings.local.json`)
- If a task requires an API key value, AI must ask the user — not read it from files
- When writing curl commands, AI must use environment variable references (`$VAR`) instead of literal token values
- Claude Code `settings.local.json` should have PreToolUse hooks to auto-block `.env` file access
- Pre-commit should include `gitleaks` for secret pattern detection

## 3. Branch Policy
- Default branch naming pattern:
- Allowed prefixes:
- When same branch may continue across devices or agents:
- When a new branch is required:
- When direct commits to the stable branch are allowed:
- When direct commits to the stable branch are not allowed:

## 4. Commit Message Policy
- Format: `<type>: <short summary>`
- Allowed types:
- Examples:
- Words to avoid:

## 5. Commit And Push Validation
Always check first:

```bash
git status --short --branch
git diff --name-only
```

Project-specific required checks:
- Code changes:
- Script / infra changes:
- Docs-only changes:
- Test commands:
- Pre-commit / lint commands:
- Smoke-check commands:

## 6. Multi-Device / Multi-Agent Rules
- Can the same branch move across laptop / desktop / server:
- Can different AI models continue the same branch:
- What to do before changing devices:
- What to do before handing work to another AI or person:
- What to do if the worktree is dirty:
- What must never be auto-reset or auto-discarded:

## 7. Conflict Avoidance Rules
- Define write scope before editing
- Avoid editing the same implementation file in parallel when possible
- Which coordination docs may be shared:
- Which files need special caution:
- What to do if another collaborator has unstaged or unclear changes:

## 8. Minimum Handoff Record
- Current branch:
- Current HEAD SHA:
- Goal:
- Non-goals:
- Files changed:
- Files to avoid touching:
- Commands already run:
- Current worktree state:
- Remaining risks:
- Suggested next steps:

## 9. Prompt To Paste
```text
Use this note as the Git workflow contract for the project.

Instructions:
- Treat one branch as one task.
- If the task changes, create a new branch.
- Before editing, inspect the current branch, HEAD, and worktree status.
- Do not discard someone else's unstaged changes automatically.
- If another device, person, or AI will continue the work, leave a minimal handoff record.
- Run the project-specific validation listed in this note before committing or pushing.
- Keep the stable branch deployable.
- If the repository has runtime exceptions, follow them but mirror those changes back into versioned files.

Be conservative about resets, rebases, and destructive cleanup.
```

## 10. Decision Log

> 프로젝트 수준의 중요 결정은 [[07_Decision Log]] 정본에도 등록한다.

| Decision | Why | Date | Notes |
|---|---|---|---|
|  |  |  |  |
