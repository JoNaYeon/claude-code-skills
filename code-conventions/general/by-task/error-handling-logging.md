# 에러 처리·로깅 (General)

> 📜 Governed by [`_init`](../../../_init/README.md) — 최고 규칙 계층. 충돌 시 _init 우선.

> **General** — 재사용 가능. **사본** — SSOT는 전사 컨벤션 레포(비공개)의 `code-conventions/by-task/`. 상충 시 SSOT 우선.
> 조직 특이 정책(강화 규칙)은 비공개 조직 정책 레포에서 관리한다.

## 예외 계층

예외는 **도메인 예외**와 **기술 예외** 2계층으로 분리한다(MUST).

| 계층 | 용도 | 외부 노출 |
|------|------|-----------|
| 도메인 예외 | 비즈니스 규칙 위반(검증 실패, 상태 위반) | 코드 매핑 후 노출 |
| 애플리케이션 예외 | 유스케이스 오케스트레이션 실패, 권한 | 코드 매핑 후 노출 |
| 기술 예외 | DB/네트워크/직렬화/외부연동 | 은닉, 500 계열로 일반화 |

- 하위 기술 예외를 상위 경계로 그대로 전파하지 않고 **경계에서 변환(translate)**.

## 예외 처리 규칙

- **예외 삼키기 금지(MUST NOT)**: `catch` 후 무시·로그만 남기고 정상 흐름 지속 금지.
- **재던지기 시 원인 보존**: Kotlin `throw AppException(msg, e)`, Python `raise AppError(...) from e`, TS `new AppError(msg, { cause: e })`.
- **이중 로깅 금지**: 동일 예외를 계층마다 반복 로깅하지 않는다. **최상위 경계 한 곳에서 1회** ERROR 로깅.
- **광범위 catch 금지**: `catch (Exception)` 무분별 사용 금지. 최상위 경계 핸들러만 예외.

## 도메인 실패 표현: Result 또는 예외

예상 가능한 도메인 실패는 **인프라 장애(기술 예외)와 구분**한다(MUST).

- **(a) 값 기반(SHOULD)** — sealed `Result`/`Either`, TS discriminated union. 실패가 흔하고 호출부가 분기·복구해야 하는 흐름.
- **(b) 도메인 예외 기반(MAY)** — 도메인/애플리케이션 예외 계층 + 경계 코드 매핑. 전통적 OOP 스타일.
- 어느 방식이든 예상된 도메인 실패와 인프라 장애를 같은 타입으로 뭉뚱그리지 않는다(MUST).

## 외부 노출 에러 (REST)

- 에러 본문은 **RFC 9457 `application/problem+json`**(MUST).
- 스택트레이스·SQL·내부 경로·호스트명·라이브러리 버전 **외부 노출 금지**. `detail`은 사용자 안전 메시지만.
- 원인 추적은 응답의 `traceId`로만 연결. 상세 스택은 내부 로그에만.

```json
{ "type": "https://errors.example.internal/order/insufficient-stock",
  "title": "Insufficient stock", "status": 409,
  "code": "ORDER-0409", "detail": "요청 수량을 처리할 수 없습니다",
  "instance": "/v1/orders/abc", "traceId": "4bf92f35...e4736" }
```

## 구조화 로깅 (ECS)

- **전 스택 ECS(Elastic Common Schema) JSON 구조화 로깅**. 배포 환경 출력은 라인당 1 JSON(NDJSON).
- 라이브러리: Kotlin `SLF4J+Logback+logback-ecs-encoder`, Python `structlog+ecs-logging`, Node `pino+@elastic/ecs-pino-format`.
- **`println`/`print`/`console.log` 금지**(테스트·CLI 제외). 파사드로만 로깅.

### 필수 공통 필드

`@timestamp`(UTC), `log.level`, `message`, `service.name`, `service.version`, `service.environment`, `trace.id`, `span.id`, `ecs.version`.

## 분산추적 전파

- **W3C Trace Context** 기준. REST `traceparent`, gRPC metadata, Kafka 봉투 `trace_id`.
- **MDC/contextvars/AsyncLocalStorage로 요청 스코프 자동 주입** — 각 로그가 수동 전달 없이 `trace.id` 포함.

## 로깅 레벨

| 레벨 | 기준 |
|------|------|
| ERROR | 처리 실패로 요청 중단, 개입 필요 (5xx). prod 경보 연동 |
| WARN | 비정상이나 복구/폴백됨 (재시도 성공, 폴백) |
| INFO | 정상 비즈니스 이벤트 (요청 수신/완료). **prod 기본 레벨** |
| DEBUG | 진단용 상세. prod 상시 활성 금지 |

- **예상된 도메인 실패(4xx)는 ERROR 아님** — 클라이언트 오류는 INFO/WARN. ERROR는 서버 책임 실패 한정.
- 예외 1건당 ERROR 1회(최상위 경계).
