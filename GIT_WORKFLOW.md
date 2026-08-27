# GIT_WORKFLOW — 브랜치·커밋 규칙 (프로젝트 적용 지점)

> Governed by ai-ops-harness `_init` — 최고 규칙 계층. 충돌 시 _init 우선.
> 정본: [code-conventions/by-task/git-workflow.md](../../code-conventions/by-task/git-workflow.md)
> — 이 파일은 요약 + 하네스 특이 규칙만 담는다. 상충 시 정본이 이긴다.

<!-- 프로젝트 루트에 GIT_WORKFLOW.md로 복사한 뒤 프로젝트에 맞게 조정하세요. -->

## 브랜치 (정본 요약)

- 표준은 **Git Flow** — `main` / `develop` / `feature|bugfix/*` / `release/x.x.x` / `hotfix/*`.
  hotfix는 main·develop 둘 다 반영(MUST). 상세·명명은 정본 참조.
- **소규모 예외**(정본이 부여): 1인·실험 중심 레포는 `main` + 작업 브랜치 단순형 허용 —
  채택 시 이 파일에 "단순형 채택"을 명시한다. 요건은 정본 참조.
- 1 이슈 = 1 브랜치 = 1 MR. 브랜치명: `<type>/<이슈번호>-<슬러그>`.
- 병렬 작업(팀 편성 시 분대장별 구역)은 worktree로 분리한다 — 같은 브랜치를
  두 에이전트가 동시에 만지지 않는다.

## 커밋 — Conventional Commits (정본 요약)

- 헤더: `type(scope): 설명` — 명령형·현재형·마침표 없음·50자 이내.
- **type 11종(정본 고정)**: feat / fix / refactor / perf / style / docs / test /
  build / ci / chore / revert. 커스텀 type을 만들지 않는다.
- 이슈 참조는 footer: `Refs: #N` / `Closes #N`. 파괴적 변경: `type!` 또는
  footer `BREAKING CHANGE:`.
- **AI 작성 표시**: 조직 소유 레포는 `Co-Authored-By: Claude …`·`Generated with …`를
  붙이지 않고, 개인 소유(공부·개인 프로젝트) 레포는 세션의 실제 모델명을 넣어 붙인다.
  소유 판별 순서(컨텍스트 선언 → 원격 계정 유형 → 사용자 확인)는 정본이 정한다.

### 도메인 규약 (프로파일별 이어붙임)

llm 프로파일은 `harness/roles/llm/GIT_WORKFLOW.llm.md`(ML scope 규약)를 이 파일 끝에
이어붙인다 — general에는 도메인 규칙을 두지 않는다(harness/README.md 상속 규칙 1).

- 하나의 커밋은 하나의 논리 변경 — 성격이 다른 변경을 섞지 않는다.

## 금지 (하네스 특이 포함)

- `--no-verify`로 훅을 우회하지 않는다 — 훅 실패는 원인을 고친다.
- force push는 자기 작업 브랜치에서만, 사유를 밝히고.
- 비밀값을 커밋하지 않는다 (.gitignore + pre-commit이 이중 방어. 가중치·데이터셋은 llm 조각·`harness/roles/llm/CLAUDE.llm.md`가 정본).
- 커밋/푸시는 사용자가 요청할 때만 — 외부로 나가는 작업은 사전 확인(`_init/04` W4).

## PR / MR

- 제목: `[type][scope] 해결내용 (closes #N)` — 정본 명명 규칙.
- 본문에 변경 요약 + 검증 방법(실행한 명령·결과)을 쓴다.
- 릴리스 성격 PR은 해당 도메인 게이트 결과를 첨부한다 — 게이트는 도메인 조각·계층 fragment가 정한다.
