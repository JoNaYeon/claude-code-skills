# `_init` — 최고 규칙 계층 (Constitution)

> ⚠️ **이 폴더는 전체 문서가 참조하는 가장 높은 규칙이다. 일반 task 중에는 변경하지 않는다.**
> 개정은 사용자의 명시적 승인으로만 한다(→ [00_governance.md](./00_governance.md)).

## 성격

`_init`은 이 레포의 모든 규칙 문서(code-conventions · _template/_conventions · working-agreements)와 스킬 위에 서는 **헌법**이다. 하위 문서가 `_init`과 충돌하면 `_init`이 우선한다. 하위 문서는 `_init`의 원칙을 **구현·상속**할 뿐, 원칙 자체를 재정의하지 않는다.

## 카테고리 (읽는 순서)

| # | 문서 | 카테고리 | 내용 |
|---|------|----------|------|
| 00 | [governance](./00_governance.md) | 거버넌스 | `_init`의 권위·불변 원칙·개정 절차 |
| 01 | [precedence](./01_precedence.md) | 우선순위·상속 | SSOT, 복제 금지, 상충 해결 순위 |
| 02 | [classification](./02_classification.md) | 분류 원칙 | General vs SEEMEDI 특이 최상위 분류축 |
| 03 | [authoring](./03_authoring.md) | 문서 작성 | 버전 `_vN`·frontmatter·명명 최상위 규칙 |
| 04 | [workflow](./04_workflow.md) | 작업 방식 | 제안 후 실행(승인 게이트) |

## 하위 문서와의 관계

- **원칙(WHAT/WHY)의 SSOT = `_init`.** 세부(HOW)의 SSOT = 하위 규칙 문서.
- 하위 규칙 문서는 상단에 `> Governed by [_init](../_init/README.md)` 배너로 이 계층을 참조한다.
- 예: General/SEEMEDI 분리의 **기준**은 `_init/02_classification.md`, 그 **구현**은 `code-conventions/{general,seemedi}/`.
