# 01 · 우선순위 · 상속 — 규칙이 충돌할 때

> ⚠️ **최고 규칙(_init) — 일반 task 중 변경 금지.** 개정은 명시적 승인으로만.

## P1. 우선순위 (상충 해결 순위)

규칙이 충돌하면 위에서 아래 순으로 우선한다.

1. **`_init`** (최고 규칙, 이 폴더)
2. **영역 표준** (SEEMEDI 전사베이스 `STD-*` 원본, `code-conventions`/`_template/_conventions`/`working-agreements`의 README)
3. **세부 규칙 문서** (각 by-task / by-language 문서)
4. **스킬(SKILL.md)** — 위 규칙을 소비·적용

- 하위가 상위와 충돌하면 상위가 이긴다. 하위를 고쳐 정합을 맞춘다.

## P2. SSOT (Single Source of Truth)

- 하나의 규칙은 **한 곳에서만** 정의한다. 다른 문서는 그 정의를 **참조**하고 복제하지 않는다.
- 원칙(WHAT/WHY)의 SSOT = `_init`. 세부(HOW)의 SSOT = 해당 세부 문서.
- 근거 원본의 SSOT = SEEMEDI 전사베이스 `C:\Users\user\OneDrive\vault\02_work\SEEMEDI\전사베이스`의 `STD-*` 문서.

## P3. 복제 금지 · 참조 상속

- 규칙 원문을 여러 문서에 복사하지 않는다(MUST NOT). 상위·원본을 **링크/`_REF` 참조**로 상속한다.
- 요약·발췌는 허용하되, 상충 시 원본(SSOT)이 우선함을 명시한다.

## P4. General ↔ SEEMEDI 충돌 해결

- General 규칙과 SEEMEDI 특이 규칙이 겹치면, **SEEMEDI 레포 안에서는 SEEMEDI 특이 규칙이 General에 우선**한다(더 엄격한 쪽).
- SEEMEDI 특이 규칙은 General을 **완화하지 못한다** — 강화만 가능(예: PHI 로깅 금지는 General 로깅 규칙을 더 엄격히 함).
- 분류 기준은 [02_classification.md](./02_classification.md).
