---
name: work_git_git-start
description: "Use this skill when the user is about to start coding work and wants to prepare their git environment. Triggers on: 'start coding', 'let's start', 'begin work', 'start working on', 'setup for work', '작업 시작', '코딩 시작', '작업 준비', '브랜치 따줘', '새 브랜치'."
---

# Git Start — 작업 시작 준비

## 목적
코드 작업 전, git 저장소 상태를 확인하고 작업 브랜치를 준비합니다.

## 지침

### 1. 현재 상태 확인
```bash
git status
git branch -a
git log --oneline -5
git remote -v
```

### 2. 미커밋 변경사항 처리
`git status` 결과에 변경사항이 있으면 사용자에게 확인합니다:

> 커밋되지 않은 변경사항이 있습니다. 어떻게 할까요?
> - **Stash** → `git stash -m "WIP: <설명>"` 으로 임시 저장
> - **Commit** → 현재 변경사항을 먼저 커밋
> - **Discard** → 변경사항 버리기 (위험 — 한번 더 확인)

### 3. 최신 코드 가져오기
```bash
git fetch origin
git pull origin <현재 브랜치>
```
- 충돌이 있으면 사용자에게 알리고 `conflict-resolver` 스킬의 방식으로 해결합니다.
- pull 후 stash를 적용했다면: `git stash pop` 실행, 충돌 시 안내.

### 4. 작업 내용 파악
사용자에게 묻습니다:
- 오늘 작업할 내용이 무엇인가요?

### 5. 브랜치 생성 여부 확인
사용자에게 확인합니다:

> 새 브랜치를 만들까요?
> - **Yes** → 브랜치 이름 제안 후 생성
> - **No** → 현재 브랜치에서 작업 계속

**Yes 선택 시 브랜치 네이밍 규칙**:
- `feat/<기능명>` — 새 기능
- `fix/<버그명>` — 버그 수정
- `refactor/<대상>` — 리팩토링
- `docs/<문서명>` — 문서 작업
- `chore/<작업명>` — 설정, 빌드 등

브랜치 이름은 작업 내용을 기반으로 자동 제안하되, 사용자가 수정할 수 있게 합니다.

```bash
git checkout -b feat/my-feature
```

### 6. 작업 환경 요약 보고
브랜치 준비 후 현재 상태를 한눈에 보여줍니다.

## 출력 형식

```markdown
## 작업 준비 완료 ✅

- **레포**: my-project
- **베이스 브랜치**: main (최신 상태)
- **작업 브랜치**: feat/user-auth (새로 생성)
- **현재 상태**: 변경사항 없음 (깨끗한 상태)

작업을 시작하세요!
```
