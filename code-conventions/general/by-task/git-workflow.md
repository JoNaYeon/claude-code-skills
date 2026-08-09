# Git 워크플로우 (General)

> 📜 Governed by [`_init`](../../../_init/README.md) — 최고 규칙 계층. 충돌 시 _init 우선.

> **General** — 재사용 가능. **사본** — SSOT는 전사 컨벤션 레포(비공개)의 `code-conventions/by-task/`. 상충 시 SSOT 우선.
> 조직 특이 정책(강화 규칙)은 비공개 조직 정책 레포에서 관리한다.

## Git Flow 브랜치 전략

| 브랜치 | 역할 | 분기 출발 | 병합 대상 |
|--------|------|-----------|-----------|
| `main` | 배포 가능 코드, 태그 관리, 항상 실행 가능 | — | release/hotfix에서만 |
| `develop` | 다음 버전 통합 | main | main(release 경유) |
| `feature/*` | 기능 개발 | develop | develop |
| `bugfix/*` | 배포 전 QA 버그 수정 | develop | develop |
| `release/x.x.x` | 배포 준비 | develop | main(+태그) & develop |
| `hotfix/*` | 배포 후 긴급 수정 | main | **main & develop 둘 다** |

- **hotfix는 main·develop 두 곳 모두 반영**(MUST) — 안 하면 다음 릴리즈에서 버그 재발.

## 이슈·브랜치·MR 원칙

- **1 이슈 = 1 브랜치 = 1 MR**.
- 한 사람이 미해결 이슈를 3개 이상 동시 생성하지 않는다(WIP 제한).
- MR 발행 시 이슈 번호 refer.

## 명명 규칙

- 이슈: `[type][scope] 간결한 설명` (60자 이내, 명사형). 예: `[feat][web] add login`
- 브랜치: `<type>/<이슈번호>-<슬러그>` (소문자, 영문/숫자/하이픈). 예: `feature/10-add-login`
- MR: `[type][scope] 해결내용 (closes #N)`

## 커밋 메시지 (Conventional Commits)

- 헤더: `type(scope): 설명` — 명령형·현재형·마침표 없음·50자 이내.
- 이슈 참조는 **footer**: `Refs: #133` / `Closes #10`. 제목에 `(#N)` 넣지 않음.
- 파괴적 변경: `type!` 또는 footer `BREAKING CHANGE:`.

**type 11종**: feat / fix / refactor / perf / style / docs / test / build / ci / chore / revert.

```
feat(web): add login

Add OAuth login flow.

Closes #15
```

## 커밋 검수 (pre-commit)

```bash
pip install pre-commit
pre-commit install
pre-commit install --hook-type commit-msg --hook-type pre-commit
```

- 코드 형식·커밋 메시지는 pre-commit 훅으로 발행 시 자동 검수. 최초 1회 설치 MUST.

## 협업 흐름 (기능 개발)

```
develop 최신 pull → 이슈 발행 → feature/<이슈>-<슬러그> 분기
  → 작업 & 커밋 → push → MR 생성(base: develop)
  → 리뷰 & 승인 → develop 머지 & 브랜치 삭제 → 이슈 close
```
