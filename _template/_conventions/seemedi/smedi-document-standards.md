# SEEMEDI 문서 표준 — SEEMEDI 특이

> 📜 Governed by [`_init`](../../../_init/README.md) — 최고 규칙 계층. 충돌 시 _init 우선.

> **SEEMEDI 특이** — 전사베이스 문서 체계 고유 규칙.
> 출처: `STD-DOC-0001`, `STD-TERM-0001` §8, `feedback_no-copy-v1-to-v2`.

## 문서 ID 체계 (STD)

- 표준 문서 ID = `STD-{도메인}-{4자리}`. 예: `STD-TERM-0001`, `STD-API-0001`, `STD-GIT-0001`, `STD-CODE-0001`.
- 예정 문서도 STD-ID로 참조: `STD-FHIR-0001(예정)`, `STD-SEC-0001(예정)`.

## frontmatter (전사베이스 v2 표준 필드)

```yaml
id: STD-XXX-0001
area: <0_index | 1_기반 | 2_저장소와형상 | 3_코드표준 | 4_인터페이스>
type: <표준 | 가이드 | 정책>
tags: [code | data | infra | devops | integration | governance | docs]
version: v1.5
updated: 2026-07-03
```

## 폴더 1축 = 개발흐름

`0_index` / `1_기반` / `2_저장소와형상` / `3_코드표준` / `4_인터페이스` — '분류'가 아니라 **읽는 순서·내비게이션**.

## .docx 원본 스타일

- 본문 폰트 **맑은 고딕**, 강조색 **2E75B6** 계열.
- 배너 표시명: `씨메디에이아이 (SEEMEDI AI)`.

## v1 폴더 보존·복제 금지 (결정7)

- **v1 파일을 v2로 복사·이동하지 않는다.** v1은 참조용 원본 보존.
- v2에는 신규 문서만. v1 참조는 링크로 연결하되 파일 복제 금지.
- NAS 마스터(연구 폴더구조·code_registry)는 원위치 보존, 표준은 `_REF` 참조로 상속(원문 복제 금지).
