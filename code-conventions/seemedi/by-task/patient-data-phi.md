# 환자 데이터(PHI) 취급 — SEEMEDI 특이

> 📜 Governed by [`_init`](../../../_init/README.md) — 최고 규칙 계층. 충돌 시 _init 우선.

> **SEEMEDI 특이** — 환자 데이터·의료·규제 때문에 존재. 일반 프로젝트에는 적용 안 됨.
> 출처: `STD-LOG-0001` §7, `STD-API-0001` §4.3·§5.4, `STD-STACK-0001` §3.5, `STD-TERM-0001` §2.2.
> General 로깅·에러: [../../general/by-task/error-handling-logging.md](../../general/by-task/error-handling-logging.md)

## 핵심 전제 (전사 결정)

- **PHI(보호대상 건강정보)는 병원망(폐쇄망)을 벗어나지 않는다.** 회사망·AWS에는 **합성/비식별 데이터만**.
- 암호화 매핑 키·복호화 키는 **온프레미스 HSM에만** 둔다(병원망 비반출). → [db-separation.md](./db-separation.md)
- 민감도 등급 L1~L4, **PHI = L4**(최고 민감도).

## PHI 로깅 전면 금지 (L4, MUST NOT)

PII·PHI·환자식별자를 로그에 기록하는 것을 **전면 금지**. 로그 메시지, 구조화 필드, 예외 메시지/스택, 요청·응답 덤프 모두 포함.

| 금지 대상 | 예 | 허용 대체 |
|-----------|-----|-----------|
| 직접 식별자 | 환자명, 주민번호, 전화, 주소 | 비식별 표면 ID/해시(pseudonymous key) |
| 의료 식별자 | 환자ID(원본), MRN, 원본 이미지/파형 | 내부 대체키 + `trace.id` |
| 인증 비밀 | 토큰, 비밀번호, 세션, API 키 | 전부 마스킹(`***`) |
| 원문 페이로드 | 요청/응답 전체 바디, FHIR 원문 | 필드 화이트리스트만 |

- **공용 마스킹 유틸로만** 잠재 민감 값 로깅. 원시 객체 toString/직렬화 금지.
- 로그 대상은 **화이트리스트 방식**(명시 허용 필드만).
- 예외 메시지에 식별자 삽입 금지(생성 시점부터 비식별).

## 이중 통제 + 비반출

- **정적분석 게이트**: 금지 패턴(원시 페이로드 로깅, `console.log`, 민감 필드명)을 CI 린트/시크릿 스캐너로 차단.
- **pre-commit PHI 차단 훅**: 환자식별정보 유입 차단(전 레포 공통 MUST).
- **로그 비반출**: 로그·추적 데이터 회사망 밖 반출 금지. PHI 병원망 로그는 병원망 내 보존.

## API/이벤트에서의 PHI

- **원본 PII/PHI 식별자(MRN·주민번호·원본 환자ID)를 URL 경로·쿼리스트링에 담지 않는다(MUST NOT)** — 로그·프록시·캐시에 URL이 남음. URL에는 시스템 부여 **불투명 대체키(`patientRef`)만**. 불가피하면 **POST 조회 본문**으로.
- 404는 PII 존재 여부 노출 회피에도 사용.
- **PHI/PII 이벤트는 병원망 내부 토픽으로 격리**, 회사망·AWS 반출 금지. 회사망 이벤트는 합성/비식별만.
- 예시·목·픽스처는 **합성 데이터만**(`patientId: "SYNTH-0001"`). 실제 PHI 금지.

## 관련 용어

- 비식별화(deidentification, HIPAA Safe Harbor 정렬), 가명화(pseudonymization, ISO 25237, 가역 키는 L4 `_keys_RESTRICTED`).
- 환자식별자(patientIdentifier): 원문 MRN은 L4.
