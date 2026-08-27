<!-- harness:agents begin — 생성물. 손으로 고치지 않는다. -->

# AGENTS.md

이 레포에서 코드·문서를 다루는 모든 AI 도구가 따르는 규칙이다. **생성물이므로 손으로
고치지 않는다** — 고치면 다음 재생성에서 사라진다. 원본은 하네스 레포의 규칙 조각이고,
재생성은 `scripts/export-agents-md.py` 가 한다.

선언: 조직 `none` · 역할 `none` · 가시성 `public` · 헌법은 진입점만

환경을 갖추려면 `.ai/HARNESS.md` 를 본다.

---

## 헌법 (_init 진입점)

# `_init` — 최고 규칙 계층 (Constitution)

> ⚠️ **이 폴더는 전체 문서가 참조하는 가장 높은 규칙이다. 일반 task 중에는 변경하지 않는다.**
> 개정은 사용자의 명시적 승인으로만 한다(→ `00_governance.md`).

<!-- 출처: JoNaYeon/claude-code-skills `_init/` 계층을 이 하네스 레포에 맞게 각색.
     2026-08-22: 같은 레포의 개인 스킬을 이 레포로 이관하고 조직축을 레포 안으로 들였다. -->

## 성격

`_init`은 이 레포의 모든 규칙 문서(`workflows/` · `code-conventions/` · `mlops-framework/` ·
`harness/`의 general·roles·orgs · `docs/`)와 스킬·에이전트 정의 위에 서는 **헌법**이다.
하위 문서가 `_init`과 충돌하면 `_init`이 우선한다. 하위 문서는 `_init`의 원칙을
**구현·상속**할 뿐, 원칙 자체를 재정의하지 않는다.

이 레포는 **private 하네스 레포**다 — 헌법·공통(general)·역할별(roles)·조직별(orgs) 규칙과
개인 스킬을 한 곳에 담고, 모든 프로젝트가 전역 설치로 이 레포를 참조한다. 조직은 공통·역할
규칙을 **강화·제외·대체**할 수 있고, `_init`과 general Security Rules만 예외다
(→ `01_precedence.md` P4).

## 카테고리 (읽는 순서)

| # | 문서 | 카테고리 | 내용 |
|---|------|----------|------|
| 00 | `governance` | 거버넌스 | `_init`의 권위·불변 원칙·개정 절차 |
| 01 | `precedence` | 우선순위·상속 | SSOT, 복제 금지, 상충 해결 순위, 계층별 변경 권한 |
| 02 | `classification` | 분류 | 역할축·조직축 2축, 조직 레지스트리(각 조직 README) |
| 03 | `authoring` | 문서 작성 | 버전 `_vN`·명명·참조 배너 |
| 04 | `workflow` | 작업 방식 | 제안 후 실행 · 오케스트레이션 게이트 · 되돌릴 수 없는 작업 전 확인 |

## 하위 문서와의 관계

- **원칙(WHAT/WHY)의 SSOT = `_init`.** 세부(HOW)의 SSOT = 하위 규칙 문서
  (예: 모델 배정의 세부 = `workflows/model-selection.md`).
- 구조·설치·사용법은 규칙이 아니라 안내다 — `docs/GUIDE.md`와 `harness/README.md`가 담는다.
- 하위 규칙 문서는 상단에 `> Governed by `_init`` 배너로 이 계층을 참조한다.

---

## general — 모든 역할·조직 공통

> Governed by ``_init`` — 최고 규칙 계층. 충돌 시 _init 우선.

## Route Table (general — 모든 하네스 공통)

**아래 경로는 하네스 루트 기준**(`~/.claude/CLAUDE.md`의 `harness-root` 주석) — 프로젝트 안이 아니다.
헌법은 진입점(`_init/README.md`)만 전역 로드된다 — 본문 5파일은 필요할 때 그 경로에서 직접 읽는다.

| 상황 | 참조 문서 (하네스 루트 기준) |
|------|----------|
| 규칙 충돌·문서 작성 형식·승인 게이트 (최고 규칙) | `_init/` (00 거버넌스 ~ 04 워크플로우) |
| 구역 2개 이상·물량전 혼재 임무 → 작업팀 편성 | `/team-dispatch` 스킬 |
| 어떤 작업에 어떤 모델을 쓰는지 | `workflows/model-selection.md` |
| 코드 품질 게이트 · Git 브랜치·커밋·worktree 규칙 | `CODE_QUALITY.md`, `GIT_WORKFLOW.md` (정본: `code-conventions/by-task/git-workflow.md`) |
| 코드 작성 컨벤션 (스타일·명명·에러·API·인프라) | `code-conventions/` (전사 정본) |
| 보안 방어 체계 (훅·커밋 게이트·외부 전송) | `workflows/security-model.md` |
| 조직별 값(레지스트리·클러스터·트래커 URL) — 프로젝트 > 조직 > 하네스 루트 | `scripts/config-get.sh <section.key>` (해석기) |
| 사용자 확인 문서(승인 요청·체크리스트·결정 기록) · vault 동기화 충돌 · 공부 기록 채집 | `workflows/vault-conventions.md` → 옵시디언 vault `{vault.path}/{vault.subdir}/` |
| 세션 핸드오프 — 다른 계정·머신·AI 도구가 이어받는 자리 | 레포 `.ai/handoff/YYYY-MM-DD.md` (양식 `templates/ai-pack/handoff/_TEMPLATE.md`) |
| 문서·문장 표기(이모지·기호 금지, 상태 표식, 마크다운) · 그림과 표의 A4 크기 | `workflows/doc-style.md` |
| 계층 구조·전역 설치 | `harness/README.md` |
| 세션 중 조직·역할 전환 | `/role` 스킬 |
| 구조·설치 전체 가이드 | `docs/GUIDE.md` |

## 모델 배정 (요약 — 정본은 workflows/model-selection.md)

- 소환자가 소환 시점에 모델을 결정한다. 소환 뒤에는 바꿀 수 없다.
- 판단·설계·평가 판정 = opus / 구역 작업 = sonnet / 물량 = haiku / 전략 자문 = fable.
- 검증 게이트는 1차 sonnet 전수 → 최종 opus. 작업한 모델이 자기 작업을 검증하지 않는다.

## Security Rules (공통)

- NEVER read, open, or cat any .env file. Use .env.example for reference.
- NEVER include API keys, tokens, or secrets in code, comments, or commit messages.
- If a task requires an API key value, ask the user — do not read it from files.
- 사내 원문·개인정보·실명·절대 경로를 외부 AI(용병)로 보내지 않는다.
- 전체 방어 체계는 `workflows/security-model.md` 참조. 도메인 계층은 여기에 훅을 **추가**한다(완화 불가).

## Quality Gate

커밋·푸시 전 `CODE_QUALITY.md`의 변경 유형별 체크리스트 확인 후 `GIT_WORKFLOW.md`에 따라
진행한다. 순서 고정: 품질 검수 → Git 작업. 도메인별 릴리스 게이트는 각 계층 fragment가 정한다.

## 작업 방식 (요약 — 정본은 _init/04_workflow.md)

- 파일을 만들거나 바꾸는 작업은 **제안 → 승인 → 실행** 순서를 지킨다.
- team-dispatch 편성안(구역·모델 배정·완료 기준)이 곧 제안이다 — 승인된 범위 안의 개별 파일 작업은 건별 승인 없이 진행한다.
- `_init/`은 일반 task 중 변경 금지 — 개정은 명시적 요청으로만.

## Conventions (공통)

- Commit: Conventional Commits `type(scope): 설명` (type 11종 고정) · AI 작성 표시는 레포 소유로 갈림 — 조직 소유 레포는 trailer 제외, 개인·공부 레포는 세션 모델명 포함 — 상세는 `GIT_WORKFLOW.md`
- Code comments·식별자: English / 문서·커밋 설명: 한국어 (조직이 다르면 조직 조각에서 대체)
- 상태 표식: `[ ]` 미시작 · `[~]` 진행중 · `[x]` 완료 · `[!]` 차단 · `[-]` 스킵
- 표기: 이모지·절 기호·원문자를 쓰지 않는다 — 나열은 `-`·`*`, 절 참조는 `[7]`. 마크다운 파일에서는 마크다운 문법을 적극 쓴다. 그림·표는 A4 한 쪽 안에 (정본: `workflows/doc-style.md`)
- 구조 선언 먼저: 복사·생성 전에 `구조 선언: <목록>` 한 줄을 남긴다
- 빈 폴더·선제 구조 확장 금지 — 폴더는 담을 파일과 함께, 새 구조는 필요 실증 후. 예외: config `[unwired]` 키(배선 전 슬롯)
- **사용자 확인 문서는 옵시디언 vault에** (정본: `workflows/vault-conventions.md`): 승인 요청서·체크리스트·핸드오프·결정 기록·
  관리 리포트는 `{vault.path}/{vault.subdir}/`에, 레포에는 링크·요약만. 충돌 시 이 PC가 정본(V2). 작업 중 얻은 일반화 지식은 개인 vault 공부 기록으로 채집 가능 — 조직 값 제외(V4).
- 설명은 **비유 없이 용어로, 필요한 것만**: 개념을 다른 사물에 빗대지 않고 그 분야의 정확한 용어와 정의로 쓴다(낯선 용어엔 정의 한 줄). 답에 필요한 사항만 — 배경·역사·대안 나열은 요청받거나 결정에 영향을 줄 때만.
- 조직 조각은 강화·제외·대체 가능, `_init`·Security Rules는 강화만 (`_init/01` P4)

<!-- harness:agents end -->
