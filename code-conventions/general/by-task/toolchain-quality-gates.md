# 툴체인·품질게이트 (General)

> 📜 Governed by [`_init`](../../../_init/README.md) — 최고 규칙 계층. 충돌 시 _init 우선.

> **General** — 재사용 가능. **사본** — SSOT는 전사 컨벤션 레포(비공개)의 `code-conventions/by-task/`. 상충 시 SSOT 우선.
> 조직 특이 정책(강화 규칙)은 비공개 조직 정책 레포에서 관리한다.

## 버전 고정 (재현성)

- **모든 언어/런타임은 정확 버전 고정**. 범위 지정(`^`, `~`, `>=`) 금지(MUST NOT).
- SSOT: 저장소 루트 `tool-versions.yaml` + **컨테이너 베이스 이미지 digest**(`@sha256:...`) 이중 계층. 불일치 시 CI fail.
- 컨테이너 베이스 이미지는 태그가 아닌 **digest로 고정**. `latest`·이동 태그 금지.

## 포매터·린터·정적분석 (언어별)

| 언어 | 포매터 | 린터 | 타입/정적분석 |
|------|--------|------|--------------|
| Kotlin | ktlint (max-line 100) | detekt | detekt 타입해석 |
| Python | ruff format (line 88) | ruff (단일화) | mypy --strict |
| TypeScript | Prettier (printWidth 80) | ESLint (gts 기반) | tsc --strict |
| Swift | SwiftLint 자동수정 | SwiftLint | SwiftLint analyze |
| C/C++ | clang-format | clang-tidy | clang-tidy |
| Proto | buf format | buf lint | buf breaking |

- Python은 flake8/isort/black을 **ruff로 단일화**.
- 타입 검사는 엄격 모드(mypy --strict, tsc --strict).
- 규칙셋 SSOT는 공유 config로 두고 각 레포는 **상속(extend)** 만. 로컬 완화 금지(MUST NOT), 강화는 허용.

## 의존성 재현성

의존성은 **해시/락 파일로 고정**하고 락 파일을 저장소에 커밋한다.

| 생태계 | 잠금 | 재현 설치 |
|--------|------|-----------|
| Gradle | version catalog + `gradle.lockfile` | `gradle build --offline` |
| Python | uv/poetry `--require-hashes` | `uv sync --frozen` |
| Node/TS | `package-lock.json` | **`npm ci`** (락 정확 일치) |
| Proto | `buf.lock` | `buf dep update` 후 커밋 |
| Container | 베이스 이미지 digest | digest pull |

- `npm install`(락 갱신) 대신 CI에서 **`npm ci`**. 락 불일치 시 fail.
- SBOM(CycloneDX)을 빌드 산출물로 생성(SHOULD).

## pre-commit 훅

로컬 커밋 단계에서 가장 저렴하게 위반 차단. 루트 `.pre-commit-config.yaml`.

| 훅 | 도구 | 차단 대상 |
|-----|------|-----------|
| 포맷 자동수정 | ktlint/ruff/prettier/clang-format | 미포맷 코드 |
| 린트 | ruff/eslint/detekt | 린트 에러 |
| 시크릿 탐지 | gitleaks + detect-secrets | 키·토큰·자격증명 누출 |
| 대용량/바이너리 | check-added-large-files | 임계(예: 5MB) 초과 |

## CI 품질게이트

머지 전 실행, 하나라도 fail이면 **머지 차단**.

- governance/구조 린트, 포맷·린트, 정적분석 경고, 의존성 재현성, SemVer 정렬, 시크릿 스캔.
- **변경분만 빌드(affected)**: 바뀐 모듈 + 하류만 빌드·테스트(전체 재빌드 금지). 원격 빌드 캐시 활용.
- 설정 파일(`.editorconfig`/`.gitignore`/`.gitattributes`)은 중앙 배포로 드리프트 방지.
