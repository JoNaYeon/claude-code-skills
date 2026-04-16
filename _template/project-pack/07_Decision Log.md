---
type: decision_log
project: {{project}}
status: active
decided_by: []
created: {{date}}
updated: {{date}}
source_context: []
related_docs: []
tags: []
---

# Decision Log

프로젝트의 모든 의사결정을 추적합니다. "왜 이렇게 했지?"에 대한 답이 이 문서에 있어야 합니다.

## 사용법

- 새 결정이 생기면 테이블에 행을 추가합니다.
- **Status**: `draft` → `ratified` → `superseded` 순으로 진행합니다.
- 결정이 번복되면 기존 행을 삭제하지 말고 `superseded`로 변경한 뒤 새 행을 추가합니다.
- Decision ID는 `D-001`, `D-002` 형식으로 순차 부여합니다.

## Decisions

| Decision ID | Date | Status | Decision | Why | Alternatives Considered | Decided By |
|---|---|---|---|---|---|---|
| D-001 | <!-- 2026-04-16 --> | draft | <!-- JWT 만료시간 1시간 --> | <!-- 보안팀 권고 + refresh token 완료 --> | <!-- 24h vs 1h --> | <!-- 홍길동 --> |
| D-002 | <!-- 2026-04-17 --> | ratified | <!-- ORM 대신 raw SQL (집계) --> | <!-- 복잡 집계에서 ORM 한계 --> | <!-- QueryBuilder vs raw --> | <!-- 개발팀 합의 --> |

## 결정 작성 가이드

좋은 결정 기록의 조건:
- **Decision**: "X를 Y로 한다" — 구체적이고 실행 가능한 형태
- **Why**: 왜 이 결정을 내렸는지 근거 — 데이터, 제약, 전문가 의견 등
- **Alternatives Considered**: 검토했지만 선택하지 않은 대안 — 나중에 번복할 때 맥락 파악용
- **Decided By**: 누가 결정했는지 — 책임 추적과 추후 질문 대상 파악용
