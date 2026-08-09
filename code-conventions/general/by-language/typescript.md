# TypeScript (General)

> 📜 Governed by [`_init`](../../../_init/README.md) — 최고 규칙 계층. 충돌 시 _init 우선.

> **General** — 재사용 가능. 정본은 by-task 문서. 여기는 언어별 요약. **사본** — SSOT는 전사 컨벤션 레포(비공개)의 `code-conventions/by-language/`. 상충 시 SSOT 우선.

## 스타일 (SSOT: Google TypeScript Style Guide / gts)

- 들여쓰기 **2 스페이스**, 최대 줄길이 **80**(Prettier printWidth).
- 중괄호 K&R, **홑따옴표(single quote)**, `===`, 화살표 함수.
- `export default` 지양 → **named export 권장**.
- 선언 순서: 타입/인터페이스 → 상수 → 컴포넌트/함수 → 하위 헬퍼.
- import: 외부 패키지 → 절대경로 별칭(`@/…`) → 상대경로, 타입 전용은 `import type`.

## 명명

- 타입/컴포넌트 PascalCase, 함수/변수 camelCase, 상수 UPPER_SNAKE, 파일 kebab-case.
- 문서화 주석 **TSDoc** (`/** */`, `@param`/`@returns`/`@throws`).

## 에러 처리

- `Error` 파생 커스텀 클래스 + `name` 지정. **문자열/객체 throw 금지**.
- 도메인 실패는 discriminated union `Result<T,E>`. 원인 보존 `new AppError(msg, { cause: e })`.

## 툴체인

- 포매터 Prettier, 린터 ESLint(gts 규칙셋), 타입 **tsc --strict**(모든 strict on).
- 의존성 `package-lock.json` + CI **`npm ci`**.

→ 상세: [../by-task/coding-style.md](../by-task/coding-style.md) · [error-handling-logging.md](../by-task/error-handling-logging.md) · [toolchain-quality-gates.md](../by-task/toolchain-quality-gates.md)
