# Python (General)

> 📜 Governed by [`_init`](../../../_init/README.md) — 최고 규칙 계층. 충돌 시 _init 우선.

> **General** — 재사용 가능. 정본은 by-task 문서. 여기는 언어별 요약.

## 스타일 (SSOT: Google Python Style Guide, PEP 8 상위집합)

- 들여쓰기 **4 스페이스**, 최대 줄길이 **88**(`ruff format`/black 기본).
- 선언 순서: 모듈 docstring → `__all__` → 상수 → 클래스 → 함수.
- import: isort(black 프로파일) — stdlib → 서드파티 → 로컬 3그룹, 그룹 내 알파벳순.

## 명명

- 클래스 PascalCase, 함수/변수 snake_case, 상수 UPPER_SNAKE, 모듈 snake_case.
- 문서화 주석 **docstring — Google 스타일**(`Args:`/`Returns:`/`Raises:`).

## 에러 처리

- 표준 예외 계층 확장(도메인 예외는 `Exception` 파생). 시스템 종료성 예외 상속 금지.
- 원인 보존 `raise AppError(...) from e`.

## 툴체인

- **ruff로 단일화**(포맷=`ruff format`, 린트=`ruff`) — flake8/isort/black 병행 금지.
- 타입 검사 **mypy --strict**. 의존성 uv/poetry `--require-hashes` 락.

→ 상세: [../by-task/coding-style.md](../by-task/coding-style.md) · [error-handling-logging.md](../by-task/error-handling-logging.md) · [toolchain-quality-gates.md](../by-task/toolchain-quality-gates.md)
