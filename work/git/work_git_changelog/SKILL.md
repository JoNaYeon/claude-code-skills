---
name: work_git_changelog
description: "Use this skill when the user wants to generate a changelog, update CHANGELOG.md, or summarize release notes from git history. Triggers on: 'generate changelog', 'update changelog', 'release notes', 'what changed in this version', 'CHANGELOG 만들어줘', '릴리즈 노트', '변경 이력 정리해줘'."
---

# Changelog Generator

## 목적
git 커밋 히스토리를 분석하여 버전별 CHANGELOG.md를 자동 생성하거나 업데이트합니다.

## 지침

### 1. 버전 범위 파악
사용자에게 확인합니다:
- 새 버전 번호가 무엇인가요? (예: v1.2.0)
- 어느 태그/커밋부터 현재까지 포함할까요? (기본: 마지막 태그 이후)

```bash
git tag --sort=-v:refname | head -5   # 최근 태그 확인
git log <last-tag>..HEAD --oneline    # 해당 범위 커밋
```

**태그가 없는 경우**:
- 첫 번째 커밋부터 현재까지 모든 커밋을 대상으로 합니다.
```bash
git log --oneline                      # 전체 커밋 히스토리
```
- 사용자에게 첫 버전 번호를 확인합니다 (기본 제안: v0.1.0 또는 v1.0.0).

### 2. 커밋 분류
Conventional Commits 타입 기준으로 분류합니다:
- `feat` → ✨ New Features
- `fix` → 🐛 Bug Fixes
- `perf` → ⚡ Performance
- `refactor` → ♻️ Refactoring
- `docs` → 📄 Documentation
- `chore`, `ci`, `build` → 🔧 Maintenance
- `BREAKING CHANGE` → 💥 Breaking Changes (맨 위)

### 3. CHANGELOG.md 업데이트
기존 CHANGELOG.md가 있으면 맨 위에 새 버전을 추가합니다.
없으면 새로 생성합니다.

## 출력 형식

```markdown
# Changelog

## [v1.2.0] - 2026-04-16

### 💥 Breaking Changes
- `authenticate()` 함수 시그니처 변경

### ✨ New Features
- 이메일 인증 기능 추가 (#42)
- 다크모드 지원

### 🐛 Bug Fixes
- 로그인 시 토큰 갱신 오류 수정

### 🔧 Maintenance
- 의존성 업데이트

[v1.2.0]: https://github.com/user/repo/compare/v1.1.0...v1.2.0
```
