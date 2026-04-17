---
name: work_git_git-finish
description: "Use this skill when the user has finished coding and wants to commit, push, and document their work. Triggers on: 'done coding', 'finished', 'push my work', 'commit and push', 'upload to git', 'create issue', '작업 완료', '다 했어', '깃에 올려줘', '커밋해줘', '작업 정리해줘'. Note: for PR creation use the pr-creator skill instead."
---

# Git Finish — 작업 마무리 & 업로드

## 목적
코드 작업 완료 후, 변경사항을 커밋·푸시하고 GitHub Issues에 작업 내용을 정리합니다.

## 지침

### 1. 변경사항 확인
```bash
git status
git diff --stat
```
- 변경된 파일 목록과 규모를 파악합니다.

### 2. 변경사항 요약 생성
`git-diff-summary` 스킬을 활용하여 변경 내용을 분석합니다.
- 무엇을 변경했는지
- 왜 변경했는지
- 영향 범위

### 3. 커밋 메시지 생성
`commit-message` 스킬을 활용하여 Conventional Commits 형식으로 생성합니다.

사용자에게 커밋 메시지를 보여주고 확인을 받은 후 커밋합니다.

**스테이징 시 주의사항**:
- `git add -A`를 사용하지 않습니다. 변경 파일을 개별 확인합니다.
- `.env`, `credentials`, `secret`, `*.pem`, `*.key` 등 민감 파일은 제외합니다.
- `.gitignore`에 포함되어야 할 파일이 추적되고 있으면 사용자에게 알립니다.

```bash
# 안전한 스테이징 — 파일을 명시적으로 지정
git add <확인된 파일 목록>
git commit -m "<생성된 커밋 메시지>"
```

### 4. Push
```bash
git push origin <현재 브랜치>
```
- 새 브랜치라면 `-u` 플래그 추가: `git push -u origin <브랜치>`

### 5. GitHub Issue 생성
사용자에게 확인합니다:

> GitHub Issue를 생성할까요?

**Yes 선택 시** — 다음 형식으로 Issue 내용을 생성하고 사용자에게 보여줍니다:

```markdown
## 작업 내용
변경사항 요약

## 변경된 파일
- 파일 목록

## 변경 이유
작업 배경 및 목적

## 체크리스트
- [ ] 테스트 확인
- [ ] 문서 업데이트
```

그 다음 GitHub CLI 또는 API로 Issue를 생성합니다:
```bash
gh issue create --title "<제목>" --body "<내용>"
```

`gh`가 없으면 Issue 내용을 마크다운으로 출력하여 직접 붙여넣을 수 있게 합니다.

### 6. 완료 보고
커밋, 푸시, Issue 생성 결과를 한눈에 정리합니다.

## 출력 형식

```markdown
## 작업 완료 ✅

- **커밋**: feat(auth): add email validation
- **브랜치**: feat/user-auth → origin
- **GitHub Issue**: #42 생성 완료

### 작업 요약
오늘 한 작업 2~3줄 요약
```
