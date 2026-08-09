# frontmatter·파일명·폴더 안내 (General)

> 📜 Governed by [`_init`](../../../_init/README.md) — 최고 규칙 계층. 충돌 시 _init 우선.

> **General** — 재사용 가능.

## frontmatter (선택 — 조직/프로젝트 관례에 따름)

- frontmatter 메타는 **필수가 아니다.** 조직 표준 문서 체계를 쓰는 프로젝트에서만 아래처럼 둔다.
- 이 레포의 규칙 문서는 frontmatter 대신 상단 **`Governed by _init` 배너**로 계층을 표시한다. 스킬(SKILL.md)은 `name`/`description` frontmatter를 쓴다.

```yaml
# 조직 표준 문서 체계를 쓸 때(선택)
---
id: <문서 ID>
area: <폴더 영역>
type: <문서 유형>
tags: [<자산 성격 태그>]
version: v1
updated: YYYY-MM-DD
---
```

- frontmatter를 쓰는 경우: 폴더는 **읽는 순서·내비게이션**(1축), `tags`는 자산 성격 분류(2축)로 직교하게 둔다.

## 파일명

- 영문·숫자·`_`·`-`만. 공백·비ASCII 금지.
- 날짜는 `YYYY-MM-DD`(ISO 8601). 버전 접미사 `_v{M.m}`. → [document-versioning.md](./document-versioning.md)
- 정렬 접두 `00_`, 참조 `_REF`, 접근제한 `_RESTRICTED` 등 접두/접미 규칙 활용.

## 폴더 안내 파일

- 폴더 안내 파일명은 **`README.md`**(기본).
- 일부 조직 관례는 상단 정렬용으로 `__README.md`(밑줄 2개)를 쓴다 — 이는 조직 정책이며 General 기본값 아님(비공개 조직 정책 레포에서 관리).
