---
name: work-coding-debug-guide
description: "Use this skill when the user encounters an error, exception, or bug and needs help debugging. Triggers on: 'error', 'bug', 'exception', 'not working', 'debug this', 'why is this failing', '에러', '오류', '버그', '왜 안 되지', '디버그', '고쳐줘', 'stack trace'."
---

# Debug Guide

## 목적
에러 메시지와 스택 트레이스를 분석하여 원인을 파악하고 해결 방법을 제시합니다.

## 지침

### 1. 에러 정보 수집
다음을 확인합니다:
- 에러 메시지 전문
- 스택 트레이스
- 에러가 발생하는 코드 파일
- 에러 재현 조건 (언제, 어떤 입력으로)
- 최근 변경 사항

### 2. 에러 유형 분류
- **Syntax Error**: 문법 오류 → 해당 라인 즉시 수정
- **Runtime Error**: 실행 중 오류 → 원인 코드 추적
- **Logic Error**: 잘못된 결과 → 로직 흐름 분석
- **Type Error**: 타입 불일치 → 타입 체인 추적
- **Network/IO Error**: 외부 연결 문제 → 환경 확인
- **Dependency Error**: 패키지 문제 → 버전/설치 확인

### 3. 원인 분석
스택 트레이스에서 **내 코드**가 나오는 마지막 프레임에 집중합니다.
관련 파일을 읽고 다음을 확인합니다:
- null/undefined 접근
- 배열 범위 초과
- 비동기 처리 오류
- 잘못된 변수 스코프
- 외부 API 응답 형식 불일치

### 4. 수정
원인이 명확하면 바로 수정합니다.
불명확하면 가설을 세우고 언어에 맞는 디버깅 포인트를 추가합니다:

```js
// JavaScript / TypeScript
console.log('[DEBUG]', 변수명, typeof 변수명);
```
```python
# Python
print(f"[DEBUG] {변수명=}, {type(변수명)=}")
import traceback; traceback.print_exc()
```
```go
// Go
log.Printf("[DEBUG] %+v (%T)\n", 변수명, 변수명)
```
```java
// Java
System.out.printf("[DEBUG] %s (%s)%n", 변수명, 변수명.getClass().getName());
```

### 5. 재발 방지
- 에러 핸들링 추가 제안
- 유사 패턴 코드에 동일 문제가 없는지 확인

## 출력 형식

```markdown
## 디버그 분석

**에러 유형**: Runtime Error (TypeError)
**발생 위치**: src/user.js:42

### 원인
`user` 객체가 null인 상태에서 `.name` 프로퍼티에 접근하고 있습니다.
API 응답이 빈 배열일 때 `users[0]`이 undefined가 됩니다.

### 수정
(수정된 코드)

### 재발 방지
- Optional chaining 사용: `user?.name`
- API 응답 검증 로직 추가
```
