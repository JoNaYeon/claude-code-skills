# SEEMEDI 네임스페이스·식별자 — SEEMEDI 특이

> 📜 Governed by [`_init`](../../../_init/README.md) — 최고 규칙 계층. 충돌 시 _init 우선.

> **SEEMEDI 특이** — 회사 고유 네임스페이스·제품·추적성.
> 출처: `STD-TERM-0001` §4·§6·§7·§9, `STD-LOG-0001` §3.3.
> General 명명 규칙: [../../general/by-task/naming-conventions.md](../../general/by-task/naming-conventions.md)

## 코드 네임스페이스 토큰 = `seemedi`

실제 도메인 `seemedi.com` 정합. 축약형 `smedi`·옛 `cmed`를 코드 토큰으로 쓰지 않는다.

| 대상 | 규칙 | 예 |
|------|------|-----|
| Kotlin 패키지 루트 | `com.seemedi.<domain>[.<sub>]` | `com.seemedi.ecg.finding` |
| proto 패키지 | `seemedi.<domain>.v{n}` | `seemedi.ecg.v1` |
| 계약 경로 | `contracts/seemedi/<domain>/v{n}/` | `contracts/seemedi/ecg/v1/` |
| 공통 타입 | `seemedi.common.v1` | `EventEnvelope` |
| 에러 URI | `errors.seemedi.internal` | `https://errors.seemedi.internal/order/...` |
| 공유 라이브러리 | `seemedi-common`, `common-*` | `common-fhir`, `common-auth` |
| 인프라 접두 | `company=seemedi` | `seemedi-prod-ecg-inference-eks` |

> 회사명 표시(문서·배너)는 `SEEMEDI AI`, 약칭 `SMEDI`. → [../../../working-agreements/seemedi/smedi-reference.md](../../../working-agreements/seemedi/smedi-reference.md)

## 제품 · code_registry

| 제품 | 약칭 | 프로젝트 코드 |
|------|:---:|--------------|
| ECGmentor | ECG | P2026-001 |
| Endomentor | EDO | P2026-002 |
| Healthmentor | HEL | P2026-003 |
| Talkmentor | TLK | P2026-004 |

- code_registry는 v1 NAS 마스터를 `_REF` 참조로 계승(복제 금지).
- 프로젝트 `P{연도}-{순번}`, 연구 `S{연도}-{순번}-{약칭}`, IRB `IRB-{연도}-{순번}`, 케이스 `CASE-{5자리}`.

## 저장소·서비스 명명

| 대상 | 규칙 | 예 |
|------|------|-----|
| Git 저장소명 | `<제품약칭\|역할>-<컴포넌트>` kebab | `ecg-inference`, `tlk-stt` |
| 서비스명(런타임) | `<domain>-<role>` kebab | `ecg-report-svc` |
| 제품 도메인 접두 | 제품 약칭(소문자) | `ecg-*`, `edo-*`, `hel-*`, `tlk-*` |

## 추적성 식별자

- `REQ-{제품약칭}-{4자리}` (SSOT 안정 식별자). 파생 `RISK-`/`TC-`. 예: `REQ-ECG-0001`.
- GitLab은 관리엔진. 제품 약칭은 code_registry 약칭 컬럼과 일치.

## 에러코드 체계

- `{제품약칭}-{도메인}-{일련1}{HTTP3}`. 예: `ECG-ORDER-0409`, `HEL-REPORT-0422`, `ECG-INFRA-0500`.
- 도메인 토큰은 [medical-terminology-fhir.md](./medical-terminology-fhir.md) 도메인명 대문자.
- 카탈로그(`error-codes.yaml`) 단일 관리, CI 중복/미등록 린트.
