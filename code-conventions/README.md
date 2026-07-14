# 코드 작성 컨벤션

> 📜 Governed by [`_init`](../_init/README.md) — 최고 규칙 계층. 충돌 시 _init 우선.

> 코드 작성 방식을 **General(재사용 가능)** 과 **SEEMEDI 특이(환자데이터·규제·의료)** 로 분리해 정리한 모음입니다.
> 근거: `C:\Users\user\OneDrive\vault\02_work\SEEMEDI\전사베이스` 표준 문서(STD-*).

## 분리 기준

| 구분 | 정의 | 예 |
|------|------|-----|
| **General** | 다른 회사/프로젝트에도 그대로 쓸 수 있는 것 | 코드 작성법, AWS 세팅, Git 워크플로우, API 설계 |
| **SEEMEDI 특이** | 이 회사·의료·규제 때문에만 존재하는 것 | 환자 데이터(PHI), DB/망 분리, 규제(의료기기), FHIR 용어 |

## `general/` — 재사용 가능

정본은 `by-task/`, `by-language/`는 언어별 요약.

### by-task
| 문서 | 내용 |
|------|------|
| [coding-style](./general/by-task/coding-style.md) | 인코딩/개행/줄길이, 문서화 주석, TODO 형식 |
| [naming-conventions](./general/by-task/naming-conventions.md) | 케이스, 약어, 경계 변환, DB 식별자 |
| [error-handling-logging](./general/by-task/error-handling-logging.md) | 예외 2계층, Result, problem+json, ECS 로깅, traceId |
| [toolchain-quality-gates](./general/by-task/toolchain-quality-gates.md) | 버전 고정, 린터, 락파일, pre-commit, CI |
| [api-design](./general/by-task/api-design.md) | Spec-First, REST/gRPC/Kafka, 버저닝 |
| [repo-and-versioning](./general/by-task/repo-and-versioning.md) | 멀티레포, 공유lib 배포, 6축 SemVer |
| [aws-infra-setup](./general/by-task/aws-infra-setup.md) | 인프라 명명·태그, EKS/S3/RDS, Terraform |
| [git-workflow](./general/by-task/git-workflow.md) | Git Flow, Conventional Commits, MR |

### by-language
[kotlin](./general/by-language/kotlin.md) · [python](./general/by-language/python.md) · [typescript](./general/by-language/typescript.md) · [swift](./general/by-language/swift.md) · [cpp](./general/by-language/cpp.md)

## `seemedi/` — SEEMEDI 특이

| 문서 | 내용 |
|------|------|
| [patient-data-phi](./seemedi/by-task/patient-data-phi.md) | PHI 병원망 비반출·비식별·PHI 로깅 금지·HSM |
| [db-separation](./seemedi/by-task/db-separation.md) | 식별 온프레미스/운영 AWS·raw/anon·하이브리드 |
| [regulated-track](./seemedi/by-task/regulated-track.md) | IEC 62304·governance.yaml·규제 레포 격리·트랙 차등 |
| [medical-terminology-fhir](./seemedi/by-task/medical-terminology-fhir.md) | FHIR 용어·finding/order/report·`interpretation` 금지 |
| [seemedi-namespace](./seemedi/by-task/seemedi-namespace.md) | `seemedi` 토큰·제품 ECG/EDO/HEL/TLK·REQ-ID·에러코드 |

## 사용 규칙

- **General 컨벤션은 항상 적용**한다.
- **SEEMEDI 레포에서 작업할 때만** `seemedi/` 컨벤션을 추가로 적용한다.
- 재사용: 다른 프로젝트에는 `general/`만 복사하면 된다.
