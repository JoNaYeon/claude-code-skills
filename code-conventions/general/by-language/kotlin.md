# Kotlin (General)

> **General** — 재사용 가능. 정본은 by-task 문서. 여기는 언어별 요약.

## 스타일 (SSOT: 공식 Kotlin Coding Conventions, ktlint 강제)

- 들여쓰기 **4 스페이스**, 최대 줄길이 **100**.
- 중괄호 K&R(여는 중괄호 같은 줄), trailing comma 허용.
- 파일당 공개 타입 1개 권장(연관 sealed/data 예외).
- 선언 순서: 프로퍼티 → init → 보조 생성자 → 메서드 → companion.
- import: stdlib → 서드파티 → 사내 그룹, 각 알파벳순, **와일드카드 import 금지**.

## 명명

- 클래스 PascalCase, 함수/변수 camelCase, 상수 UPPER_SNAKE, 패키지 소문자.
- 문서화 주석 **KDoc** (`/** */`, `@param`/`@return`/`@throws`).

## 에러 처리

- **신규 코드는 언체크 예외 기준**. `@Throws`는 자바 상호운용 필요 시만.
- 도메인 실패는 sealed `Result`/`Either`(값) 또는 도메인 예외. 원인 보존 `throw AppException(msg, e)`.

## 툴체인

- 포매터 ktlint, 린터 detekt, 빌드 Gradle(version catalog + `gradle.lockfile`).
- 라이브러리 모듈은 explicit API mode.

→ 상세: [../by-task/coding-style.md](../by-task/coding-style.md) · [error-handling-logging.md](../by-task/error-handling-logging.md) · [toolchain-quality-gates.md](../by-task/toolchain-quality-gates.md)
