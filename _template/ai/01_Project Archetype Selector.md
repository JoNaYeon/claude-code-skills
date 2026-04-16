---
type: project-archetype-selector
created: {{date}}
updated: {{date}}
tags: [ai, skills, archetype]
status: draft
---

# Project Archetype Selector: {{title}}

## 1. This Project Feels Most Like
- Primary archetype:
- Secondary archetype:
- Why these fit:

Reference:
- [[Project Archetype Skill Map]]

## 2. Project Snapshot

> 이 섹션의 값은 [[00_Project Context]] 에서 가져온다.

- Project:
- Goal:
- Repo / folder:
- Stage:
- Main deliverable:

## 3. Real Repeated Tasks
- What do I keep doing?
- What is slow or annoying?
- What do I want the model to do better?

## 4. Constraints
- Stack:
- Tools already in use:
- Risky actions to avoid:
- Credentials / external systems:
- Time budget:

## 5. What I Want Recommended
- Number of skill candidates:
- Prefer official / community / mixed:
- Okay to suggest local custom skill?:
- Exclude anything?:

## 6. Paste Prompt
```text
Use this note and [[Project Archetype Skill Map]] as the context for skill selection.

First identify the project's primary and secondary archetypes.
Then inspect the codebase or working docs and recommend only the smallest useful shortlist.

Requirements:
- Prefer official / high-trust skills first
- Keep the shortlist small
- Separate: install now / optional later / skip or risky
- Explain why each recommendation matches this project's repeated tasks
- If no strong fit exists, suggest a small local custom skill instead

Keep the answer practical and concise.
```

## 7. Skill Selection Log
| Skill | Why it matched | Decision | Notes |
|---|---|---|---|
|  |  | candidate |  |
