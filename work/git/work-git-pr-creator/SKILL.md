---
name: work-git-pr-creator
description: "Use this skill when the user wants to create a pull request, write a PR description, or open a PR on GitHub. Triggers on: 'create PR', 'make a pull request', 'open PR', 'write PR description', 'PR 만들어줘', 'PR 올려줘', '풀리퀘 만들어줘'."
---

# PR Creator

## 목적
현재 브랜치의 변경사항을 분석하여 GitHub Pull Request를 자동으로 생성합니다.

## 지침

### 1. 베이스 브랜치 감지 및 확인
```bash
# 기본 브랜치 자동 감지
git remote show origin | grep 'HEAD branch'
# 또는
git symbolic-ref refs/remotes/origin/HEAD
```
사용자에게 확인합니다:
> 어느 브랜치로 PR을 보낼까요? (감지된 기본 브랜치: main/master/develop)

### 2. 현재 브랜치가 push되었는지 확인
```bash
git log origin/<현재 브랜치>..HEAD --oneline 2>/dev/null
```
- 아직 push되지 않은 커밋이 있으면 먼저 push합니다: `git push -u origin <현재 브랜치>`

### 3. 변경사항 수집
```bash
git log <base>..HEAD --oneline        # 커밋 목록
git diff <base>...HEAD --stat         # 변경 파일 요약
git diff <base>...HEAD                # 전체 diff
```

### 4. PR 내용 작성
변경사항을 분석하여 아래 형식으로 PR 본문을 작성합니다.
- 제목은 70자 이내, Conventional Commits 스타일 권장
- 커밋이 여러 개면 모든 커밋의 변경 내용을 종합합니다.

### 5. PR 생성
```bash
gh pr create --title "<제목>" --body "<내용>" --base <베이스 브랜치>
```
`gh`가 없으면 PR 내용을 출력하여 GitHub 웹에서 붙여넣을 수 있게 합니다.

## 출력 형식 (PR 본문)

```markdown
## 개요
이 PR에서 무엇을 변경했는지 1~2문장으로 설명

## 변경 내용
- 변경사항 1
- 변경사항 2

## 변경 이유
왜 이 작업이 필요했는지

## 테스트
- [ ] 단위 테스트 통과
- [ ] 직접 동작 확인

## 스크린샷 (UI 변경 시)
해당 없음

## 관련 이슈
Closes #<이슈 번호>
```
