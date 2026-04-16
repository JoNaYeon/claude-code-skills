---
name: code-review
description: "Use this skill when the user asks for a code review, wants feedback on their code, or requests a review of changes. Triggers on: 'review this code', 'code review', 'check my code', 'give me feedback on this', 'review my PR', 'look over this code', '코드 리뷰해줘', '코드 검토해줘', '피드백 줘', '코드 봐줘'."
---

# Code Review

## 목적
코드의 품질, 보안, 성능, 가독성을 체계적으로 검토합니다.

## 지침

### 1. 리뷰 범위 파악
```bash
git diff --name-only HEAD          # 변경된 파일 목록
git diff --stat HEAD               # 변경 규모 파악
```
- 변경된 파일을 모두 읽습니다.
- 변경 맥락을 이해하기 위해 주변 코드도 확인합니다.

### 2. 체크리스트 기반 검토
각 항목을 순서대로 점검합니다:

#### 정확성 (Correctness)
- 로직이 의도대로 동작하는가?
- 엣지 케이스가 처리되는가? (null, 빈 배열, 경계값 등)
- 에러 핸들링이 적절한가? (try-catch, 에러 전파)

#### 보안 (Security)
- 사용자 입력이 검증/이스케이프되는가?
- SQL 인젝션, XSS, CSRF 등 취약점이 없는가?
- 민감한 데이터(API 키, 비밀번호)가 코드에 노출되지 않는가?

#### 성능 (Performance)
- 불필요한 연산이나 루프가 없는가?
- N+1 쿼리 문제가 없는가?
- 메모리 누수 가능성이 없는가? (이벤트 리스너, 타이머 해제 등)

#### 가독성 (Readability)
- 변수/함수 이름이 명확한가?
- 복잡한 로직에 적절한 주석이 있는가?
- 함수가 단일 책임 원칙을 따르는가?

#### 유지보수성 (Maintainability)
- 코드 중복이 없는가?
- 테스트가 작성되어 있는가?
- 의존성이 적절한가?

### 3. 이슈 분류
발견된 이슈를 심각도별로 분류합니다:
- **Critical**: 버그, 보안 취약점 — 반드시 수정 필요
- **Warning**: 성능 문제, 잠재적 버그 — 수정 권장
- **Suggestion**: 가독성, 스타일 개선 — 선택적

### 4. 개선 코드 제시
Critical과 Warning 이슈에는 구체적인 수정 코드를 함께 제시합니다.

## 출력 형식

```markdown
## Code Review 결과

### Critical
- [파일:라인] 설명

### Warning
- [파일:라인] 설명

### Suggestion
- [파일:라인] 설명

### 요약
전반적인 코드 품질 평가 (1~2문장)
```
