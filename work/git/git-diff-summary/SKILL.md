---
name: git-diff-summary
description: "Use this skill when the user wants to compare current code with a previous git state and get a summary of what changed. Triggers on: 'what changed', 'summarize changes', 'diff summary', 'what did I change', 'compare with last commit', '변경사항 요약', '뭐가 바뀌었는지', '지금까지 뭐 했어'."
---

# Git Diff Summary

## 목적
현재 작업 중인 코드와 이전 git 상태를 비교하여 변경사항을 사람이 읽기 쉬운 형태로 요약합니다.

## 지침

### 1. 비교 기준 파악
사용자가 기준을 지정하지 않으면 다음 순서로 시도합니다:
- 스테이지된 변경사항: `git diff --staged`
- 스테이지 안 된 변경사항: `git diff`
- 마지막 커밋과 비교: `git diff HEAD`
- 특정 브랜치/커밋과 비교: `git diff <base>`

### 2. 변경사항 수집
```bash
# 변경된 파일 목록
git diff --name-status HEAD

# 전체 diff
git diff HEAD

# 커밋 로그 (작업 맥락 파악용)
git log --oneline -10
```

### 3. 분석 및 요약
다음 관점으로 변경사항을 분석합니다:
- **무엇이 바뀌었나**: 추가/수정/삭제된 파일과 핵심 변경 내용
- **왜 바뀌었나**: 코드 맥락에서 의도를 추론
- **영향 범위**: 다른 파일이나 기능에 미치는 영향
- **주의사항**: 리뷰가 필요하거나 테스트가 필요한 부분

## 출력 형식

```markdown
## 변경사항 요약

**비교 기준**: HEAD (마지막 커밋) vs 현재 작업본

### 변경된 파일 (N개)
| 파일 | 변경 유형 | 요약 |
|------|-----------|------|
| src/auth.js | 수정 | 로그인 검증 로직 추가 |
| README.md | 수정 | 설치 방법 업데이트 |

### 주요 변경 내용
1. **[파일명]** — 무엇을 왜 변경했는지

### 영향 분석
- 영향을 받는 기능/모듈

### 주의사항
- 테스트 필요 항목 또는 리뷰 포인트
```
