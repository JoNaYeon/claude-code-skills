---
description: "Use this skill to draft a new custom local skill tailored to a specific project workflow. Triggers on: 'create custom skill', 'write local skill', 'draft new skill', 'custom skill', '커스텀 스킬 만들기', '로컬 스킬 작성'."
---


# Custom Local Skill Draft: {{title}}

## 1. Why This Skill Should Exist
- Project / workflow:
- Repeated task:
- Current pain:
- Why external skills are not enough:

## 2. Trigger
- Use this skill when:
- Do not use this skill when:
- Typical user request examples:

## 3. Inputs The Skill Needs
- Codebase / folder context:
- Docs / design / ticket links:
- Required files:
- Required tools:
- Required secrets or environment:

## 4. Expected Output
- What a good result looks like:
- Output format:
- What decisions should be surfaced:
- What should be left to the user:

## 5. Guardrails
- Trust boundaries:
- Risky actions to avoid:
- What must be verified first:
- What should require confirmation:

## 6. Preferred Workflow
1. Gather context
2. Inspect code or documents
3. Propose the narrowest viable approach
4. Execute
5. Verify
6. Summarize next steps

## 7. SKILL.md Skeleton
```md
---
name: {{title}}
description: [What this skill does and when to use it]
---

# {{title}}

## When to Use
- [Trigger 1]
- [Trigger 2]

## Inputs
- [Input 1]
- [Input 2]

## Workflow
1. [Step 1]
2. [Step 2]
3. [Step 3]

## Output
- [Expected output]

## Safety Notes
- [Guardrail 1]
- [Guardrail 2]
```

## 8. Validation Cases
- Happy path:
- Edge case:
- Failure mode:
- What would make this skill clearly useful:

## 9. Decision
- Build now / backlog / not worth it
- If build now, first version scope:
