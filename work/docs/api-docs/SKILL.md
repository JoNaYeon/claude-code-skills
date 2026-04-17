---
name: api-docs
description: "Use this skill when the user asks to generate API documentation, document endpoints, or create API references from source code. Triggers on: 'document this API', 'generate API docs', 'write endpoint documentation', 'create API reference', 'API 문서 만들어줘', 'API 문서화', '엔드포인트 정리해줘'."
---

# API Documentation Generator

## 목적
소스 코드에서 API 엔드포인트를 분석하여 구조화된 API 문서를 생성합니다.

## 지침

### 1. 엔드포인트 탐색
- 라우터/컨트롤러 파일을 찾습니다.
- 모든 HTTP 엔드포인트를 수집합니다.
- 미들웨어와 인증 요구사항을 파악합니다.

### 2. 엔드포인트별 문서화
각 엔드포인트에 대해 다음을 기록합니다:
- HTTP 메서드 + 경로
- 설명 (코드와 주석에서 추론)
- 요청 파라미터 (path, query, body)
- 응답 형식 및 상태 코드
- 인증 필요 여부
- 에러 케이스

### 3. 문서 구성
- 기능별로 그룹핑합니다.
- 공통 에러 응답을 별도 섹션으로 분리합니다.

## 출력 형식

```markdown
# API Reference

## Base URL
`https://api.example.com/v1`

## Authentication
Bearer token in Authorization header.

---

## [그룹명]

### `GET /endpoint`
설명

**Parameters**
| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id   | path | string | Yes | 리소스 ID |

**Response** `200 OK`
\`\`\`json
{ "id": "...", "name": "..." }
\`\`\`

**Errors**
| Status | Description |
|--------|-------------|
| 404    | 리소스를 찾을 수 없음 |
```
