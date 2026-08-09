# Swift (General)

> 📜 Governed by [`_init`](../../../_init/README.md) — 최고 규칙 계층. 충돌 시 _init 우선.

> **General** — 재사용 가능. 정본은 by-task 문서. 여기는 언어별 요약. **사본** — SSOT는 전사 컨벤션 레포(비공개)의 `code-conventions/by-language/`. 상충 시 SSOT 우선.

## 스타일 (SSOT: Swift API Design Guidelines, SwiftLint)

- 들여쓰기 **4 스페이스**, 최대 줄길이 **100**.
- 중괄호 K&R. 공개 타입 1개 권장.
- 선언 순서: 저장 프로퍼티 → 계산 프로퍼티 → 이니셜라이저 → 메서드, `// MARK:` 구획.
- import 모듈 알파벳순, `@testable`은 테스트 타깃 한정.
- **옵셔널 강제 언랩(`!`) 지양**.

## 명명

- 타입 PascalCase, 함수/변수 camelCase, 정적 let camelCase, 모듈 UpperCamel.
- 문서화 주석 **Swift Markup** (`///`, `- Parameter`/`- Returns`/`- Throws`).

## 툴체인

- 포매터/린터 SwiftLint(자동수정 + analyze). 버전 `.swift-version` 고정.

→ 상세: [../by-task/coding-style.md](../by-task/coding-style.md) · [naming-conventions.md](../by-task/naming-conventions.md)
