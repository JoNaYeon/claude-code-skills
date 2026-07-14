# API 명세 설계 (General)

> 📜 Governed by [`_init`](../../../_init/README.md) — 최고 규칙 계층. 충돌 시 _init 우선.

> **General** — 재사용 가능. 출처: SEEMEDI `STD-API-0001`에서 FHIR·PHI·회사 네임스페이스 제거.
> PHI URL 금지·PII 이벤트 격리: [../../seemedi/by-task/patient-data-phi.md](../../seemedi/by-task/patient-data-phi.md)

## 명세 우선(Spec-First) 원칙

1. **명세가 SSOT.** 스키마·필드·타입·에러는 명세 산출물(OpenAPI/`.proto`)이 유일 원천. Code-First(어노테이션→스펙) 금지.
2. **명세 없이 인터페이스 변경 금지.** 먼저 명세를 수정·리뷰 통과.
3. **명세→코드 생성(codegen).** 서버 스텁·클라이언트 SDK·타입은 명세에서 파생.
4. **명세는 CI가 검증.** lint·breaking 검사 미통과 시 머지 불가.

- **동기 통신은 REST 기본.** gRPC는 스트리밍 전용(그 외 용도는 ADR 근거).

## 데이터 표기·공통 타입

- JSON(REST)=camelCase, Protobuf(gRPC·Kafka)=snake_case, DB=snake_case. 경계 변환은 codegen.
- 시간: Protobuf `google.protobuf.Timestamp`(UTC), REST ISO 8601 문자열(UTC). epoch 정수·지역시각 금지.
- REST 스키마 = **OpenAPI 3.1**, gRPC·Kafka = **Protobuf proto3**.

## REST 설계

- 리소스는 **복수형 명사·kebab-case 경로**: `/patients`, `/diagnostic-reports`. 동사 경로 금지.
- 계층 최대 2단계 권고.

| 메서드 | 용도 | 성공 | 멱등 |
|--------|------|------|:---:|
| GET | 조회 | 200 | O |
| POST | 생성·비멱등 액션 | 201/200 | X |
| PUT | 전체 교체 | 200/204 | O |
| PATCH | 부분 수정(RFC 7386) | 200/204 | 허용 |
| DELETE | 삭제 | 204 | O |

- 에러 본문 **RFC 9457 problem+json**. 커서 기반 페이지네이션 기본(`items[]`+`nextCursor`, limit 기본 20·최대 100).
- 429는 `Retry-After` 헤더 필수.

## gRPC / Protobuf

- 메시지·RPC=PascalCase, 필드=snake_case, enum 값=UPPER_SNAKE(`_UNSPECIFIED=0` 첫 값).
- **필드·enum 값 삭제 금지** — `reserved` 번호·이름 선언. 필드 번호·타입 변경 금지(새 필드 추가 후 구필드 `deprecated`).
- Buf로 lint·breaking 관리.

## Kafka 이벤트

- 토픽 = `<도메인>.<이벤트>.v{n}`: `order.finalized.v1`. 이벤트명은 **과거형 사실**(created/finalized/failed).
- 직렬화 Protobuf, Schema Registry 호환성 `BACKWARD`.
- 공통 봉투(`event_id`/`event_type`/`occurred_at`/`trace_id`/`schema_version`/`payload`).

## 버저닝·호환성

- **명세축은 MAJOR만 노출**: REST `/v{n}`, gRPC 패키지 `.v{n}`, Kafka 토픽 `.v{n}`. 코드 SemVer와 독립.
- 하위호환 변경(필드 추가)은 MAJOR 안 올림. 파괴적 변경만 새 MAJOR.
- REST=`oasdiff breaking`, gRPC/Kafka=`buf breaking` CI 강제.
- 외부 API: 신 MAJOR 후 구 MAJOR **최소 12개월** 유지. 내부: 최소 3개월 병행.

## 문서화·검증

- **문서는 명세에서 자동 생성**(드리프트 방지). 수기 API 문서 금지.
- 소비자 주도 명세 테스트(CDC, 예: Pact). 명세 스키마 이탈 시 실패.
