---
name: pm-planning-workflow
description: "Use this skill for PM planning workflows including feature briefs, UX planning, and backlog management. Triggers on: 'pm planning', 'feature brief', 'ux planning', 'product planning', 'PM 플래닝', '기능 기획'."
---


# PM Planning Workflow: {{title}}

> 목적: 새로운 기능 추가 또는 화면 변경 시, 구조화된 기획 논의 → 기술문서 → 반영까지의 워크플로우를 프로젝트에 세팅한다.

Reference:
- [[00_Project Skill Kickoff]]
- [[02_Custom Local Skill Draft]]

## 1. Project Context
- Project / workstream:
- Design tool: (예: Figma, Sketch, Zeplin)
- Design file ID or link:
- MCP servers in use:
- Key screen nodes or pages:

## 2. Planning Pipeline

```
기획: /기획 (plan-feature) → /문서 (write-spec) → /반영 (update-figma-doc)
      기획 논의 & Brief       기술문서 생성          디자인 파일 반영

관제: /관제 status → /관제 ingest → /관제 triage → /관제 sync
      현황 대시보드    회의록 파싱     P0/P1 분류     Todoist 동기화
```

### 파이프라인 적용 범위
- 기획 스킬 사용: (예: 새 기능 추가, 기존 화면 변경, UX 흐름 재설계)
- 기획 스킬 불필요: (예: 오타 수정, 단순 텍스트 변경, 스타일 조정)
- 관제 스킬 사용: 백로그 관리, 회의록 액션아이템 추출, Todoist 동기화, 진행 상황 대시보드

## 3. Skill Definition — /plan-feature (/기획)

### 3-1. Trigger
- 새로운 기능 추가를 논의할 때
- 기존 화면에 변경이 필요할 때
- UX 흐름을 재설계할 때
- 사이드이펙트/영향도 분석이 필요할 때

### 3-2. Input
- 자유 형식 설명 (필수)
- 관련 화면 노드 ID 또는 링크 (선택)
- 참조할 섹션/페이지 번호 (선택)

### 3-3. Process — 3 Phase

#### Phase 1: 컨텍스트 파악
- 현재 화면 스크린샷/캡처로 상태 파악
- 관련 화면 탐색 및 현재 동작 요약
- → 사용자 확인: "현재 파악이 맞는지, 빠진 화면이 있는지"

#### Phase 2: 기획 논의 (구조화된 질문 흐름)

**문제 정의**
- 왜 이 기능이 필요한가
- 현재 뭐가 부족하거나 불편한가

**요구사항 구조화**
- 기능 요구사항(FR) 번호 부여하여 정리
  ```
  - FR-1: ...
  - FR-2: ...
  ```

**UX 흐름 설계**
- 진입점 → 인터랙션 → 분기 → 완료/에러
- Action 표기: `{Click}`, `{Input}`, `{Hover}`, `{Scroll}`, `{Read-only}` 등
- 대안 흐름 2개 이상 비교 후 최적안 선택
  ```
  [흐름 A] — 모달 방식
  1. 사용자가 [화면A]에서 [버튼] {Click}
  2. [모달]이 표시됨
  ...

  [흐름 B] — 페이지 이동 방식
  1. 사용자가 [화면A]에서 [버튼] {Click}
  2. [화면B]로 이동
  ...

  → 권장: 흐름 A (사유: ...)
  ```

**영향도 분석**
- 기존 화면 변경사항
- 새 화면/모달 필요 여부
- 사이드이펙트 (다른 기능에 미치는 영향)
- 법적 리스크 (해당 시 — 법령 MCP 등으로 검토)
- **가장 큰 리스크** 1개 식별
- 엣지 케이스 (빈 상태, 에러, 권한 등)

→ 사용자와 다중 라운드 논의 후 합의

#### Phase 3: Feature Brief 산출물

> 산출물 형식은 [[03-1_Feature Brief]] 템플릿을 사용한다.
> 배경/목적, 요구사항(FR-N), UX 흐름, 영향도, 화면 목록, 미결 사항, 다음 단계로 구성.

### 3-4. Design Framework References
- Lean UX Canvas v2 (Jeff Gothelf) — 순서대로 박스 채우기, 가장 위험한 가정 식별
- deanpeters/Product-Manager-Skills — problem-statement, feature-investment-advisor
- phuryn/pm-skills — opportunity-solution-tree, analyze-feature-requests
- 위 프레임워크를 그대로 도입하지 않고, **패턴만 차용**하여 경량화

## 4. Skill Definition — /write-spec (/문서)

### Trigger
- Feature Brief 확정 후, 각 화면의 기술문서를 생성할 때
- 디자인 화면 스크린샷을 보고 인터랙션/설명 문서를 만들 때

### Process
1. 대상 화면 스크린샷 캡처
2. 모든 인터랙티브/읽기 전용 요소 식별
3. User Interaction 생성 (`요소명 {Action}` 형식)
4. Description 생성 (한국어 간결체, 키워드 강조)
5. 사용자 검토 후 확정

### Output Format (프로젝트별 커스터마이즈)
```
## User Interaction
- 요소1 {Action}
- 요소2 {Action}

## Description
- 기능 설명 (**핵심 키워드** 강조)
  - 세부사항
```

## 5. Skill Definition — /update-figma-doc (/반영)

### Trigger
- 기술문서가 확정되어 디자인 파일에 반영할 때

### Process
1. 디자인 플러그인 채널 연결
2. 대상 노드 폰트/스타일 사전 확인
3. 텍스트 노드 업데이트
4. 스크린샷으로 반영 결과 검증

### Project-Specific Config (프로젝트별 설정)
- 대상 노드 ID 매핑: (프로젝트마다 다름)
- 폰트 설정: (예: Pretendard Regular/Bold)
- 에러 핸들링 규칙: (예: 혼합 폰트 → Regular 통일 후 재시도)

## 5-1. Skill Definition — /mission-control (/관제)

> 전체 스펙은 [[08_Mission Control Skill]] 을 참조한다. 아래는 요약.
> 프로젝트 적용 시 해당 템플릿을 `.claude/commands/mission-control.md`로 복사하고 `{{변수}}`를 치환한다.

| Mode | 기능 |
|------|------|
| `status` | 통합 현황 대시보드 |
| `ingest` | 회의록 → 백로그 등록 |
| `sync` | Todoist 양방향 동기화 |
| `triage` | P0/P1 분류 → Phase 편입 |
| `add` | 수동 백로그 추가 |

## 6. Command Setup Checklist

프로젝트에 이 워크플로우를 세팅할 때 아래를 순서대로 진행:

### 기획 파이프라인
| # | Task | Check |
|---|------|-------|
| 1 | `.claude/commands/plan-feature.md` 생성 (Phase 1~3 프로세스 정의) | ⬜ |
| 2 | `.claude/commands/write-spec.md` 생성 (기술문서 형식 정의) | ⬜ |
| 3 | `.claude/commands/update-figma-doc.md` 생성 (대상 노드 매핑 정의) | ⬜ |
| 4 | 한글 alias 생성 (`기획.md`, `문서.md`, `반영.md`) — 선택사항 | ⬜ |
| 5 | 기획 → 문서 → 반영 연계 테스트 1회 실행 | ⬜ |

### 관제 파이프라인
| # | Task | Check |
|---|------|-------|
| 6 | `.claude/commands/mission-control.md` 생성 (status/ingest/sync/triage/add 모드 정의) | ⬜ |
| 7 | 한글 alias 생성 (`관제.md`) — 선택사항 | ⬜ |
| 8 | `docs/backlog.md` 초기 테이블 생성 | ⬜ |
| 9 | `docs/backlog-sync.json` 초기화 (`id_counter`, `todoist_project_id` 등) | ⬜ |
| 10 | Todoist MCP 연결 — `.mcp.json`에 추가 후 OAuth 인증 (Section 7-1 참조) | ⬜ |
| 11 | Todoist 프로젝트 생성 및 섹션 구성 (Active/Waiting/Recurring/Backlog/Inbox) | ⬜ |
| 12 | `/관제 sync` 테스트 1회 실행 | ⬜ |

### 공통
| # | Task | Check |
|---|------|-------|
| 13 | `.mcp.json`에 필요한 MCP 서버 추가 | ⬜ |
| 14 | `CLAUDE.md`에 워크플로우, 스킬 목록, MCP 서버 반영 | ⬜ |
| 15 | `PROGRESS.md`에 Phase 트래킹 추가 | ⬜ |

## 7. MCP Servers

### 7-1. Todoist MCP 설정

Todoist 공식 MCP는 `mcp-remote`를 통한 OAuth 인증 방식을 사용한다.

**설정 방법:**
1. `.mcp.json`에 추가:
   ```json
   "todoist": {
     "command": "npx",
     "args": ["-y", "mcp-remote", "https://ai.todoist.net/mcp"]
   }
   ```
2. Claude Code 재시작 → Todoist 도구 최초 호출 시 브라우저에서 OAuth 인증 진행
3. 인증 완료 후 자동으로 토큰이 캐시됨 (환경변수 설정 불필요)

> **주의**: 이전 방식(`todoist-mcp` 패키지 + `TODOIST_API_TOKEN` 환경변수)은 더 이상 사용하지 않는다.

### 7-2. 전체 MCP 서버 목록

| 서버 | 용도 | 필수 여부 |
|------|------|----------|
| Figma 공식 MCP | 디자인 파일 읽기 (스크린샷, 메타데이터) | 기획 파이프라인 필수 |
| ClaudeTalkToFigma | 디자인 파일 쓰기 (텍스트 노드 업데이트) | 반영 스킬 사용 시 필수 |
| Todoist MCP | 백로그 ↔ Todoist 양방향 동기화 | 관제 sync 사용 시 필수 |
| Korean Law MCP | 기획 시 법령/규제 검토 | 선택 (법적 리스크 검토 필요 시) |
| kordoc | HWP/HWPX/PDF → 마크다운 변환 | 선택 (공문서 파싱 필요 시) |
| 기타 도메인 MCP | 프로젝트별 도메인 검증 | 선택 |

## 8. Conventions
- Commit messages: English, `<type>: <short summary>`
- Code comments: English
- Documentation / spec content: Korean (프로젝트 언어에 따라 변경)
- AI commits: `Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>`
- Feature Brief는 대화 내 출력, 필요 시 파일 저장
- 기획 스킬은 디자인 파일 읽기 전용, 쓰기는 반영 스킬에서만

## 9. Prompt To Paste
```text
Use this note as the PM Planning workflow template for the project.

Instructions:
- Set up 2 pipelines:
  1. Planning: /plan-feature → /write-spec → /update-figma-doc
  2. Mission Control: /mission-control (status/ingest/sync/triage/add)

- /plan-feature: 3 phases (context → discussion → Feature Brief)
  - Phase 2 uses structured question flow: problem → requirements → UX flow (2+ alternatives) → impact analysis
  - Identify the single biggest risk in impact analysis
  - Legal review via MCP if applicable
- /write-spec: Adapt output format to the project's tech doc standard
- /update-figma-doc: Map target node IDs and configure font/error handling
- /mission-control: Configure backlog.md, backlog-sync.json, Todoist MCP (mcp-remote OAuth), meeting note paths, and Obsidian mirror path
- Todoist MCP: Use `npx -y mcp-remote https://ai.todoist.net/mcp` (OAuth, no API token env var needed)
- Create Korean aliases if the team prefers Korean commands
- Run one end-to-end test for each pipeline before marking setup complete

Keep skills lightweight. Prefer simple patterns over heavy frameworks.
```

## 10. Decision Log

> 프로젝트 수준의 중요 결정은 [[07_Decision Log]] 정본에도 등록한다.

| Decision | Why | Date | Notes |
|---|---|---|---|
|  |  |  |  |
