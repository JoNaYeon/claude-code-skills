---
type: batch_run
project: {{project}}
status: proposed
batch_id: {{batch_id}}
phase:
goal:
approval_scope:
integration_branch:
worker_branches: []
current_owner:
created: {{date}}
updated: {{date}}
source_context: []
related_docs: []
tags: [batch, orchestration]
---

# Batch Summary

> 이 배치를 실행하는 세션 시작 시 [[05_Project Orchestrator Session Start]] 를 사용한다.

## Goal

- what this batch is trying to complete
- which phase / next priority it maps to

## Task Board

| Task ID | Summary | Owner | Write Set | Depends On | Status | Done When |
|---|---|---|---|---|---|---|
| `{{task_uid_1}}` | | | | | proposed | |
| `{{task_uid_2}}` | | | | | proposed | |

## Global Checks

- checks to run before integration
- checks to run before `master` promotion
- runtime verification needed on mac mini, if any

## Promotion Candidates

- `PROGRESS.md`
- `CONTEXT.md`
- `docs/*`
- keep in Project Pack only

## Execution Log

- {{date}} batch created
