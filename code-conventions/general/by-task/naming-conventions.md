# 명명 규칙 (General)

> 📜 Governed by [`_init`](../../../_init/README.md) — 최고 규칙 계층. 충돌 시 _init 우선.

> **General** — 재사용 가능. **사본** — SSOT는 전사 컨벤션 레포(비공개)의 `code-conventions/by-task/`. 상충 시 SSOT 우선.
> 조직 특이 정책(강화 규칙)은 비공개 조직 정책 레포에서 관리한다.

## 언어별 표기 케이스

| 언어 | 클래스/타입 | 함수/변수 | 상수 | 패키지/모듈 |
|------|-----------|-----------|------|-----------|
| Kotlin | PascalCase | camelCase | UPPER_SNAKE_CASE | 소문자 |
| Python | PascalCase | snake_case | UPPER_SNAKE_CASE | snake_case |
| TypeScript | PascalCase | camelCase | UPPER_SNAKE_CASE | 파일 kebab-case |
| Swift | PascalCase | camelCase | camelCase(정적 let) | UpperCamel |
| C++ | PascalCase | camelCase 또는 snake_case(일관) | kENUM/UPPER_SNAKE | 소문자 namespace |

## 약어(Acronym) 처리

- 약어는 **한 단어처럼** 취급: `HttpClient`, `httpClient`, `restApiUrl` (O) / `HTTPClient`, `RESTApiURL` (X).
- 상수에서는 그대로 대문자: `MAX_HTTP_RETRY`, `DEFAULT_API_URL`.
- 2글자 약어도 동일: `IoStream`(O), `IOStream`(X).

## 경계 변환 (proto ↔ JSON ↔ 코드 ↔ DB)

같은 개념은 **같은 어근**을 유지하고, 경계마다 케이스만 변환한다(어근 변형 금지).

| 계층 | 케이스 | 예 |
|------|--------|-----|
| Proto/gRPC 필드 | snake_case | `source_language` |
| REST/JSON 필드 | camelCase | `sourceLanguage` |
| Kotlin 프로퍼티 | camelCase | `sourceLanguage` |
| Python 속성 | snake_case | `source_language` |
| DB 컬럼 | snake_case | `source_language` |

- proto → JSON은 protobuf JSON 매핑(lowerCamelCase 자동 변환) 사용, 수동 오버라이드 금지.

## DB 식별자 (General 부분)

- DB 식별자(테이블·컬럼·인덱스)는 **snake_case** 강제. 대문자·따옴표 식별자 금지.
- **테이블명은 복수형**: `patients`, `orders`, `reports`.
- 제약·인덱스 접두: `pk_{table}` / `fk_{table}_{ref}` / `uq_{table}_{cols}` / `idx_{table}_{cols}`.
- 감사 4컬럼 권장: `created_at` / `updated_at` / `created_by` / `is_deleted`(소프트 삭제).

## 파일·폴더명

- 영문·숫자·`_`·`-`만 허용. 공백·비ASCII 금지.
- 날짜는 `YYYY-MM-DD`(ISO 8601).
