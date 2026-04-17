# Claude Code Commands

Claude Code에서 사용하는 개인 **슬래시 커맨드** 및 **프로젝트 템플릿** 모음입니다.

> **네이밍 규칙**: `/{카테고리}-{서브카테고리}-{스킬_이름}` 형식 (flat)
> - 카테고리 구분: `-`
> - 스킬 이름 내 단어 구분: `_`
>
> 예) `/work-git-start`, `/work-ai-project_skill_kickoff`, `/daily-morning_briefing`

---

## 목차

- [커맨드 목록](#커맨드-목록)
- [템플릿](#템플릿)
- [설치하기](#설치하기-전역--모든-프로젝트에-적용)
- [새 커맨드 만들기](#새-커맨드-만들기)
- [폴더 구조](#폴더-구조)

---

## 커맨드 목록

커맨드는 용도에 따라 **업무용 / 일상용 / 기타 / 인테이크 / 리서치** 로 구분됩니다.

---

## 💼 업무용 (`/work-*`)

### 🔀 Git (`/work-git-*`)
| 커맨드 | 설명 |
|------|------|
| [`/work-git-start`](./.claude/commands/work-git-start.md) | 작업 전 레포 준비 및 브랜치 생성 |
| [`/work-git-finish`](./.claude/commands/work-git-finish.md) | 작업 후 커밋·푸시 및 GitHub Issue 등록 |
| [`/work-git-diff_summary`](./.claude/commands/work-git-diff_summary.md) | 이전 커밋과 현재 코드의 변경사항 요약 |
| [`/work-git-commit_message`](./.claude/commands/work-git-commit_message.md) | 변경사항 분석 후 Conventional Commits 메시지 생성 |
| [`/work-git-pr_creator`](./.claude/commands/work-git-pr_creator.md) | 변경사항 기반 PR 본문 자동 작성 및 생성 |
| [`/work-git-changelog`](./.claude/commands/work-git-changelog.md) | git 히스토리에서 버전별 CHANGELOG 생성 |
| [`/work-git-conflict_resolver`](./.claude/commands/work-git-conflict_resolver.md) | Merge/Rebase 충돌 분석 및 해결 제안 |

### 🖥️ Coding (`/work-coding-*`)
| 커맨드 | 설명 |
|------|------|
| [`/work-coding-code_review`](./.claude/commands/work-coding-code_review.md) | 코드 품질·보안·성능·가독성 체계적 리뷰 |
| [`/work-coding-refactor_guide`](./.claude/commands/work-coding-refactor_guide.md) | 코드 스멜 탐지 및 리팩토링 제안 |
| [`/work-coding-debug_guide`](./.claude/commands/work-coding-debug_guide.md) | 에러·스택 트레이스 분석 및 수정 (JS/Python/Go/Java) |
| [`/work-coding-security_audit`](./.claude/commands/work-coding-security_audit.md) | OWASP 기준 보안 취약점 탐지 |
| [`/work-coding-dependency_audit`](./.claude/commands/work-coding-dependency_audit.md) | 취약하거나 오래된 패키지 탐지 및 업데이트 |
| [`/work-coding-project_review`](./.claude/commands/work-coding-project_review.md) | 프로젝트 전체 종합 리뷰 — 구조·DB·보안·함수·TODO·버그를 README로 생성 |
| [`/work-coding-web_scaffold`](./.claude/commands/work-coding-web_scaffold.md) | 제목·역할·기능 입력 → Flask+JS 웹 프로젝트 자동 생성 |

### 📄 Docs (`/work-docs-*`)
| 커맨드 | 설명 |
|------|------|
| [`/work-docs-api_docs`](./.claude/commands/work-docs-api_docs.md) | 소스 코드 기반 API 문서 자동 생성 |
| [`/work-docs-code_explain`](./.claude/commands/work-docs-code_explain.md) | 복잡한 코드를 쉽게 설명 (온보딩용) |
| [`/work-docs-readme_generator`](./.claude/commands/work-docs-readme_generator.md) | 프로젝트 분석 후 README.md 자동 생성 |

### 🐳 DevOps (`/work-devops-*`)
| 커맨드 | 설명 |
|------|------|
| [`/work-devops-dockerfile`](./.claude/commands/work-devops-dockerfile.md) | Dockerfile 생성 및 베스트 프랙티스 기반 리뷰 |

### 🧪 Testing (`/work-testing-*`)
| 커맨드 | 설명 |
|------|------|
| [`/work-testing-test_generator`](./.claude/commands/work-testing-test_generator.md) | 함수/모듈에 대한 단위 테스트 자동 생성 |

### 🤖 AI / PM (`/work-ai-*`)
프로젝트에 AI를 세팅·평가·운영하기 위한 PM 워크플로우 커맨드입니다.

| 커맨드 | 설명 |
|------|------|
| [`/work-ai-project_skill_kickoff`](./.claude/commands/work-ai-project_skill_kickoff.md) | 새 프로젝트 시작 시 AI 스킬 컨텍스트 세팅 |
| [`/work-ai-project_archetype_selector`](./.claude/commands/work-ai-project_archetype_selector.md) | 프로젝트 아키타입 분류 & 최적 스킬 추천 |
| [`/work-ai-skill_evaluation`](./.claude/commands/work-ai-skill_evaluation.md) | 외부 스킬 도입 전 신뢰성·적합성 평가 |
| [`/work-ai-custom_local_skill_draft`](./.claude/commands/work-ai-custom_local_skill_draft.md) | 프로젝트 전용 커스텀 로컬 스킬 초안 작성 |
| [`/work-ai-project_git_workflow`](./.claude/commands/work-ai-project_git_workflow.md) | 프로젝트 Git 워크플로우 정의·문서화 |
| [`/work-ai-project_code_quality_security`](./.claude/commands/work-ai-project_code_quality_security.md) | 코드 품질 & 보안 기준 설정 |
| [`/work-ai-project_orchestrator_session_start`](./.claude/commands/work-ai-project_orchestrator_session_start.md) | 오케스트레이터 세션 시작 & 컨텍스트 로딩 |
| [`/work-ai-pm_planning_workflow`](./.claude/commands/work-ai-pm_planning_workflow.md) | PM 기획 워크플로우 (기능 브리프, UX, 백로그) |
| [`/work-ai-mission_control`](./.claude/commands/work-ai-mission_control.md) | 프로젝트 관제 센터 (태스크, 백로그, 대시보드) |

### 📤 Reporting (`/work-reporting-*`)
| 커맨드 | 설명 |
|------|------|
| [`/work-reporting-daily_report`](./.claude/commands/work-reporting-daily_report.md) | GitHub Issues 분류·요약 후 Slack 채널에 데일리 리포트 업로드 |

---

## 🌅 일상용 (`/daily-*`)

| 커맨드 | 설명 |
|------|------|
| [`/daily-morning_briefing`](./.claude/commands/daily-morning_briefing.md) | 아침 브리핑 — Google 캘린더·Tasks·뉴스·Gmail 통합 요약 |

---

## 🧰 기타 (`/misc-*`)

### 🗂 Navigation (`/misc-navigation-*`)
커맨드가 너무 많을 때 카테고리별로 묶어서 보여주는 라우터입니다.

| 커맨드 | 설명 |
|------|------|
| [`/misc-navigation-menu`](./.claude/commands/misc-navigation-menu.md) | 전체 커맨드 카테고리 통합 메뉴 |
| [`/misc-navigation-ai_menu`](./.claude/commands/misc-navigation-ai_menu.md) | AI 커맨드 카테고리 서브메뉴 |
| [`/misc-navigation-git_menu`](./.claude/commands/misc-navigation-git_menu.md) | Git 커맨드 카테고리 서브메뉴 |
| [`/misc-navigation-coding_menu`](./.claude/commands/misc-navigation-coding_menu.md) | Coding 커맨드 카테고리 서브메뉴 |
| [`/misc-navigation-docs_menu`](./.claude/commands/misc-navigation-docs_menu.md) | Documentation 커맨드 카테고리 서브메뉴 |
| [`/misc-navigation-devops_menu`](./.claude/commands/misc-navigation-devops_menu.md) | DevOps 커맨드 카테고리 서브메뉴 |

---

## 📥 Intake (`/intake/*`)

콘텐츠를 비판적으로 검증한 뒤 구조화된 knowledge 노트로 저장하는 인테이크 워크플로우입니다. (서브디렉터리 기반 커맨드이므로 표시는 `/intake:article` 같은 콜론 형식으로 뜹니다.)

| 커맨드 | 설명 |
|--------|------|
| [`/intake/article`](./.claude/commands/intake/article.md) | 기사·블로그·X 스레드를 4단계 비판적 검증 후 knowledge 노트로 저장 |
| [`/intake/book`](./.claude/commands/intake/book.md) | 책 내용 정리 — 4단계 검증 + 저자 프레임워크 추출 + 내 상황 적용 |
| [`/intake/pdf`](./.claude/commands/intake/pdf.md) | inbox-pdf/ 폴더의 PDF를 읽고 4단계 검증 후 knowledge 노트로 저장 |
| [`/intake/youtube`](./.claude/commands/intake/youtube.md) | 유튜브 영상 자막 추출 후 [2차요약] 태그와 함께 검증 |
| [`/intake/verify`](./.claude/commands/intake/verify.md) | 특정 주장이나 기존 노트에 대해 4단계 비판적 검증을 단독 실행 |

## 🔍 Research (`/research/*`)

| 커맨드 | 설명 |
|--------|------|
| [`/research/web`](./.claude/commands/research/web.md) | 웹 검색 기반 리서치 — 복수 소스 교차 검증 + 확신도 표기 |

---

## 템플릿

`_template/` 에 위치한 프로젝트·노트 템플릿입니다.

### 📝 노트 템플릿 (`_template/notes/`)

Obsidian Brain Vault용 노트 템플릿입니다. [상세 안내](./_template/notes/README.md)

| # | 템플릿 | 설명 |
|---|--------|------|
| 00 | [Knowledge Note](./_template/notes/00_Knowledge%20Note.md) | 검증된 지식 구조화 저장 (출처·검증 상태·반대 시나리오 포함) |
| 01 | [Scrap](./_template/notes/01_Scrap.md) | 빠른 캡처용 스크랩 — 원문 발췌 후 추후 triage |
| 02 | [Daily Log](./_template/notes/02_Daily%20Log.md) | 일일 로그 — 계획·캡처·결정·성과·미결 사항 |
| 03 | [Taste Note](./_template/notes/03_Taste%20Note.md) | 콘텐츠 감상 기록 (영화, 책, 음악 등) |
| 04 | [Idea](./_template/notes/04_Idea.md) | 아이디어 시드 — 문제·인사이트·솔루션 방향 구조화 |
| 05 | [Topic](./_template/notes/05_Topic.md) | 관심 주제 추적 — 핵심 질문과 현재 가설(thesis) 정리 |

### 📋 프로젝트 팩 템플릿 (`_template/project-pack/`)

프로젝트 PM 라이프사이클 전체를 커버하는 문서 템플릿입니다. [상세 안내](./_template/project-pack/README.md)

| # | 템플릿 | 설명 |
|---|--------|------|
| 00 | [Project Context](./_template/project-pack/00_Project%20Context.md) | 프로젝트 요약·목표·현재 단계·제약사항 정의 |
| 01 | [Working Agreement](./_template/project-pack/01_Working%20Agreement.md) | AI-사람 간 응답 계약·읽기 순서·승격 규칙 |
| 02 | [Requirement Intake](./_template/project-pack/02_Requirement%20Intake.md) | 요구사항 구조화 — 문제·기대 결과·범위 정리 |
| 03 | [PRD](./_template/project-pack/03_PRD.md) | 제품 요구사항 문서 — 기능 전체의 수락 기준 정의 |
| 03-1 | [Feature Brief](./_template/project-pack/03-1_Feature%20Brief.md) | UX 중심 개별 기능 기획서 — 배경·화면 컨텍스트·요구사항 |
| 04 | [Scope Options](./_template/project-pack/04_Scope%20Options.md) | Minimum / Standard / Stretch 3단계 범위 옵션 |
| 05 | [Prototype Brief](./_template/project-pack/05_Prototype%20Brief.md) | 프로토타입이 증명할 것·데모 플로우·미검증 질문 정의 |
| 06 | [Prototype Review](./_template/project-pack/06_Prototype%20Review.md) | 프로토타입 결과 평가 — 일치/누락/모호 판단 |
| 07 | [Decision Log](./_template/project-pack/07_Decision%20Log.md) | 의사결정 추적 (ID·날짜·상태·근거) |
| 08 | [Task Item](./_template/project-pack/08_Task%20Item.md) | 개별 태스크 — 근거·소유자·우선순위·Todoist 연동 |
| 09 | [Batch Run](./_template/project-pack/09_Batch%20Run.md) | 오케스트레이터 배치 실행 — 태스크 보드·브랜치 정보 |

### 🔧 커맨드 보일러플레이트 (`_template/skill-name/`)

새 커맨드를 만들 때 참고할 수 있는 파일 골격입니다.

---

## 커맨드 파일 형식

각 커맨드는 `.claude/commands/<flat-name>.md` 파일입니다.

```markdown
---
description: "Claude가 이 커맨드를 어떤 상황에서 쓰는지 설명합니다."
---

# 커맨드 이름

## 목적
...
```

**파일명 = 슬래시 명령어**:
- 파일: `.claude/commands/work-git-start.md` → 호출: `/work-git-start`
- 파일: `.claude/commands/work-ai-project_skill_kickoff.md` → 호출: `/work-ai-project_skill_kickoff`

---

## 설치하기 (전역 — 모든 프로젝트에 적용)

`~/.claude/commands/` 에 설치하면 **모든 프로젝트에서 자동으로 커맨드가 인식**됩니다.

```bash
# 1. 레포 클론 (한 번만)
git clone https://github.com/JoNaYeon/claude-code-skills.git ~/claude-code-skills

# 2. 설치 스크립트 실행
cd ~/claude-code-skills
bash install.sh
```

이후 레포에 새 커맨드가 추가되면:
```bash
cd ~/claude-code-skills && git pull
bash install.sh
```

---

## 설치하기 (프로젝트별)

특정 프로젝트에만 넣고 싶을 때:

```bash
mkdir -p /path/to/your-project/.claude/commands
cp .claude/commands/work-coding-code_review.md /path/to/your-project/.claude/commands/
```

---

## 새 커맨드 만들기

1. **네이밍 규칙**
   - `{카테고리}-{서브카테고리}-{스킬_이름}` (flat)
   - 카테고리 구분: `-`, 스킬 이름 단어 구분: `_`

2. **파일 생성**
   ```bash
   # 예: 업무용 코딩 영역에 "type_check" 커맨드 추가
   touch .claude/commands/work-coding-type_check.md
   ```

3. **내용 작성**
   ```markdown
   ---
   description: "커맨드 설명"
   ---

   # 커맨드 이름

   ## 지침
   ...
   ```

4. **README에 한 줄 추가** (해당 카테고리 테이블에)

5. **커밋 & 푸시**

---

## 폴더 구조

```
claude-code-skills/
├── .claude/commands/                  # 슬래시 커맨드
│   ├── work-ai-*.md                   #   업무용 AI/PM (9)
│   ├── work-coding-*.md               #   업무용 코딩 (7)
│   ├── work-docs-*.md                 #   업무용 문서화 (3)
│   ├── work-git-*.md                  #   업무용 Git (7)
│   ├── work-devops-*.md               #   업무용 DevOps (1)
│   ├── work-testing-*.md              #   업무용 테스트 (1)
│   ├── work-reporting-*.md            #   업무 보고 (1)
│   ├── daily-*.md                     #   일상용 (1)
│   ├── misc-navigation-*.md           #   메뉴 라우터 (6)
│   ├── intake/                        #   콘텐츠 인테이크 (서브디렉터리)
│   └── research/                      #   리서치 (서브디렉터리)
├── _template/                         # 템플릿 모음
│   ├── notes/                         #   Obsidian 노트 템플릿
│   ├── project-pack/                  #   PM 라이프사이클 문서
│   └── skill-name/                    #   커맨드 보일러플레이트
├── install.sh                         # 전역 설치 스크립트
├── LICENSE
└── README.md
```

---

## License

MIT
