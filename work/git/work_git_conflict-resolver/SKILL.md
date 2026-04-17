---
name: work_git_conflict-resolver
description: "Use this skill when the user encounters merge conflicts, rebase conflicts, or needs help resolving git conflicts. Triggers on: 'merge conflict', 'resolve conflict', 'conflict', 'git conflict', '충돌', '컨플릭트', 'merge 충돌', '충돌 해결해줘'."
---

# Conflict Resolver

## 목적
Merge/Rebase 충돌을 분석하여 올바른 해결 방향을 제시하고 충돌을 해결합니다.

## 지침

### 1. 충돌 파일 파악
```bash
git status                          # 충돌 파일 목록
git diff --name-only --diff-filter=U  # Unmerged 파일 목록
```

### 2. 충돌 내용 분석
충돌 파일을 읽어서 각 충돌 블록을 분석합니다:
```
<<<<<<< HEAD (현재 브랜치)
현재 코드
=======
들어오는 코드
>>>>>>> feature/other-branch
```

각 충돌에 대해 판단합니다:
- **현재 브랜치 선택**: 현재 변경사항이 더 최신이거나 올바를 때
- **들어오는 변경 선택**: 상대 브랜치 변경이 더 올바를 때
- **둘 다 병합**: 두 변경사항이 모두 필요할 때
- **새로 작성**: 두 코드 모두 문제가 있어 새로 작성이 필요할 때

### 3. 해결 전략 설명
사용자에게 각 충돌별로:
- 두 코드의 차이점 설명
- 권장 해결 방향과 이유 제시
- 사용자 확인 후 적용

### 4. 해결 완료 처리
```bash
git add <해결된 파일>
git commit   # 또는 git rebase --continue
```

## 출력 형식

```markdown
## 충돌 분석

**충돌 파일**: 3개
- src/auth.js (2개 충돌)
- package.json (1개 충돌)

---

### src/auth.js — 충돌 #1
**현재 (HEAD)**:
\`\`\`js
// 현재 코드
\`\`\`

**들어오는 변경**:
\`\`\`js
// 상대 코드
\`\`\`

**권장**: 둘 다 병합 — 이유: 각각 다른 기능을 추가하므로 모두 필요합니다.
```
