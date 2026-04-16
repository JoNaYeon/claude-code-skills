---
name: commit-message
description: "Use this skill when the user asks to generate a commit message, write a commit message, or wants help describing their changes for a git commit. Triggers on: 'write a commit message', 'generate commit message', 'help me commit', 'describe these changes'."
---

# Commit Message Generator

## 목적
스테이지된 변경사항을 분석하여 Conventional Commits 형식의 커밋 메시지를 생성합니다.

## 지침

1. `git diff --staged`로 스테이지된 변경사항을 확인합니다.
2. 변경사항의 성격을 파악합니다:
   - `feat`: 새 기능 추가
   - `fix`: 버그 수정
   - `docs`: 문서 변경
   - `style`: 코드 포맷팅 (동작 변경 없음)
   - `refactor`: 리팩토링 (동작 변경 없음)
   - `test`: 테스트 추가/수정
   - `chore`: 빌드, 설정 등 기타
3. 변경 범위(scope)를 식별합니다.
4. 커밋 메시지를 작성합니다.

## 커밋 메시지 형식

```
<type>(<scope>): <subject>

<body>
```

### 규칙
- **subject**: 50자 이내, 명령형, 소문자 시작, 마침표 없음
- **body**: 선택적, "왜" 변경했는지에 집중, 72자 줄바꿈
- **scope**: 변경된 모듈/컴포넌트명 (선택적)

## 예시

### 입력 (diff)
```diff
+ function validateEmail(email) {
+   return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
+ }
```

### 출력
```
feat(auth): add email validation function

Add regex-based email format validation to prevent
invalid email addresses during user registration.
```
