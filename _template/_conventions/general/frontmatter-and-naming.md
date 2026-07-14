# frontmatter·파일명·폴더 안내 (General)

> 📜 Governed by [`_init`](../../../_init/README.md) — 최고 규칙 계층. 충돌 시 _init 우선.

> **General** — 재사용 가능. 출처: SEEMEDI 전사베이스 vault 관행 일반화.

## frontmatter 스키마

마크다운 표준 문서는 frontmatter에 메타를 둔다(필드명은 프로젝트에 맞게 조정).

```yaml
---
id: <문서 ID>
area: <폴더 영역>
type: <문서 유형>
tags: [<자산 성격 태그>]
version: v1
updated: YYYY-MM-DD
---
```

- 폴더는 **읽는 순서·내비게이션**(1축), `tags`는 자산 성격 분류(2축)로 직교하게 둔다.

## 파일명

- 영문·숫자·`_`·`-`만. 공백·비ASCII 금지.
- 날짜는 `YYYY-MM-DD`(ISO 8601). 버전 접미사 `_v{M.m}`. → [document-versioning.md](./document-versioning.md)
- 정렬 접두 `00_`, 참조 `_REF`, 접근제한 `_RESTRICTED` 등 접두/접미 규칙 활용.

## 폴더 안내 파일

- 폴더 안내 파일명은 **`__README.md`**(밑줄 2개, 상단 정렬용) 권장.
- 일반 `README.md`와 구분해 폴더 내비게이션 용도로 사용.
