---
type: working_agreement
project: {{project}}
status: active
created: {{date}}
updated: {{date}}
source_context: []
related_docs: []
tags: []
---

# Working Agreement

AI와 사람이 함께 작업할 때의 규칙을 정의합니다. 이 문서가 없으면 AI가 매 세션마다 다르게 동작합니다.

## Read Order

AI가 새 세션을 시작할 때 반드시 읽어야 하는 문서의 순서입니다. 번호가 낮을수록 우선순위가 높습니다.

1. <!-- 예: CLAUDE.md (프로젝트 루트) — 전역 규칙 -->
2. <!-- 예: 00_Project Context.md — 프로젝트 맥락 -->
3. <!-- 예: 01_Working Agreement.md (이 문서) — 작업 규칙 -->
4. <!-- 예: PROGRESS.md — 현재 진행 상황 -->
5. <!-- 예: 현재 작업 중인 Feature Brief 또는 Task Item -->

## Response Contract

AI가 응답할 때 반드시 포함해야 하는 구조입니다.

- **Interpretation**: 사용자 요청을 AI가 어떻게 이해했는지 먼저 확인합니다. 잘못 이해했으면 바로 교정할 수 있습니다.
  <!-- 예: "이해한 내용: 로그인 API에 소셜 로그인(Google OAuth)을 추가하려는 것으로 파악했습니다." -->

- **Draft Artifact**: 산출물 초안을 작성합니다. 코드, 문서, 설계 등 요청에 맞는 형태로.
  <!-- 예: 코드 → 파일 생성/수정, 기획 → Feature Brief 초안, 리뷰 → 피드백 목록 -->

- **Promotion Candidates**: 이 작업 결과로 업데이트해야 할 다른 문서를 제안합니다.
  <!-- 예: "PROGRESS.md에 '소셜 로그인 API 완료' 추가 권장", "README에 환경변수 추가 필요" -->

## Promotion Rules

산출물이 프로젝트의 어떤 위치로 승격되는지 정의합니다.

- **CONTEXT.md**: <!-- 프로젝트 범위, 목표, 제약사항이 변경될 때 갱신 -->
- **PROGRESS.md**: <!-- 마일스톤 달성, 주요 기능 완료, 블로커 발생/해소 시 갱신 -->
- **docs/***: <!-- API 문서, 아키텍처 문서 등 영구 참조 문서로 승격할 때 -->
- **keep in project pack only**: <!-- 아직 확정되지 않은 초안, 검토 중인 옵션, 실험적 내용 -->

## Guardrails

AI가 절대 하지 말아야 할 것들입니다.

- <!-- 예: 프로덕션 DB에 직접 쿼리하지 않는다 -->
- <!-- 예: .env 파일의 실제 값을 출력하지 않는다 -->
- <!-- 예: main 브랜치에 직접 push하지 않는다 -->
- <!-- 예: 사용자 확인 없이 파일을 삭제하지 않는다 -->
- <!-- 예: 외부 API 키를 코드에 하드코딩하지 않는다 -->

## Suggested Next-Step Style

AI가 작업 완료 후 다음 단계를 제안하는 방식을 정의합니다.

- 다음 요청 2개만 제안 <!-- 너무 많으면 선택 피로, 너무 적으면 방향성 부족 -->
- <!-- 예: 제안 형식 — "다음으로 (1) 테스트 작성 또는 (2) PR 생성을 할 수 있습니다." -->
- <!-- 예: 제안하지 않을 것 — 이미 완료된 작업의 반복, 범위 밖 작업 -->
