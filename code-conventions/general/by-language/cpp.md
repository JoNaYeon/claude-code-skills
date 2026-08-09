# C++ (General)

> 📜 Governed by [`_init`](../../../_init/README.md) — 최고 규칙 계층. 충돌 시 _init 우선.

> **General** — 재사용 가능. 정본은 by-task 문서. 여기는 언어별 요약. **사본** — SSOT는 전사 컨벤션 레포(비공개)의 `code-conventions/by-language/`. 상충 시 SSOT 우선.

## 스타일 (C++17 이상, clang-format/clang-tidy)

- 들여쓰기 **4 스페이스**(탭 금지, 예외 없음), 최대 줄길이 **100**.
- 중괄호 K&R(함수는 새 줄 허용).
- 헤더 1개당 주 클래스 1개(TU 응집).
- 선언 순서: public → protected → private, 각 구역 타입→상수→메서드→멤버.
- import: 자기 헤더 먼저 → C 시스템 → C++ 표준 → 서드파티 → 프로젝트, 그룹 간 빈 줄.
- **RAII·스마트 포인터 기본, 원시 `new/delete` 지양**.

## 명명

- 타입 PascalCase(권장), 함수/변수 camelCase 또는 snake_case(프로젝트 내 1택 고정), namespace 소문자.
- 문서화 주석 **Doxygen** (`///` 또는 `/** */`, `@brief`/`@param`/`@return`/`@pre`/`@post`).

## 툴체인

- 포매터 clang-format, 정적분석 clang-tidy. 컴파일러 버전(clang) 베이스 이미지 digest 고정.

→ 상세: [../by-task/coding-style.md](../by-task/coding-style.md) · [naming-conventions.md](../by-task/naming-conventions.md)
