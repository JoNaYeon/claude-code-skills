---
name: project-orchestrator-session-start
description: "Use this skill to start an orchestrator session for a project with full context loading. Triggers on: 'orchestrator session', 'session start', 'load project context', 'start session', '오케스트레이터 시작', '세션 시작'."
---

---
type: project-orchestrator-session-start
created: {{date}}
updated: {{date}}
tags: [ai, orchestration, batch, session-start]
status: draft
---

# Project Orchestrator Session Start: {{title}}

> Purpose: give Codex or Claude the exact minimum context needed to resume the current execution batch from any device.

## 1. Session Role

- Role: `orchestrator` or `worker`
- Current device:
- Current user:
- Repo path:
- Current batch note: (→ [[09_Batch Run]] 템플릿으로 생성)
- Current task note: (→ [[08_Task Item]] 템플릿으로 생성)
- Integration branch:
- Worker branch:

## 2. Read First

Always read these first:

1. `CONTEXT.md`
2. `PROGRESS.md`
3. `docs/PROJECT_DOCS_MAP.md`
4. `docs/project/local-ai-server_pm_adoption.md`
5. `docs/project/local-ai-server_orchestrator_protocol.md`
6. current batch note
7. current task note if this session is a worker

## 3. Execution Scope

- Current phase:
- Current batch goal:
- Allowed write scope:
- Non-goals for this session:
- Required verification:

## 4. Paste Prompt: Orchestrator

```text
Read these first:
1. {{repo_path}}/CONTEXT.md
2. {{repo_path}}/PROGRESS.md
3. {{repo_path}}/docs/PROJECT_DOCS_MAP.md
4. {{repo_path}}/docs/project/local-ai-server_pm_adoption.md
5. {{repo_path}}/docs/project/local-ai-server_orchestrator_protocol.md
6. <current batch note path>

Role: orchestrator
Integration branch: <branch name>
Current device: <macbook or macmini>
Scope: continue this approved batch, assign or review workers, integrate results, and update canonical docs only if phase or execution rules changed.
```

## 5. Paste Prompt: Worker

```text
Read these first:
1. {{repo_path}}/CONTEXT.md
2. {{repo_path}}/PROGRESS.md
3. {{repo_path}}/docs/PROJECT_DOCS_MAP.md
4. {{repo_path}}/docs/project/local-ai-server_pm_adoption.md
5. {{repo_path}}/docs/project/local-ai-server_orchestrator_protocol.md
6. <current batch note path>
7. <current task note path>

Role: worker
Integration branch: <branch name>
Worker branch: <branch name>
Write scope: <paths you may edit>
Scope: complete only this task, stay inside the write scope, run the listed verification, and leave integration to the orchestrator.
```

## 6. Handoff Notes

- Current Git status:
- Current HEAD SHA:
- What changed since the last session:
- What the next session should do first:
