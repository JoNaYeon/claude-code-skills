---
description: "Use this skill when starting a new project and needing to set up AI skill context, identify repeated tasks, and select best-fit skills. Triggers on: 'project kickoff', 'skill kickoff', 'start new project', 'setup project skills', '프로젝트 시작', '스킬 세팅'."
---


# Project Skill Kickoff: {{title}}

Reference:
- [[Project Archetype Skill Map]]
- [[01_Project Archetype Selector]]

## 1. Project Snapshot

> 이 섹션의 값은 [[00_Project Context]] 에서 가져온다.

- Project / workstream:
- Goal:
- Current phase:
- Codebase path or repo:
- Main deliverable:
- Owner / collaborators:

## 2. Tech / Domain Context
- Primary archetype:
- Secondary archetype:
- Stack:
- Infra / platform:
- External systems / APIs:
- Docs / design links:
- Risky areas:
- Non-goals:

## 3. Repeated Tasks We Want Help With
- Example: implementation
- Example: design-to-code
- Example: testing / QA
- Example: docs / release notes
- Example: deployment / infra
- Example: bug triage / refactor

## 3.5 Quality, Security And Git Bootstrap

새 프로젝트에 아래 정책 문서를 세팅했는지 확인한다:

- [ ] `CODE_QUALITY.md` (또는 `CODE_QUALITY_AND_SECURITY.md`) — [[04_Project Code Quality And Security]] 기반
- [ ] `GIT_WORKFLOW.md` — [[03_Project Git Workflow]] 기반
- [ ] `CLAUDE.md`에 Security Rules 블록 포함
- [ ] `CLAUDE.md`에 Pre-commit Quality Gate 순서 명시 (CODE_QUALITY → GIT_WORKFLOW)
- [ ] `.gitignore`에 시크릿 표준 패턴 포함 (`**/.env`, `settings.local.json` 등)

비코드 프로젝트인 경우:
- [ ] CODE_QUALITY의 "앱 코드" 섹션을 N/A로 표기하고, 스킬/문서 품질 섹션만 활성화

## 4. Already Approved Baseline Skills
- Add only the skills you want the model to treat as default candidates.
- Keep this list short.

## 5. Trusted Skill Sources
Check sources in this order:

1. Official / high-trust
- https://github.com/anthropics/skills
- https://skills.sh/
- https://skills.sh/vercel-labs/skills/find-skills

2. Curated discovery
- https://github.com/VoltAgent/awesome-agent-skills

3. Large community libraries
- https://github.com/sickn33/antigravity-awesome-skills
- https://github.com/alirezarezvani/claude-skills
- https://github.com/ComposioHQ/awesome-claude-skills

## 6. Skill Search Rules
- Inspect the codebase or working docs first before suggesting any skill.
- Prefer official or high-trust skills before community megarepos.
- Recommend only 3 to 7 skills max.
- Split the result into: install now / optional later / skip or risky.
- For each recommended skill, explain:
  - what problem it solves here
  - why it fits this project
  - source repo
  - trust signal
  - any review needed before use
- Do not dump a long list of weakly relevant skills.
- If no strong fit exists, propose a tiny custom local skill instead.

## 7. Output I Want From The Model
Return the result in this format:

1. Project needs detected
2. Best-fit skills
3. Why each skill matters here
4. Which source repo each came from
5. What to install now vs later
6. Any risky skills to avoid
7. Suggested custom local skills if gaps remain

## 8. Kickoff Prompt To Paste
```text
Read this project first, then use this note plus [[Project Archetype Skill Map]] as the skill-selection brief.

Instructions:
- Identify the best-fit project archetype before suggesting skills.
- Inspect the codebase and working docs before suggesting any skills.
- Detect the real repeated tasks and pain points in this project.
- Search trusted skill sources in the order listed in this note.
- Prefer official and high-trust skills first.
- Recommend only 3 to 7 skills.
- Split your answer into:
  1. install now
  2. optional later
  3. skip or risky
- For each recommended skill, explain:
  - what it solves here
  - why it fits this stack or workflow
  - source repo
  - trust signal
  - any review needed
- If no strong fit exists, propose a tiny custom local skill instead of forcing weak matches.

Keep the answer practical and short.
```

## 9. Skill Selection Log
| Skill | Source | Why | Status | Notes |
|---|---|---|---|---|
|  |  |  | candidate |  |

## 10. Refresh Rule
- Re-check skill recommendations if the stack changes, a new repeated workflow appears, or this note is older than 30 days.
- Update `updated:` in frontmatter when the shortlist changes.
