# 03 · 문서 작성 — 형식·버전·명명 최상위 규칙

> ⚠️ **최고 규칙(_init) — 일반 task 중 변경 금지.** 개정은 명시적 승인으로만.

## A1. 버전 규칙 `_vN`

- 파일명 버전 접미사 `_vN`에서 `vN+1`은 이전 버전의 **업데이트**다. 이전 버전은 보존한다.
- **부분 개정(기본)**: 이전 버전의 형식(섹션 구조·서술·표/JSON 스타일)을 그대로 따르고 변경분만 반영.
- **전체 개정**: 사용자가 "전체 개정"이라 **명시**할 때만 형식을 바꾼다.
- 애매하면 부분 개정(형식 유지)으로 간주. 세부는 [_template/_conventions/general/document-versioning.md](../_template/_conventions/general/document-versioning.md).

## A2. frontmatter (조직 표준 문서 한정)

- frontmatter 메타(`id`/`area`/`type`/`tags`/`version`)는 **조직 표준 문서 체계**(예: SEEMEDI STD-*)에서만 둔다. 필수 아님.
- **이 레포의 규칙 문서는 frontmatter 대신 상단 `Governed by _init` 배너**로 계층을 표시한다(A4). 스킬은 `name`/`description` frontmatter.
- frontmatter를 쓰면 폴더는 **읽는 순서·내비게이션**(1축), `tags`는 자산 성격(2축)으로 직교하게.

## A3. 명명

- 파일·폴더명은 영문·숫자·`_`·`-`만. 공백·비ASCII 금지.
- 날짜는 `YYYY-MM-DD`(ISO 8601). 폴더 안내 파일은 **`README.md`(기본)**. `__README.md`는 일부 조직 관례(예: SEEMEDI)이며 General 기본값 아님.
- 코드 식별자 명명은 [code-conventions/general/by-task/naming-conventions.md](../code-conventions/general/by-task/naming-conventions.md).

## A4. 참조 배너

- 모든 하위 규칙 문서는 상단에 **`> Governed by [_init](경로)`** 배너를 둔다.
- 규칙의 근거(SSOT)를 출처로 명시한다(예: `출처: STD-CODE-0001`).

## A5. 분류 반영

- 규칙 문서는 [02_classification.md](./02_classification.md)에 따라 `general/` 또는 조직 `<조직>/`에 둔다.

---
> **개정 이력** · 2026-07-14(정합): A2 frontmatter를 조직 표준 문서 한정으로 범위 축소(이 레포 규칙 문서는 `Governed by _init` 배너로 대체). A3 폴더 안내 파일 기본을 `README.md`로, `__README.md`는 조직 관례로 명시 (세션 승인).
