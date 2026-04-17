---
description: "Use this skill as a mission control center for project task management, backlog, meeting notes, and integrated status dashboard. Triggers on: 'mission control', 'project dashboard', 'task management', 'backlog', '미션 컨트롤', '프로젝트 관제'."
---

# /work-ai-mission_control — {{project}} 관제

프로젝트 과업 관리 제어센터.
백로그 관리, 회의록 인제스트, Todoist 양방향 동기화, 통합 현황 대시보드.

## Input

`$ARGUMENTS` — 서브모드와 파라미터:

| Mode | 호출 예시 | 기능 |
|------|----------|------|
| `status` | `/관제` (기본값) | 통합 현황 대시보드 |
| `ingest` | `/관제 ingest 20250310` | 회의록 파싱 → 백로그 등록 |
| `sync` | `/관제 sync` | Todoist 양방향 동기화 |
| `triage` | `/관제 triage` | P0/P1 항목 분류 → Phase 편입 판단 |
| `add` | `/관제 add "QA 진행" P1 나` | 수동 백로그 추가 |
| `note` | `/관제 note BL-047 "L40s 할당 완료"` | 진행 상황 메모 (Todoist 댓글) |
| `prep` | `/관제 prep` | 주간 회의자료 안건 조회 및 관리 |

`$ARGUMENTS`가 비어있거나 인식 불가 시 `status` 모드로 동작한다.

## Key Files

| 파일 | 용도 |
|------|------|
| `docs/backlog.md` | 백로그 (단일 진실 원천) |
| `docs/backlog-sync.json` | 동기화 상태 메타데이터 (gitignored) |
| `docs/meeting-prep.md` | 주간 회의자료 안건 누적 |
| `PROGRESS.md` | Phase 기반 진행 상황 |
| `{{meeting_notes_path}}` | 회의록 원본 |
| `{{obsidian_mirror_path}}` | Obsidian 미러 |

## Backlog Data Model

> 개별 태스크에 상세 실행 기록이 필요하면 [[08_Task Item]] 템플릿으로 별도 노트를 생성한다.

`docs/backlog.md` 테이블 필드:

| 필드 | 설명 |
|------|------|
| ID | `BL-NNN` — 자동 할당, `docs/backlog-sync.json`의 `id_counter`로 관리 |
| Title | 항목 제목 |
| Source | 회의록 파일명 또는 `manual` 또는 `todoist` |
| Owner | 담당자 또는 조직 |
| Priority | `P0`(즉시), `P1`(긴급), `P2`(일반), `P3`(언젠가) |
| Status | `open`, `in-progress`, `blocked`, `done` |
| Todoist | Todoist task ID (미동기화 시 `-`) |
| Created | 생성일 (YYYY-MM-DD) |
| Due | 마감일 (없으면 `-`) |

---

## Todoist Conventions

### 섹션 (= 워크플로우 단계)

| 섹션 | 의미 | backlog Status 매핑 |
|------|------|---------------------|
| Active | 지금 내가 직접 수행 중 | `in-progress` |
| Waiting | 타인에게 요청 후 대기 중 | `blocked` |
| Recurring | 반복 업무 | `open` |
| Backlog | 언젠가 할 일 | `open` |
| Inbox | 미분류 (트리아지 전) | `open` |
| Archive | 보류/참고용 | `done` |

### 우선순위 매핑

| Backlog | Todoist API | Todoist UI |
|---------|-------------|------------|
| P0 | priority: 4 | 🔴 p1 |
| P1 | priority: 3 | 🟠 p2 |
| P2 | priority: 2 | 🔵 p3 |
| P3 | priority: 1 | ⚪ p4 |

### 라벨 (이중 체계)

- **Type 라벨** (뭘 하는가): 프로젝트에 맞게 정의. 예: 기획/전략, 디자인, 개발/기술, 콘텐츠제작, 커뮤니케이션
- **Domain 라벨** (무엇에 대한 건가): `#` 접두사. 예: `#인프라`, `#프론트`, `#백엔드`, `#보안`

### 태스크 필드 규칙

- **타이틀(content)**: 깔끔하게 (BL ID 넣지 않음)
- **설명(description)**: `BL-NNN` ID 기록 (backlog.md 연결 키)
- **댓글(comment)**: 맥락, 배경, 진행 메모 등 부가 정보. `[YYYY-MM-DD]` 타임스탬프 접두사로 이력 추적. `/관제 note`로 추가.
- **부모-자식**: 순수 태스크 분해 전용 (토픽 그루핑은 라벨로 처리)

### 섹션 판단 기준

- 섹션은 **워크플로우 상태**이지 우선순위가 아님
- "확인" = 담당자에게 확인 요청 → **Waiting** (PM이 직접 수행하는 것 아님)

---

## Mode: status

**조건**: `$ARGUMENTS`가 비어있거나 `status`일 때.

### Phase 1: 데이터 수집
1. `PROGRESS.md`를 읽어 활성 Phase를 파싱한다.
   - Phase별: 진행(🔄) / 완료(✅) / 남은 TODO(⬜) / 블로커(❌) 수 집계.
2. `docs/backlog.md`를 읽어 Priority별 open/in-progress/blocked 항목 수 집계.
3. 미결 사항 문서가 있으면 미해결 체크박스 항목(`- [ ]`) 추출.

### Phase 2: 대시보드 출력

```
# {{project}} 관제 현황 — {오늘 날짜}

## Active Phases
| Phase | 진행 | 완료 | TODO | 블로커 | 다음 작업 |

## Blockers & 미결
- [ ] {미결 항목}

## Backlog 요약
| Priority | Open | In Progress | Blocked |

## Follow-ups (대기 중)
- {Status=blocked 또는 Owner가 타인인 항목}
```

---

## Mode: ingest

**조건**: `$ARGUMENTS`가 `ingest`로 시작할 때.

### Phase 1: 회의록 찾기
1. `ingest` 뒤에 날짜가 있으면 (YYYYMMDD): 해당 회의록 파일을 읽는다.
2. 날짜가 없으면: `last_meeting_ingested`보다 최신인 회의록을 찾는다.
3. 파일이 없으면 사용자에게 알린다.

### Phase 2: 액션 아이템 추출
회의록에서 다음 순서로 추출:
1. **미결 사항 테이블** — `⚠️ 미결` 또는 `⚠️ 논의 필요` 항목
2. **상태 요약 테이블** — `🔄 진행중/예정` 중 PROGRESS.md에 없는 것
3. **인라인 키워드** — `~날짜`, `예정/필요/검토 중`, `⚠️`, `개선 방향:/대응방안:/임시 조치:`

각 항목에 Title, Source, Owner, 추천 Priority 할당:
- P0: 1주 내 마감 또는 blocking
- P1: 명시적 마감일 또는 미결 사항
- P2: 진행중/예정
- P3: 장기/언젠가

### Phase 3: 중복 체크
기존 backlog.md 및 PROGRESS.md와 비교. 유사 항목에 "(중복 가능)" 표시.

### Phase 4: 사용자 확인 및 등록
1. 추출 항목을 테이블로 출력, 사용자 확인 요청.
2. 확인된 항목을 backlog.md에 추가 (BL-NNN ID 할당).
3. `last_meeting_ingested` 업데이트.
4. Obsidian 미러 업데이트.

---

## Mode: sync

**조건**: `$ARGUMENTS`가 `sync`일 때.

### Phase 1: Todoist MCP 준비
1. `ToolSearch`로 Todoist MCP 도구를 로드한다.
2. `docs/backlog-sync.json`을 읽는다.

### Phase 2: 프로젝트 확인/생성
1. Todoist에서 `todoist_project_id` 프로젝트를 확인한다.
2. 없으면 새로 생성하고 ID를 `backlog-sync.json`에 저장한다.

### Phase 3: Push (backlog → Todoist)
1. backlog.md에서 Todoist 컬럼이 `-`이고 **Owner가 본인**인 open/in-progress 항목을 찾는다.
   - Owner가 타인인 항목은 백로그에서 추적용으로 유지하되, Todoist에는 push하지 않는다.
2. 각 항목에 대해 Todoist 태스크를 생성한다:
   - 이름(content): `{Title}` (BL ID 넣지 않음)
   - 설명(description): `BL-NNN`
   - 부가 정보: 댓글(comment)로 기록
   - 우선순위: P0→priority 4, P1→priority 3, P2→priority 2, P3→priority 1
   - 마감일: Due 필드가 `-`가 아니면 설정
   - 섹션: Status 기반 — `in-progress`→Active, `blocked`→Waiting, `open`→Backlog
3. 생성된 task ID를 backlog.md Todoist 컬럼에 기록.

### Phase 4: Pull (Todoist → backlog)
1. 완료된 태스크를 조회한다 (`get_completed_tasks` — `since`: 마지막 sync 또는 3개월 전).
2. description의 `BL-NNN`으로 백로그 항목을 매칭한다.
3. 매칭된 항목의 Status를 `done`으로 변경, Archive로 이동.
4. description에 `BL-` 접두사가 없는 태스크는 새 BL ID를 할당하여 추가.

### Phase 5: 마무리
1. `last_todoist_sync` 업데이트.
2. Obsidian 미러 업데이트.
3. 동기화 결과 요약 출력.

---

## Mode: triage

**조건**: `$ARGUMENTS`가 `triage`일 때.

### Phase 1: 분류 대상 추출
P0/P1 open 항목, Due 초과 항목, blocked 항목.

### Phase 2: 인터랙티브 분류
| 액션 | 설명 | 결과 |
|------|------|------|
| **Promote** | Phase에 편입 | PROGRESS.md에 TODO 추가, Status → `in-progress` |
| **Keep** | 백로그에 유지 | 변경 없음 (우선순위 조정 가능) |
| **Defer** | 나중으로 | Priority → P3 |
| **Close** | 종료 | Status → `done`, Archive 이동 |

### Phase 3: 변경 반영
backlog.md, PROGRESS.md, backlog-sync.json, Obsidian 미러 업데이트.

---

## Mode: add

**조건**: `$ARGUMENTS`가 `add`로 시작할 때, 또는 대화 중 "이거 태스크로 추가해" 같은 요청.

### Phase 1: 입력 파싱
1. **구조화**: `add "제목" P[0-3] 담당자` → 직접 파싱.
2. **자연어**: 대화 맥락에서 Title, Priority(기본 P2), Owner 추론 → 사용자 확인.

### Phase 2: 백로그 등록
1. `id_counter` +1 → 새 BL-NNN ID.
2. backlog.md에 새 행 추가 (Source: `manual`, Status: `open`).
3. backlog-sync.json 저장.
4. Obsidian 미러 업데이트.

### Phase 3: Todoist 즉시 동기화 (선택)
- `todoist_project_id`가 설정되어 있으면:
  - Todoist 태스크 생성 (타이틀에 BL ID 넣지 않음, description에 `BL-NNN`)
  - 부가 설명은 댓글(comment)로 기록
  - Status 기반으로 적절한 섹션에 배치
  - task ID를 backlog.md에 기록
- 미설정이면 다음 `/관제 sync` 시 push.

---

## Setup Checklist

새 프로젝트에 적용할 때:

1. **이 파일을 복사** → `.claude/commands/mission-control.md`
2. **`{{변수}}` 치환**:
   - `{{project}}` → 프로젝트명
   - `{{meeting_notes_path}}` → 회의록 경로
   - `{{obsidian_mirror_path}}` → Obsidian 백로그 미러 경로
3. **초기 파일 생성**:
   ```
   docs/backlog.md          ← 빈 테이블 (아래 참조)
   docs/backlog-sync.json   ← 초기 상태 (아래 참조)
   ```
4. **.gitignore에 추가**: `docs/backlog-sync.json`
5. **Todoist 프로젝트 생성** 후 `/관제 sync`로 초기 동기화
6. **Domain 라벨 정의**: 프로젝트에 맞는 `#도메인` 라벨 설계

### backlog.md 초기 템플릿

```markdown
---
type: backlog
title: {{project}} Backlog
updated: {{date}}
---

# {{project}} Backlog

| ID | Title | Source | Owner | Priority | Status | Todoist | Created | Due |
|----|-------|--------|-------|----------|--------|---------|---------|-----|

## Archive

| ID | Title | Completed | Source |
|----|-------|-----------|--------|
```

### backlog-sync.json 초기 상태

```json
{
  "last_meeting_ingested": "",
  "last_todoist_sync": "",
  "todoist_project_id": "",
  "id_counter": 0,
  "sections": {}
}
```

---

## Mode: prep

**조건**: `$ARGUMENTS`가 `prep`일 때.

### Key File

`docs/meeting-prep.md` — 주간 회의자료 안건 누적 파일.

```markdown
## 다음 회의 (YYYY-MM-DD)
- [ ] **안건 제목**: 설명. (BL-NNN, 출처: 회의록명)

## Archive
| 사용일 | 항목 | 출처 |
```

### Phase 1: 안건 조회
1. `docs/meeting-prep.md`를 읽는다.
2. "다음 회의" 섹션에서 미완료 체크리스트(`- [ ]`)를 추출한다.
3. 항목이 없으면 "등록된 안건이 없습니다" 출력 후 종료.

### Phase 2: 대시보드 출력
```
# 회의자료 안건 — 다음 회의 YYYY-MM-DD

| # | 안건 | 관련 BL | 출처 |
|---|------|---------|------|

총 N건. 추가/제거/완료 처리할 항목이 있으면 알려주세요.
```

### Phase 3: 인터랙티브 관리
| 액션 | 설명 | 결과 |
|------|------|------|
| **추가** | 새 안건 등록 | meeting-prep.md에 체크리스트 항목 추가 |
| **완료** | 회의에서 사용함 | `- [x]`로 체크 → Archive 테이블로 이동 (사용일 기록) |
| **제거** | 불필요 | 항목 삭제 |
| **이월** | 다음 주로 넘김 | 회의 날짜만 업데이트 |

### Ingest 연계
`/관제 ingest` 과정에서 사용자가 "이거 회의자료에 써야 해" 또는 유사 요청을 하면:
1. 해당 항목을 backlog.md에 등록하고
2. 동시에 `docs/meeting-prep.md`에 체크리스트 항목을 추가한다.
   - 형식: `- [ ] **{Title}**: {요약}. (BL-NNN, 출처: {회의록명})`

### meeting-prep.md 초기 템플릿

```markdown
---
type: meeting-prep
title: Weekly Meeting Prep Notes
updated: {{date}}
---

# 주간 회의자료 메모

## 다음 회의 (YYYY-MM-DD)

## Archive

| 사용일 | 항목 | 출처 |
|--------|------|------|
```

---

## Mode: note

**조건**: `$ARGUMENTS`가 `note`로 시작할 때, 또는 관제 대화 중 진행 상황 업데이트 요청.

### Phase 1: 대상 매칭
1. **구조화된 입력**: `note BL-NNN "메모 내용"` → BL ID로 직접 매칭.
2. **자연어 입력**: 키워드로 backlog.md 항목을 퍼지 매칭한다.
   - 매칭 후보가 여러 개면 사용자에게 선택을 요청한다.
   - 매칭 후보가 없으면 BL ID를 요청한다.
3. 매칭된 항목의 Todoist task ID를 확인한다.
   - Todoist ID가 `-`이면: "이 항목은 아직 Todoist에 동기화되지 않았습니다. `/관제 sync` 후 다시 시도하세요." 출력.

### Phase 2: 댓글 작성
1. 사용자의 메모 내용을 정리한다:
   - 자연어 입력이면 핵심 내용을 간결하게 요약한다.
   - 구조화된 입력이면 그대로 사용한다.
2. Todoist에 댓글을 추가한다:
   - 형식: `[YYYY-MM-DD] {메모 내용}`
   - 도구: `add-comments` (taskId: 매칭된 Todoist ID)

### Phase 3: 확인
작성된 댓글 내용을 출력한다:
```
BL-NNN {Title} — 댓글 추가 완료:
[2026-04-09] {메모 내용}
```

### 대화 흐름에서의 자동 감지
관제 모드 대화 중 다음 패턴이 감지되면 `note` 모드를 자동으로 제안한다:
- "~쪽에 업데이트가 있는데"
- "~는 진행해서", "~했어", "~했는데"
- "댓글로 남겨줘", "업데이트 해줘"
- 기존 백로그 항목에 대한 진행 상황 서술

---

## Notes

### 인풋 소스
- 회의록 (`ingest`)
- 긴급 요청 / 본인 아이디어 (`add`)
- 대화 중 도출 (대화 흐름에서 `add` 호출)
- 진행 상황 업데이트 (`note`로 Todoist 댓글 추가)
- Todoist 앱 직접 입력 (`sync`로 pull)

### Obsidian 미러링
backlog.md 변경 시 항상 미러 경로에 동일 내용 복사.

### 언어
- 대시보드 출력 및 사용자 대화: 한국어
- backlog.md 필드명 (ID, Title 등): 영어 (테이블 파싱 일관성)
